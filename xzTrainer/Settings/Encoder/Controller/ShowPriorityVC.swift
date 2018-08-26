//
//  CustomPriorityVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 8/1/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ShowPriorityVC: ThemeViewController {
    @IBOutlet weak var priorityTable: UITableView!
    @IBOutlet weak var applySwitch: ThemeSwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        priorityTable.delegate = self
        priorityTable.dataSource = self
        
        applySwitch.isOn = UserSetting.shared.encoder.userCustomizeOrder
        
        // priorityTable.estimatedRowHeight = 60
        priorityTable.rowHeight = 55
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleApply() {
        UserSetting.shared.encoder.userCustomizeOrder = applySwitch.isOn
        if applySwitch.isOn {
            UserSetting.shared.encoder.readPreferenceList()
        }
        priorityTable.reloadData()
    }
    
    @IBAction func resetPreferences() {
        let alert = makeConfirm(message: "This will wipe out your previous ordering and you cannot undo this action.") { (_) in
            UserSetting.shared.encoder.resetPreferenceList()
            self.priorityTable.reloadData()
        }
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ReorderPriorityVC {
            if sender is EdgeSticker {
                destination.targetEdgePiece = (sender as! EdgeSticker)
            }
            if sender is CornerSticker {
                destination.targetCornerPiece = (sender as! CornerSticker)
            }
            if sender is Bool {
                destination.isEdge = (sender as! Bool)
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        UserSetting.shared.encoder.savePreferenceList()
        priorityTable.reloadData()
    }
}

extension ShowPriorityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return NUM_STICKERS - 2
        } else {
            return NUM_STICKERS - 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityCell") as! PriorityCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let firstLetters = UserSetting.shared.encoder.userPreference.edgePreferenceAsFirstLetter
                cell.configureCell(
                    startingLetter: LocalizationGeneral.firstLetter.localized,
                    secondLetters: formatedPieces(
                        firstLetters,
                        showInLetters: true
                    )
                )
                return cell
            }
            
            var allRawValues = [Int](0 ..< NUM_STICKERS)
            for i in 0 ..< NUM_STICKERS {
                if i / 2 == UserSetting.shared.general.edgeBuffer.rawValue / 2 {
                    allRawValues.remove(at: i)
                    allRawValues.remove(at: i)
                    break
                }
            }
            
            let edgePreference = UserSetting.shared.encoder.userPreference.edgePreferenceAsSecondLetter
            let edge = EdgePosition(rawValue: allRawValues[indexPath.row - 1])!
            cell.configureCell(
                startingLetter: formatedPieces(
                    [edge],
                    showInLetters: true
                ),
                secondLetters: formatedPieces(
                    edgePreference[edge]!,
                    showInLetters: true
                )
            )
        } else {
            if indexPath.row == 0 {
                let firstLetters = UserSetting.shared.encoder.userPreference.cornerPreferenceAsFirstLetter
                cell.configureCell(
                    startingLetter: LocalizationGeneral.firstLetter.localized,
                    secondLetters: formatedPieces(
                        firstLetters,
                        showInLetters: true
                    )
                )
                return cell
            }
            var allRawValues = [Int](0 ..< NUM_STICKERS)
            for i in 0 ..< NUM_STICKERS {
                if i / 3 == UserSetting.shared.general.cornerBuffer.rawValue / 3 {
                    allRawValues.remove(at: i)
                    allRawValues.remove(at: i)
                    allRawValues.remove(at: i)
                    break
                }
            }
            let cornerPreference = UserSetting.shared.encoder.userPreference.cornerPreferenceAsSecondLetter
            let corner = CornerPosition(rawValue: allRawValues[indexPath.row - 1])!
            cell.configureCell(
                startingLetter: formatedPieces(
                    [corner],
                    showInLetters: true
                ),
                secondLetters: formatedPieces(
                    cornerPreference[corner]!,
                    showInLetters: true
                )
            )
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width - 16, height: 30))
        title.text = section == 0 ? "Edges".localized() : "Corners".localized()
        title.textColor = Theme.current.headerTextColor
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        headerView.addSubview(title)
        headerView.backgroundColor = Theme.current.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !applySwitch.isOn {
            return
        }
        
        if indexPath.section == 0 {
            if indexPath.row > 0 {
                performSegue(withIdentifier: "toCustomPriority", sender: EdgeSticker(rawValue: indexPath.row - 1))
            } else {
                performSegue(withIdentifier: "toCustomPriority", sender: true)
            }
        } else {
            if indexPath.row > 0 {
                performSegue(withIdentifier: "toCustomPriority", sender: CornerSticker(rawValue: indexPath.row - 1))
            } else {
                performSegue(withIdentifier: "toCustomPriority", sender: false)
            }
        }
    }
}
