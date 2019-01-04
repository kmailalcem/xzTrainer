//
//  SelectSheetViewController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/4/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SelectSheetViewController: ThemeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        spreadsheetsTable.dataSource = SpreadsheetModel.shared
    }
    

    @IBOutlet weak var spreadsheetsTable: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
