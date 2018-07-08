//
//  MemoSettingsDataSource.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/28/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class MemoSettingsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var methods = [
        MemoMethod(name: "General", options: [
            MemoOption(
                description: "Advanced Parity",
                explanation: "Pseudo-solves the edges or corners with the pieces involving parity swapped, so that there is no need for a parity algorithm. Specify the pieces involved in your last algorithm."
                )
            ]),
        MemoMethod(name: "M2 Edges", options: [
            MemoOption(
                description: "Prefer 4 move edge stickers (UF, DB)",
                explanation: "UF, DB can be solved in 4 moves by U2 M' U2 M' or M U2 M U2. Turn on this switch so that these pieces are chosen as cycle break over others."
                ),
            MemoOption(
                description: "Avoid Misoriented Edges",
                explanation: "Misoriented edges are more difficult to solve, due to ugly algorithms or cube rotation. Turn on this switch so that these pieces will be chosen as cycle break after others."
                ),
            
            ]),
        MemoMethod(name: "Old Pochman corners", options: [
            MemoOption(
                description: "Prefer corner with short setup",
                explanation: "Turn on this switch break cycles at corner pieces with one move setup."
                ),
            MemoOption(
                description: "Use UFL as a target",
                explanation: "UFL target can be solved in shorter moves than RDF by U2 [J-Perm] U. Turn on this switch so that one move setups to UFL is considered equivalently to that of RDF."
                )
            ]),
        MemoMethod(name: "Advanced M2", options: [
            MemoOption(
                description: "Prefer same layer outer commutator groups",
                explanation: ""
                ),
            MemoOption(
                description: "Prefer cross layer outer commutator groups",
                explanation: ""
                ),
            MemoOption(
                description: "Prefer same layer inner commutator groups",
                explanation: ""
                ),
            MemoOption(
                description: "Prefer M-layer commutators (FU, BD)",
                explanation: ""
                ),
            MemoOption(
                description: "Prefer easy setup (no more than 1 move)",
                explanation: ""
                )
            ])
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods[section].options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return methods.count
    }
  
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return methods[section].name
    }
 */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoSettingCell", for: indexPath) as? MemoSettingCell
        cell?.configureMemoSettingCell(title: methods[indexPath.section].options[indexPath.row].description, handler: { (isOn) in
            
        })
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let title = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.size.width - 16, height: 30))
        title.text = methods[section].name
        title.textColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        headerView.addSubview(title)
        headerView.backgroundColor = #colorLiteral(red: 0.7833306789, green: 0.8284245133, blue: 0.87673527, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let tableView = tableView as? SettingsTableView {
            tableView.containerViewController.performSegue(withIdentifier: "toSettingsDetail", sender: methods[indexPath.section].options[indexPath.row])
        }
        
    }
}
