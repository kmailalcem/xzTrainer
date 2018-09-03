//
//  EditThemeVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 9/3/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class EditThemeVC: ThemeViewController {

    @IBOutlet weak var themeEditTable: UITableView!
    var allThemes = [Theme.defaultTheme, Theme.pinkTheme, Theme.whiteTheme]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeEditTable.delegate = self
        themeEditTable.dataSource = self
    }

}

extension EditThemeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
        headerView.autoresizingMask = []
        let title = ThemeHeader1(frame: CGRect(x: 16, y: 0, width: tableView.bounds.size.width - 16, height: 50))
        title.autoresizingMask = []
        if section == 0 {
            title.text = LocalizationTheme.color.localized
        } else {
            title.text = LocalizationTheme.shadow.localized
        }
        headerView.addSubview(title)
        headerView.backgroundColor = Theme.current.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeSelectionCell") as! ThemeSelectionCell
        if indexPath.section == 0 {
            let selectedTheme = allThemes[indexPath.row]
            cell.configureCell(name: selectedTheme.name, theme: allThemes[indexPath.row])
        } else {
            switch indexPath.row {
            case 0:
                cell.configureCell(name: LocalizationTheme.none.localized, shadowOpacity: 0)
            case 1:
                cell.configureCell(name: LocalizationTheme.light.localized, shadowOpacity: 0.25)
            case 2:
                cell.configureCell(name: LocalizationTheme.heavy.localized, shadowOpacity: 0.75)
            default:
                cell.configureCell(name: "Full", shadowOpacity: 1)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            Theme.current = allThemes[indexPath.row]
        } else {
            switch indexPath.row {
            case 0:
                Theme.current.shadowOpacity = 0
            case 1:
                Theme.current.shadowOpacity = 0.25
            case 2:
                Theme.current.shadowOpacity = 0.75
            default:
                Theme.current.shadowOpacity = 1
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
        tableView.reloadData()
    }
}
