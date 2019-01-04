//
//  SpreadsheetViewController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/4/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SpreadsheetViewController: ThemeViewController, UITableViewDelegate {

    @IBOutlet weak var spreadsheetTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var spreadsheet: Spreadsheet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spreadsheetTable.dataSource = spreadsheet
        spreadsheetTable.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        spreadsheet.select(indexPath.section, indexPath.row)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
