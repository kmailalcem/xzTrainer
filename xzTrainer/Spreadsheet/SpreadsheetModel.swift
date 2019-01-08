//
//  SpreadSheetModel.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/4/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit
import CoreData

func createSpreadsheet(fromManagedObject spreadsheetMO: SpreadsheetMO) -> Spreadsheet? {
    switch spreadsheetMO.type! {
    case "AlgSheet":
        let algSheetMO = spreadsheetMO as! AlgSheetMO
        if algSheetMO.faceCount == 2 {
            return AlgSheet<EdgeSticker>(fromManagedObject: algSheetMO)
        } else {
            return AlgSheet<CornerSticker>(fromManagedObject: algSheetMO)
        }
    default: return nil
    }
}

class SpreadsheetModel: NSObject {
    // MARK: - Singleton
    public static var shared: SpreadsheetModel{
        if _shared == nil {
            _shared = SpreadsheetModel()
        }
        return _shared!
    }
    
    private override init() {
        super.init()
        let fetchRequest = NSFetchRequest<SpreadsheetMO>(entityName: "SpreadsheetMO")
        var sheetsMO: [SpreadsheetMO]!
        do {
            sheetsMO = try managedObjectContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        spreadsheets = sheetsMO.map({ (spreadsheetMO) -> Spreadsheet in
            return createSpreadsheet(fromManagedObject: spreadsheetMO)!
        })
        
    }
    
    public func newAlgSheet() {
        let tempCornerSheet = AlgSheet(name: "UFL Corners", buffer: CornerSticker.UFL, rowIndices: CornerSticker.allValues.removeBuffer(.UFL), columnIndices: CornerSticker.allValues.removeBuffer(.UFL))
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            tempCornerSheet.set(alg: "R2 : [ R U R', D2 ]", 0, 6)
            tempCornerSheet.set(association: "disco", 0, 6)
            self.spreadsheets.append(tempCornerSheet)
            self.spreadsheets.append(AlgSheet(name: "DF Edges", buffer: EdgeSticker.DF, rowIndices: EdgeSticker.allValues.removeBuffer(.DF), columnIndices: EdgeSticker.allValues.removeBuffer(.DF)))
            self.notifyNewSheet()
        })
        
    }
    
    private func notifyNewSheet() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "createdSheet"), object: nil)
    }
    
    private static var _shared: SpreadsheetModel? = nil
    private let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // MARK: - Privates
    var spreadsheets: [Spreadsheet] = []
}

extension SpreadsheetModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spreadsheets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectSpreadsheetCell") as! SelectSpreadsheetCell
        cell.configureCell(name: spreadsheets[indexPath.row].name)
        
        return cell
    }
    
}
