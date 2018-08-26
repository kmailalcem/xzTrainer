//
//  MemoSettingsDataSource.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/28/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit
fileprivate func edge(_ piece: EdgeSticker) -> String {
    if UserSetting.shared.general.letterScheme[piece].count == 0 {
        return piece.string
    }
    return piece.string + "/\(UserSetting.shared.general.letterScheme[piece])"
}

fileprivate func corner(_ piece: CornerSticker) -> String {
    if UserSetting.shared.general.letterScheme[piece].count == 0 {
        return piece.string
    }
    return piece.string + "/\(UserSetting.shared.general.letterScheme[piece])"
}

class MemoSettingsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    var methods = [
        MemoMethod(name: LocalizableMemo.m2Edges.localized,
                   requiredEdgeBuffer: .DF,
                   requiredCornerBuffer: nil,
                   options: [
                    PreferTrivial(),
                    AvoidMisorientedEdge()
            ]),
        MemoMethod(name: LocalizableMemo.opCorners.localized,
                   requiredEdgeBuffer: nil,
                   requiredCornerBuffer: .ULB,
                   options: [
                    PreferCornerWithShortSetUp(),
                    UseUFL()
            ]),
        MemoMethod(name: LocalizableMemo.advancedM2.localized,
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
        let title = ThemeHeader1(frame: CGRect(x: 16, y: 0, width: tableView.bounds.size.width - 16, height: 30))
        title.text = method.name
        if (!method.applicable) {
            title.text = title.text! + " (Requires \(method.requiredBuffer) buffer)"
        }
        headerView.addSubview(title)
        headerView.backgroundColor = Theme.current.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let tableView = tableView as? SettingsTableView {
            tableView.containerViewController.performSegue(withIdentifier: "toSettingsDetail", sender: tableView.cellForRow(at: indexPath))
        }
        
    }
}
