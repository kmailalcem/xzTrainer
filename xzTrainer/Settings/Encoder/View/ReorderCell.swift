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
    var index : Int!
    
    var isFirst: Bool {
        return targetEdgeSticker == nil && targetCornerSticker == nil
    }
    var isEdge: Bool!
    
    @IBAction func increment() {
        if isEdge {
                UserSetting.shared.encoder.incrementEdge(at: index, forStarting: targetEdgeSticker)
        } else {
           UserSetting.shared.encoder.incrementCorner(at: index, forStarting: targetCornerSticker)
        }
        containerTableView.reloadData()
        
    }
    
    @IBAction func decrement() {
        if isEdge {
            UserSetting.shared.encoder.decrementEdge(at: index, forStarting: targetEdgeSticker)
        } else {
            UserSetting.shared.encoder.decrementCorner(at: index, forStarting: targetCornerSticker)
        }
        containerTableView.reloadData()
    }
    
    @IBAction func top() {
        if isEdge {
            UserSetting.shared.encoder.moveEdgeToTop(atIndex: index, forFirstLetter: targetEdgeSticker)
        } else {
            UserSetting.shared.encoder.moveCornerToTop(atIndex: index, forFirstLetter: targetCornerSticker)
        }
        containerTableView.reloadData()
    }
    
    @IBAction func buttom() {
        if isEdge {
            UserSetting.shared.encoder.moveEdgeToBottom(atIndex: index, forFirstLetter: targetEdgeSticker)
        } else {
            UserSetting.shared.encoder.moveCornerToBottom(atIndex: index, forFirstLetter: targetCornerSticker)
        }
        containerTableView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(withTarget edge1: EdgeSticker?, forEdge edge2: EdgeSticker, in table: UITableView, at i: Int) {
        isEdge = true
        targetEdgeSticker = edge1
        containerTableView = table
        let letter = UserSetting.shared.general.letterScheme.edgeScheme[edge2]!
        if letter.count > 0 {
            letterLabel.text = letter
        } else {
            letterLabel.text = "(buffer)"
        }
        
        index = i
    }
    
    func configureCell(withTarget corner1: CornerSticker?, forCorner corner2: CornerSticker, in table: UITableView, at i: Int) {
        isEdge = false
        targetCornerSticker = corner1
        containerTableView = table
        let letter = UserSetting.shared.general.letterScheme.cornerScheme[corner2]!
        if letter.count > 0 {
            letterLabel.text = letter
        } else {
            letterLabel.text = "(buffer)"
        }
        index = i
    }
}
