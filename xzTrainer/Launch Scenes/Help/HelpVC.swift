//
//  HelpVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/8/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    let icons: [HelpedIcon] = [
        HelpedIcon(image: #imageLiteral(resourceName: "Plus"), wikiName: "+", explanation: "In timer: show more options.\nSelecting sessions: new session."),
        HelpedIcon(image: #imageLiteral(resourceName: "Show"), wikiName: "show", explanation: "Reveal scrambles and memo. You won't have a reaction time after you reveal the memo." ),
        HelpedIcon(image: #imageLiteral(resourceName: "ManuallyEnterTime"), wikiName: "numpad", explanation: "Manually enter time. In execution training, only shown after revealed memo and scramble. '.' means ':' for minutes, but please don't go to hours."),
        HelpedIcon(image: #imageLiteral(resourceName: "NextScramble"), wikiName: "arrow", explanation: "Next Scramble"),
        HelpedIcon(image: #imageLiteral(resourceName: "Settings"), wikiName: "gear", explanation: "Show memo generation settings."),
        HelpedIcon(image: #imageLiteral(resourceName: "Back"), wikiName: "back", explanation: "Go back to the previous screen."),
        HelpedIcon(image: #imageLiteral(resourceName: "Top"), wikiName: "top", explanation: "Send to the front of cycle break priority list."),
        HelpedIcon(image: #imageLiteral(resourceName: "Up"), wikiName: "up", explanation: "Move letter one position forward in cycle break priority list."),
        HelpedIcon(image: #imageLiteral(resourceName: "Down"), wikiName: "down", explanation: "Move letter one position backward in cycle break priority list."),
        HelpedIcon(image: #imageLiteral(resourceName: "Bottom"), wikiName: "bottom", explanation: "Send to the back of cycle break priority list.")
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
