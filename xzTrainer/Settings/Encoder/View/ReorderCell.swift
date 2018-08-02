//
//  ReorderCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/2/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class ReorderCell: UITableViewCell {
    
    @IBOutlet weak var letterLabel: UILabel!
    weak var containerTableView: UITableView!
    var targetEdgeSticker: EdgeSticker?
    var targetCornerSticker: CornerSticker?
    
    @IBAction func increment() {
        print("increment")
        containerTableView.reloadData()
        
    }
    
    @IBAction func decrement() {
        print("decrement")
        containerTableView.reloadData()
    }
    
    @IBAction func top() {
        print("top")
        containerTableView.reloadData()
    }
    
    @IBAction func buttom() {
        print("buttom")
        containerTableView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(forEdge edge: EdgeSticker, in table: UITableView) {
        targetEdgeSticker = edge
        containerTableView = table
        letterLabel.text = UserSetting.shared.general.letterScheme.edgeScheme[targetEdgeSticker!]!
    }
    
    func configureCell(forCorner corner: CornerSticker, in table: UITableView) {
        targetCornerSticker = corner
        containerTableView = table
        letterLabel.text = UserSetting.shared.general.letterScheme.cornerScheme[targetCornerSticker!]!
    }
}
