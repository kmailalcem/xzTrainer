//
//  AlgSheet.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/4/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

class AlgSheet<T: CubePiece> : NSObject, Spreadsheet {
    init(name: String, buffer: T, rowIndices: [T], columnIndices: [T]) {
        _name = name
        _buffer = buffer
        self.rowIndices = rowIndices
        self.columnIndices = columnIndices
        algs = Array(repeating: Array(repeating: (alg: "", assoc: ""), count: columnIndices.count), count: rowIndices.count)
        
    }
    
    var name : String {
        return _name
    }
    
    var type : String {
        return "Alg Sheet"
    }
    
    func select(_ m: Int, _ n: Int) {
        print("Should be a segue here")
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
        let expandedAlg = parse(alg: alg)?.inversed.string
        algs[inverseM!][inverseN!].alg = expandedAlg!
        
    }
    
    func set(association: String, _ m: Int, _ n: Int) {
        algs[m][n].assoc = association
    }
    
    func alg(_ m: Int, _ n: Int) -> String {
        return algs[m][n].alg
    }
    
    func association(_ m: Int, _ n: Int) -> String {
        return algs[m][n].assoc
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return algs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algs[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlgCell") as! AlgCell
        cell.configureCell(cycle: letterOf(rowIndices[indexPath.section]) + letterOf(columnIndices[indexPath.row]), alg: algs[indexPath.section][indexPath.row].alg, association: algs[indexPath.section][indexPath.row].assoc)
        return cell
    }
    
    private var algs : [[(alg: String, assoc: String)]] = []
    private var rowIndices : [T] = []
    private var columnIndices : [T] = []
    private var _name : String = ""
    private var _buffer : T
}
