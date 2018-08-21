//
//  SessionView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SessionView: UIView, UITableViewDelegate {
    
    var sessionTable: SessionTableView!
    var dismissButton: UIButton!
    var newSessinButton: FloatingActionButton!
    var data = GlobalData.shared
    var rootViewController: TimerVC!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        dismissButton = UIButton(frame: self.frame)
        dismissButton.backgroundColor = .white
        dismissButton.alpha = 0.5
        sessionTable = SessionTableView(frame: CGRect(x: frame.minX + 50, y: frame.minY + 50, width: frame.width - 100, height: frame.height - 100))
        sessionTable.backgroundColor = .clear
        sessionTable.separatorStyle = .none
        sessionTable.delegate = self
        sessionTable.dataSource = data
        
        newSessinButton = FloatingActionButton(frame: CGRect(x: self.center.x - 28, y: self.sessionTable.frame.maxY - 28, width: 56, height: 56))
        newSessinButton.size = 56
        newSessinButton.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
        
        addSubview(dismissButton)
        addSubview(sessionTable)
        addSubview(newSessinButton)
        
        dismissButton.addTarget(self, action: #selector(SessionView.dismiss), for: .touchUpInside)
        newSessinButton.addTarget(self, action: #selector(SessionView.newSession), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SessionView.deletedCurrentSession), name: NSNotification.Name(rawValue: "DeletedCurrentSession"), object: nil)
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (success) in
            self.transform = .identity
            self.removeFromSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SessionNameNeedsUpdate"), object: indexPath.row)
        data.reloadSolve(forSessionAtIndex: indexPath.row)
        dismiss()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete", handler: deleteSession)
        delete.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
        
        let clear = UITableViewRowAction(style: .normal, title: "Clear", handler: clearSession)
        clear.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
        
        let rename = UITableViewRowAction(style: .normal, title: "Rename", handler: renameSession)
        rename.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.2941176471, blue: 0.4352941176, alpha: 1)
        
        if indexPath.row > 0 {
            return [delete, rename, clear]
        } else {
            return [rename, clear]
        }
    }
    
    private func clearSession(_: UITableViewRowAction, indexPath: IndexPath) {
        let alert = makeConfirm(message: "This will clear all the solves in this session.", handler: { (_) in
            self.data.clearSession(atIndex: indexPath.row)
            self.postDataUpdate()
        })
        self.rootViewController.present(alert, animated: true)
    }
    
    private func deleteSession(_: UITableViewRowAction, indexPath: IndexPath) {
        let alert = makeConfirm(message: "This will clear all the solves in this session and delete this session.", handler: { (_) in
            self.data.deleteSession(atIndex: indexPath.row)
            self.postDataUpdate()
        })
        self.rootViewController.present(alert, animated: true)
    }
    
    private func postDataUpdate() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TimeUpdated"), object: nil)
        self.sessionTable.reloadData()
    }
    
    private func renameSession(_: UITableViewRowAction, indexPath: IndexPath) {
        let alert = ThemeAlertController(title: "Rename Session", message: "Enter a new name for this session.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            let newName = alert.textFields?.first?.text!
            if newName != nil && newName != "" {
                self.data.renameSession(atIndex: indexPath.row, to: newName!)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SessionNameNeedsUpdate"), object: indexPath.row)
            }
            self.sessionTable.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) in
            textField.placeholder = "New name"
        }
        self.rootViewController.present(alert, animated: true)
    }
    
    @objc private func newSession() {
        let alert = ThemeAlertController(title: "New Session", message: "Please name your new session: ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            var sessionName = alert.textFields?.first?.placeholder
            if alert.textFields?.first?.text! != "" {
                sessionName = alert.textFields?.first?.text
            }
            let session = self.data.requestSession()
            session.name = sessionName
            session.id = Int32(Date().timeIntervalSince1970)
            self.data.append(session: session)
            self.sessionTable.reloadData()
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) in
            textField.placeholder = Date().description
        }
        rootViewController.present(alert, animated: true)
    }
    
    @objc func deletedCurrentSession() {
        tableView(sessionTable, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
}

func makeConfirm(title: String = "Are you sure?" , message: String, handler: @escaping (UIAlertAction) -> Void) -> ThemeAlertController {
    let alert = ThemeAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handler))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    return alert
}
