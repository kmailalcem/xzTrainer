//
//  TimerVCTableDelegate.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/20/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit


extension TimerVC: UITableViewDelegate {
    
    @objc func deletedCurrentSession() {
        tableView(sessionTable, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
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
        if tableView is ResultTableView {
            let delete = UITableViewRowAction(style: .normal, title: "Delete") {_,_ in
                self.data.deleteSolve(atIndex: self.data.backIndex(indexPath.row))
                self.resultTable.reloadData()
            }
            delete.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
            return [delete]
        } else if tableView is SessionTableView && indexPath.row > 0 {
            let delete = UITableViewRowAction(style: .normal, title: "Delete") {_,_ in
                self.data.deleteSession(atIndex: indexPath.row)
                self.resultTable.reloadData()
                self.sessionTable.reloadData()
            }
            delete.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
            return [delete]
        }
        return []
    }
}
