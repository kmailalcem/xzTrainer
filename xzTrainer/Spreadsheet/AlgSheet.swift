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
        algs.reserveCapacity(rowIndices.count)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return algs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algs[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    private var algs : [[(alg: String, assoc: String)]] = []
    private var rowIndices : [T] = []
    private var columnIndices : [T] = []
    private var _name : String = ""
    private var _buffer : T
}
