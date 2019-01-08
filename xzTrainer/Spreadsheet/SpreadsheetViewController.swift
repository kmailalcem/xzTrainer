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
        NotificationCenter.default.addObserver(self, selector: #selector(SpreadsheetViewController.updateTable), name: NSNotification.Name(rawValue: "Spreadsheet Updated"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateTable() {
        spreadsheetTable.reloadData()
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        // so that the correct scene is shown
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        spreadsheet.delegatedSegue(self, indexPath.section, indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewHeight: CGFloat = 40
        let headerView = RoundedView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: headerViewHeight - 5))
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width - 16, height: headerViewHeight))
        title.text = tableView.dataSource!.tableView!(tableView, titleForHeaderInSection: section)
        title.textColor = Theme.current.headerTextColor
        title.font = UIFont.systemFont(ofSize: 35, weight: .medium)
        title.textAlignment = .center
        headerView.addSubview(title)
        headerView.backgroundColor = Theme.current.lighterBackgroundColor
        headerView.cornerRadius = 10
        headerView.shadowRadius = 3
        headerView.shadowOffsetHeight = 5
        headerView.shadowOpacity = Float(Theme.current.shadowOpacity / 2)
        return headerView
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
