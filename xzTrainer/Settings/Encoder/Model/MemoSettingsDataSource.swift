//
//  MemoSettingsDataSource.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/28/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit
fileprivate func edge(_ piece: EdgeSticker) -> String {
    if UserSetting.shared.general.letterScheme.edgeScheme[piece]!.count == 0 {
        return toString(piece)
    }
    return toString(piece) + "/\(UserSetting.shared.general.letterScheme.edgeScheme[piece]!)"
}

fileprivate func corner(_ piece: CornerSticker) -> String {
    if UserSetting.shared.general.letterScheme.cornerScheme[piece]!.count == 0 {
        return toString(piece)
    }
    return toString(piece) + "/\(UserSetting.shared.general.letterScheme.cornerScheme[piece]!)"
}

class MemoSettingsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    var methods = [
        MemoMethod(name: "M2 Edges",
                   requiredEdgeBuffer: .DF,
                   requiredCornerBuffer: nil,
                   options: [
                    PreferTrivial(),
                    AvoidMisorientedEdge()
            ]),
        MemoMethod(name: "Old Pochman corners",
                   requiredEdgeBuffer: nil,
                   requiredCornerBuffer: .ULB,
                   options: [
                    PreferCornerWithShortSetUp(),
                    UseUFL()
            ]),
        MemoMethod(name: "Advanced M2",
                   requiredEdgeBuffer: .DF,
                   requiredCornerBuffer: nil,
                   options: [
                    PreferSameOuterLayerCommutator(),
                    PreferCrossLayerCommutator(),
                    PreferSameInnerLayerCommutator(),
                    Prefer1MoveSetUp()
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
        let method = methods[indexPath.section].options[indexPath.row]
        cell?.configureMemoSettingCell(method: method, applicable: methods[indexPath.section].applicable)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let method = methods[section]
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let title = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.size.width - 16, height: 30))
        title.text = method.name
        if (!method.applicable) {
            title.text = title.text! + " (Requires \(method.requiredBuffer) buffer)"
        }
        title.textColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        headerView.addSubview(title)
        headerView.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.8274509804, blue: 0.8705882353, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let tableView = tableView as? SettingsTableView {
            tableView.containerViewController.performSegue(withIdentifier: "toSettingsDetail", sender: tableView.cellForRow(at: indexPath))
        }
        
    }
}
