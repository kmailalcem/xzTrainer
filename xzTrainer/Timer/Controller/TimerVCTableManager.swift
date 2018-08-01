//
//  TimerVCTableDelegate.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/20/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

func makeConfirm(title: String = "Are you sure?" , message: String, handler: @escaping (UIAlertAction) -> Void) -> ThemeAlertController {
    let alert = ThemeAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handler))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    return alert
}

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
        } else if tableView is SessionTableView {
            let delete = UITableViewRowAction(style: .normal, title: "Delete") {_,_ in
                let alert = makeConfirm(message: "This will clear all the solves in this session and delete this session.", handler: { (_) in
                    self.data.deleteSession(atIndex: indexPath.row)
                    self.resultTable.reloadData()
                    self.sessionTable.reloadData()
                })
                self.present(alert, animated: true)
            }
            delete.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
            
            let clear = UITableViewRowAction(style: .normal, title: "Clear") { (_, _) in
                let alert = makeConfirm(message: "This will clear all the solves in this session.", handler: { (_) in
                    self.data.clearSession(atIndex: indexPath.row)
                    self.resultTable.reloadData()
                    self.sessionTable.reloadData()
                })
                self.present(alert, animated: true)
            }
            clear.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
            
            let rename = UITableViewRowAction(style: .normal, title: "Rename") { (_, _) in
                let alert = ThemeAlertController(title: "Rename Session", message: "Enter the new name for this session.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
                    let newName = alert.textFields?.first?.text!
                    if newName != nil && newName != "" {
                        self.data.renameSession(atIndex: indexPath.row, to: newName!)
                        self.sessionTextField.text = newName
                    }
                    self.sessionTable.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addTextField { (textField) in
                    textField.placeholder = "New name"
                }
                self.present(alert, animated: true)
            }
            rename.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.2941176471, blue: 0.4352941176, alpha: 1)
            
            if indexPath.row > 0 {
                return [delete, rename, clear]
            } else {
                return [rename, clear]
            }
        }
        return []
    }
}
