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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewHeight: CGFloat = 40
        let headerView = RoundedView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: headerViewHeight))
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width - 16, height: headerViewHeight))
        title.text = tableView.dataSource!.tableView!(tableView, titleForHeaderInSection: section)
        title.textColor = Theme.current.headerTextColor
        title.font = UIFont.systemFont(ofSize: 35, weight: .medium)
        title.textAlignment = .center
        headerView.addSubview(title)
        headerView.backgroundColor = Theme.current.lighterBackgroundColor
        headerView.cornerRadius = 10
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
