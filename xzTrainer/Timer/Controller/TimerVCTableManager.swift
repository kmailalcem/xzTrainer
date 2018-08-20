//
//  TimerVCTableDelegate.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

func makeConfirm(title: String = "Are you sure?" , message: String, handler: @escaping (UIAlertAction) -> Void) -> ThemeAlertController {
    let alert = ThemeAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handler))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    return alert
}

extension TimerVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is ResultTableView {
            if scrollView.contentOffset.y < -70 {
                resultTableView.hideResultTable()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView is ResultTableView {
            popUpDetailView.configurePopUp(indexPath: indexPath)
            animatePopUpIn()
            return
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") {_,_ in
            self.data.deleteSolve(atIndex: self.data.backIndex(indexPath.row))
            self.resultTableView.resultTable.reloadData()
        }
        delete.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
        return [delete]
    }
}
