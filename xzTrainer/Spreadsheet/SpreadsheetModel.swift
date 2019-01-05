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
        let tempCornerSheet = AlgSheet(name: "UFL Corners", buffer: CornerSticker.UFL, rowIndices: CornerSticker.allValues.removeBuffer(.UFL), columnIndices: CornerSticker.allValues.removeBuffer(.UFL))
        tempCornerSheet.set(alg: "R2 : [R U R', D2]", 0, 6)
        tempCornerSheet.set(association: "disco", 0, 6)
        spreadsheets.append(tempCornerSheet)
        spreadsheets.append(AlgSheet(name: "DF Edges", buffer: EdgeSticker.DF, rowIndices: EdgeSticker.allValues.removeBuffer(.DF), columnIndices: EdgeSticker.allValues.removeBuffer(.DF)))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectSpreadsheetCell") as! SelectSpreadsheetCell
        cell.configureCell(name: spreadsheets[indexPath.row].name)
        
        return cell
    }
    
}
