//
//  AlgSheet.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/4/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit
import CoreData

private func substrToCubePiece<T: CubePiece>(_ substr: Substring) -> T {
    return T.init(rawValue: Int(substr)!)!
}
private func concatCubePieceToStr<T: CubePiece>(_ result: String, _ piece: T) -> String {
    return result + String(piece.rawValue) + " "
}

fileprivate let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class AlgSheet<T: CubePiece> : NSObject, Spreadsheet {
    func save() {
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    init(name: String, buffer: T, rowIndices: [T], columnIndices: [T]) {
        _name = name
        _buffer = buffer
        self.rowIndices = rowIndices
        self.columnIndices = columnIndices
        let algSheetMO = AlgSheetMO(context: managedObjectContext)
        algSheetMO.name = name
        algSheetMO.buffer = Int16(buffer.rawValue)
        algSheetMO.faceCount = Int16(T.faceCount)
        algSheetMO.type = "AlgSheet"
        algSheetMO.id = Int32(Date().timeIntervalSince1970)
        algSheetMO.rowIndices = rowIndices.reduce("", concatCubePieceToStr)
        algSheetMO.columnIndices = columnIndices.reduce("", concatCubePieceToStr)
        for i in 0 ..< rowIndices.count {
            let row = AlgRowMO(context: managedObjectContext)
            row.index = Int32(i)
            row.table = algSheetMO
            algSheetMO.rows?.adding(row)
            algs.append([])
            for j in 0 ..< columnIndices.count {
                let entry = AlgEntryMO(context: managedObjectContext)
                entry.index = Int32(j)
                entry.alg = ""
                entry.assoc = ""
                entry.row = row
                algs[i].append(entry)
            }
        }
        managedObject = algSheetMO
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    init?(fromManagedObject algSheetMO: AlgSheetMO) {
        managedObject = algSheetMO
        _name = algSheetMO.name!
        _buffer = T.init(rawValue: Int(algSheetMO.buffer))!
        rowIndices = algSheetMO.rowIndices!.split(separator: " ").map(substrToCubePiece)
        columnIndices = algSheetMO.columnIndices!.split(separator: " ").map(substrToCubePiece)
        var algRows : [AlgRowMO]!
        let fetchRequest = NSFetchRequest<AlgRowMO>(entityName: "AlgRowMO")
        let predicate = NSPredicate(format: "table.id = %ld", algSheetMO.id)
        fetchRequest.predicate = predicate
        do {
            algRows = try managedObjectContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        
        algs = Array(repeating: [], count: rowIndices.count)

        for row in algRows {
            let entryFetchRequest = NSFetchRequest<AlgEntryMO>(entityName: "AlgEntryMO")
            let entryPredicate = NSPredicate(format: "row.index = %ld AND row.table.id = %ld", row.index, algSheetMO.id)
            entryFetchRequest.predicate = entryPredicate
            var entries : [AlgEntryMO]!
            do {
                entries = try managedObjectContext.fetch(entryFetchRequest)
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
            entries.sort { (lhs, rhs) -> Bool in
                return lhs.index < rhs.index
            }
            algs[Int(row.index)] = entries
        }
    }
    
    deinit {
        save()
    }
    
    var name : String {
        return _name
    }
    
    var type : String {
        return "Alg Sheet"
    }
    
    func delegatedSegue(_ viewController: ThemeViewController, _ m: Int, _ n: Int){
        mostRecentSelection = (m: m, n: n)
        let storyboard = UIStoryboard(name: "Spreadsheet", bundle: nil)
        let algEditorVC = storyboard.instantiateViewController(withIdentifier: "AlgEditorViewController") as! AlgEditorViewController
        algEditorVC.letterPairName = letterPairNameAt(m, n)
        algEditorVC.storedAlgorithm = alg(m, n)
        algEditorVC.storedAssociation = association(m, n)
        algEditorVC.onSavingNewAlg = setAlg
        algEditorVC.onSavingNewAssociation = setAssociation
        let segue = SegueRightToLeft(identifier: "toAlgEditor", source: viewController, destination: algEditorVC)
        segue.perform()
    }
    
    private func letterPairNameAt(_ m: Int, _ n: Int) -> String {
        return letterOf(rowIndices[m]) + letterOf(columnIndices[n])
    }
    
    func setAlg(_ alg: String) {
        do {
            let alg = try parse(alg: alg)
            checkAlg(alg)
            set(alg: alg.string, mostRecentSelection!.m, mostRecentSelection!.n)
            print(alg.string)
        } catch XZError.error(let msg) {
            print(msg)
        } catch let error {
            print(error)
        }
    }
    
    private func checkAlg(_ alg: Algorithm) {
        
    }
    
    func setAssociation(_ association: String) {
        set(association: association, mostRecentSelection!.m, mostRecentSelection!.n)
    }
    
    func set(alg: String, _ m: Int, _ n: Int) {
        algs[m][n].alg = alg
        let inverseM = rowIndices.firstIndex { (piece: T) -> Bool in
            return piece.rawValue == columnIndices[n].rawValue
        }
        let inverseN = columnIndices.firstIndex { (piece: T) -> Bool in
            return piece.rawValue == rowIndices[n].rawValue
        }
        if inverseM == nil || inverseN == nil || algs[inverseM!][inverseN!].alg != ""{
            return
        }
        do {
            let expandedAlg = try parse(alg: alg).inversed.string
            algs[inverseM!][inverseN!].alg = expandedAlg
        } catch let error {
            print(error)
        }
        save()
        notifyUpdate()
    }
    
    private func notifyUpdate() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "Spreadsheet Updated")))
    }
    
    func set(association: String, _ m: Int, _ n: Int) {
        algs[m][n].assoc = association
        save()
        notifyUpdate()
    }
    
    func alg(_ m: Int, _ n: Int) -> String {
        return algs[m][n].alg!
    }
    
    func association(_ m: Int, _ n: Int) -> String {
        return algs[m][n].assoc!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return algs.count
    }
    
    // MARK: - TableViewDataSource functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algs[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlgCell") as! AlgCell
        cell.configureCell(cycle: letterOf(rowIndices[indexPath.section]) + letterOf(columnIndices[indexPath.row]), alg: alg(indexPath.section, indexPath.row), association: association(indexPath.section, indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return letterOf(rowIndices[section])
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return rowIndices.map({ (piece) -> String in
            return letterOf(piece)
        })
    }
    
    private var managedObject: AlgSheetMO
    private var algs : [[AlgEntryMO]] = []
    private var rowIndices : [T] = []
    private var columnIndices : [T] = []
    private var _name : String = ""
    private var _buffer : T
    private var mostRecentSelection: (m: Int, n: Int)?

}
