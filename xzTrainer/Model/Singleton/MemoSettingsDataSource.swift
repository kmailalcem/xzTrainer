//
//  MemoSettingsDataSource.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/28/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit
fileprivate func edge(_ piece: EdgeSticker) -> String {
    return toString(piece) + "<\(UserSetting.shared.general.letterScheme.edgeScheme[piece]!)>"
}

fileprivate func corner(_ piece: CornerSticker) -> String {
    return toString(piece) + "<\(UserSetting.shared.general.letterScheme.cornerScheme[piece]!)>"
}

class MemoSettingsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    var methods = [
        MemoMethod(name: "M2 Edges", options: [
            MemoOption(
                description: "Prefer easy edge stickers (\(edge(.UB)), \(edge(.UF)), \(edge(.DB)))",
                explanation: "\(edge(.UB)) can be solved in only 1 move. \(edge(.UF)), \(edge(.DB)) can be solved in 4 moves by U2 M' U2 M' or M U2 M U2. Turn on this switch so that these pieces are chosen as cycle break over others.",
                method: PreferTrivial()
                ),
            MemoOption(
                description: "Avoid Misoriented Edges",
                explanation: "Misoriented edges are more difficult to solve, due to ugly algorithms or cube rotation. Turn on this switch so that these pieces will be chosen as cycle break after others.",
                method: AvoidMisorientedEdge()
                ),
            
            ]),
        MemoMethod(name: "Old Pochman corners", options: [
            MemoOption(
                description: "Prefer corner with short setup",
                explanation: "Turn on this switch break cycles at corner pieces with one move setup.",
                method: PreferCornerWithShortSetUp()
                ),
            MemoOption(
                description: "Use \(corner(.UFL)) as a target",
                explanation: "\(corner(.UFL)) target can be solved in shorter moves than \(corner(.RDF)) by U2 [J-Perm] U. Turn on this switch so that one move setups to \(corner(.UFL)) is considered equivalently to that of \(corner(.RDF)).",
                method: UseUFL()
                )
            ]),
        MemoMethod(name: "Advanced M2", options: [
            MemoOption(
                description: "Prefer same layer outer commutator groups",
                explanation: "",
                method: PreferSameOuterLayerCommutator()
                ),
            MemoOption(
                description: "Prefer cross layer outer commutator groups",
                explanation: "",
                method: PreferCrossLayerCommutator()
                ),
            MemoOption(
                description: "Prefer same layer inner commutator groups",
                explanation: "",
                method: PreferSameInnerLayerCommutator()
                ),
            MemoOption(
                description: "Prefer easy setup (no more than 1 move)",
                explanation: "",
                method: Prefer1MoveSetUp()
                )
            ])
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods[section].options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoSettingCell", for: indexPath) as? MemoSettingCell
        cell?.configureMemoSettingCell(title: methods[indexPath.section].options[indexPath.row].description, method: methods[indexPath.section].options[indexPath.row].method)
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
