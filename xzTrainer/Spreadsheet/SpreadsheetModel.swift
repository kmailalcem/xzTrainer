//
//  SpreadSheetModel.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/4/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

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
        spreadsheets.append(AlgSheet(name: "UFL Corners", buffer: CornerSticker.UFL, rowIndices: CornerSticker.allValues, columnIndices: CornerSticker.allValues))
    }
    
    private static var _shared: SpreadsheetModel? = nil
    
    // MARK: - Privates
    var spreadsheets: [Spreadsheet] = []
}

extension SpreadsheetModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spreadsheets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
