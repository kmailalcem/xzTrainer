//
//  HelpVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/8/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class HelpVC: ThemeViewController {

    let icons: [HelpedIcon] = [
        HelpedIcon(image: #imageLiteral(resourceName: "Plus"), wikiName: "+", explanation: LocalizationHelp.plus.localized),
        HelpedIcon(image: #imageLiteral(resourceName: "Show"), wikiName: "show", explanation: LocalizationHelp.show.localized ),
        HelpedIcon(image: #imageLiteral(resourceName: "ManuallyEnterTime"), wikiName: "numpad", explanation: LocalizationHelp.numpad.localized),
        HelpedIcon(image: #imageLiteral(resourceName: "NextScramble"), wikiName: "arrow", explanation: LocalizationHelp.arrow.localized),
        HelpedIcon(image: #imageLiteral(resourceName: "Settings"), wikiName: "gear", explanation: LocalizationHelp.gear.localized),
        HelpedIcon(image: #imageLiteral(resourceName: "Back"), wikiName: "back", explanation: LocalizationHelp.back.localized),
        HelpedIcon(image: #imageLiteral(resourceName: "Top"), wikiName: "top", explanation: LocalizationHelp.top.localized),
        HelpedIcon(image: #imageLiteral(resourceName: "Up"), wikiName: "up", explanation: LocalizationHelp.up.localized),
        HelpedIcon(image: #imageLiteral(resourceName: "Down"), wikiName: "down", explanation: LocalizationHelp.down.localized),
        HelpedIcon(image: #imageLiteral(resourceName: "Bottom"), wikiName: "bottom", explanation: LocalizationHelp.bottom.localized)
    ]
    
    @IBOutlet weak var helpTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpTable.delegate = self
        helpTable.dataSource = self
        helpTable.rowHeight = UITableViewAutomaticDimension
        helpTable.estimatedRowHeight = 40
    }

    @IBAction func goToWiki() {
        openUrl("https://github.com/kmailalcem/xzTrainer/wiki")
    }
}

extension HelpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell") as! HelpCell
        cell.configureCell(helpedIcon: icons[indexPath.row])
        return cell
    }
}
