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
    
    var isEdge: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()

        priorityTable.delegate = self
        priorityTable.dataSource = self
        
        if targetCornerPiece != nil {
            titleLabel.text = "Corner \(UserSetting.shared.general.letterScheme.cornerScheme[targetCornerPiece!]!)"
        } else if targetEdgePiece != nil {
            titleLabel.text = "Edge \(UserSetting.shared.general.letterScheme.edgeScheme[targetEdgePiece!]!)"
        } else if isEdge {
            titleLabel.text = "First Edge Letter"
        } else {
            titleLabel.text = "First Corner Letter"
        }
        
    }


}

extension ReorderPriorityVC: UITableViewDelegate, UITableViewDataSource {
    private func removeBuffer(_ edges: [EdgeSticker]) -> [EdgeSticker]{
        var edges = edges
        for i in edges.count - 1 ... 0 {
            if edges[i].rawValue / 2 == UserSetting.shared.general.edgeBuffer.rawValue / 2 {
                edges.remove(at: i)
            }
        }
        return edges
    }
    
    private func removeBuffer(_ corners: [CornerSticker]) -> [CornerSticker]{
        var corners = corners
        for i in corners.count - 1 ... 0 {
            if corners[i].rawValue / 3 == UserSetting.shared.general.cornerBuffer.rawValue / 3 {
                corners.remove(at: i)
            }
        }
        return corners
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if targetEdgePiece != nil {
            return NUM_STICKERS
        } else if targetCornerPiece != nil {
            return NUM_STICKERS
        } else if isEdge {
            return NUM_STICKERS
        } else {
            return NUM_STICKERS
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReorderCell") as! ReorderCell
        if targetCornerPiece != nil {
            let secondCorner = UserSetting.shared.encoder.userPreference.cornerPreferenceAsSecondLetter[targetCornerPiece!]![indexPath.row]
            cell.configureCell(withTarget: targetCornerPiece!, forCorner: secondCorner, in: priorityTable, at: indexPath.row)
        } else if targetEdgePiece != nil {
            let secondEdge = UserSetting.shared.encoder.userPreference.edgePreferenceAsSecondLetter[targetEdgePiece!]![indexPath.row]
            cell.configureCell(withTarget: targetEdgePiece!, forEdge: secondEdge, in: priorityTable, at: indexPath.row)
        } else if isEdge {
            let firstEdge = UserSetting.shared.encoder.userPreference.edgePreferenceAsFirstLetter[indexPath.row]
            cell.configureCell(withTarget: nil, forEdge: firstEdge, in: priorityTable, at: indexPath.row)
        } else {
            let firstCorner = UserSetting.shared.encoder.userPreference.cornerPreferenceAsFirstLetter[indexPath.row]
            cell.configureCell(withTarget: nil, forCorner: firstCorner, in: priorityTable, at: indexPath.row)
        }
        return cell
    }

}
