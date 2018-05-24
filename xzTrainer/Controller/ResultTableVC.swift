//
//  resultTableVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/19/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class ResultTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var resultTable: UITableView!
    var userSolves: [SolveTime] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSolves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTable.dequeueReusableCell(
            withIdentifier: "resultCell", for: indexPath)
        if let resultCell = cell as? ResultCell {
            resultCell.configureCell(index: indexPath.row,
                                     solveStats: userSolves)
            let newView = UIView()
            newView.backgroundColor = UIColor(red: 0x92/255 ,
                                              green: 0xa6/255,
                                              blue:0xbe/255,
                                              alpha: 1)
            resultCell.selectedBackgroundView? = newView
            return resultCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let cell = resultTable.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "tableToSolveDetail",
                     sender: (array: self.userSolves, index: indexPath.row + 1))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SolveDetailVC {
            if let solveDetail = sender as? (array: [SolveTime], index: Int) {
                destination.userSolves = solveDetail.array
                destination.endingIndex = solveDetail.index
            }
        }
    }
    
    @IBAction func backToTimerButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTable.delegate = self
        resultTable.dataSource = self
        resultTable.reloadData()
    }
}
