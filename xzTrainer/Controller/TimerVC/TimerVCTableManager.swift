//
//  TimerVCTableDelegate.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/20/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit


extension TimerVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView is ResultTableView {
            configurePopUp(indexPath: indexPath)
            animatePopUpIn()
            return
        }
        sessionTextField.text =
            (tableView.cellForRow(at: indexPath) as? SessionCell)?.sessionNameLabel.text!
        data.reloadSolve(forSessionAtIndex: indexPath.row)
        sessionTablePopOut()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView is ResultTableView) ? 60 : 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") {_,_ in
            self.data.deleteSolve(atIndex: self.data.backIndex(indexPath.row))
            self.resultTable.reloadData()
        }
        
        delete.backgroundColor = .red
        return [delete]
    }
}
