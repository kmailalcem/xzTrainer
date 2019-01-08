//
//  SelectSheetViewController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/4/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SelectSheetViewController: ThemeViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        spreadsheetsTable.delegate = self
        spreadsheetsTable.dataSource = SpreadsheetModel.shared
        NotificationCenter.default.addObserver(self, selector: #selector(SelectSheetViewController.reload), name: Notification.Name(rawValue: "createdSheet"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func newSheet() {
        SpreadsheetModel.shared.newAlgSheet()
    }
    
    @objc private func reload() {
        spreadsheetsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "toIndividualSheet", sender: SpreadsheetModel.shared.spreadsheets[indexPath.row])
    }
    
    @IBOutlet weak var spreadsheetsTable: UITableView!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SpreadsheetViewController, let sheet = sender as? Spreadsheet {
            destination.spreadsheet = sheet
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        // so that the correct scene is shown
    }

}
