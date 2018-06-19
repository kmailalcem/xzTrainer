//
//  TimerVCTableDelegate.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/20/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

extension TimerVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSolves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTable.dequeueReusableCell(
            withIdentifier: "ResultCell", for: indexPath)
        if let resultCell = cell as? ResultCell {
            resultCell.configureCell(index: userSolves.count - indexPath.row - 1,
                                     solveStats: userSolves)
            let newView = UIView()
            let extractedExpr: UIColor = UIColor(red: 0x92/255 ,
                                                 green: 0xa6/255,
                                                 blue:0xbe/255,
                                                 alpha: 1)
            newView.backgroundColor = extractedExpr
            resultCell.selectedBackgroundView? = newView
            return resultCell
        }
        return UITableViewCell()
    }
}

extension TimerVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        configurePopUp(indexPath: indexPath)
        animatePopUpIn()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") {_,_ in
            self.deleteSolve(atIndex: self.userSolves.count - indexPath.row - 1)
            self.resultTable.reloadData()
        }
        
        delete.backgroundColor = .red
        return [delete]
    }
}
