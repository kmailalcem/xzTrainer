//
//  PriorityVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/1/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class ReorderPriorityVC: UIViewController {

    @IBOutlet weak var priorityTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var targetEdgePiece: EdgeSticker?
    var targetCornerPiece: CornerSticker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        priorityTable.delegate = self
        priorityTable.dataSource = self
        
        if targetCornerPiece != nil {
            titleLabel.text = "Corner \(UserSetting.shared.general.letterScheme.cornerScheme[targetCornerPiece!]!)"
        } else if targetEdgePiece != nil {
            titleLabel.text = "Edge \(UserSetting.shared.general.letterScheme.edgeScheme[targetEdgePiece!]!)"
        }
        
    }


}

extension ReorderPriorityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NUM_STICKERS
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReorderCell") as! ReorderCell
        if targetCornerPiece != nil {
            let secondCorner = UserSetting.shared.encoder.userPreference.cornerPreferenceAsSecondLetter[targetCornerPiece!]![indexPath.row]
            cell.configureCell(forCorner: secondCorner, in: priorityTable)
        }
        if targetEdgePiece != nil {
            let secondEdge = UserSetting.shared.encoder.userPreference.edgePreferenceAsSecondLetter[targetEdgePiece!]![indexPath.row]
            cell.configureCell(forEdge: secondEdge, in: priorityTable)
        }
        return cell
    }
    
    
}
