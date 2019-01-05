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
        titleLabel.text = spreadsheet.name
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
