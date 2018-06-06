//
//  resultTableVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/19/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit
import CoreData

class ResultTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Pop up window
    @IBOutlet var popUpDetailView: RoundedView!
    @IBOutlet var dismissPopUpButton: UIButton!
    @IBAction func dismissPopUp(_ sender: UIButton) {
        animatePopUpOut()
    }
    
    @IBOutlet var puScrambleLabel: UILabel!
    @IBOutlet var puTimeLabel: UILabel!
    @IBOutlet var puMo3Label: UILabel!
    @IBOutlet var puAo5Label: UILabel!
    @IBOutlet var puAo12Label: UILabel!
    @IBOutlet var puDateLabel: UILabel!
    @IBOutlet var plusTwoButtion: RoundedButton!
    var currentIndexPath: IndexPath!
    
    @IBAction func plusTwo() {
        plusTwoButtion.isSelected = !plusTwoButtion.isSelected
    }
    
    @IBAction func showDetail() {
        performSegue(withIdentifier: "tableToSolveDetail",
                     sender: currentIndexPath)
    }

    @IBOutlet var resultTable: UITableView!

    var userSolves: [Solve] = []
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
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
        tableView.deselectRow(at: indexPath, animated: true)
        configurePopUp(indexPath: indexPath)
        animatePopUpIn()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    private func configurePopUp(indexPath: IndexPath) {
        currentIndexPath = indexPath
        let solve = userSolves[userSolves.count - indexPath.row - 1]
        puScrambleLabel.text = solve.scramble
        puTimeLabel.text = convertTimeDoubleToString(solve.time)
        puMo3Label.text = convertTimeDoubleToString(solve.mo3)
        puAo5Label.text = convertTimeDoubleToString(solve.ao5)
        puAo12Label.text = convertTimeDoubleToString(solve.ao12)
    }
    
    private func animatePopUpIn() {
        self.view.addSubview(popUpDetailView)
        popUpDetailView.alpha = 0
        self.popUpDetailView.center = self.view.center
        self.popUpDetailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpDetailView.alpha = 0.9
            self.dismissPopUpButton.alpha = 0.5
            self.popUpDetailView.transform = CGAffineTransform.identity
        })
    }
    
    private func animatePopUpOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.dismissPopUpButton.alpha = 0
            self.popUpDetailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.popUpDetailView.alpha = 0
        }, completion: {success in
            self.popUpDetailView.removeFromSuperview()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SolveDetailVC {
            if let indexPath = sender as? IndexPath {
                destination.endingIndex = indexPath.row
            }
        }
    }
    
    @IBAction func backToTimerButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadData() {
        let solvesRequest: NSFetchRequest<Solve> = Solve.fetchRequest()
        do {
            try userSolves = managedObjectContext.fetch(solvesRequest)
        } catch {
            print("error fetching solves request. Message: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTable.delegate = self
        resultTable.dataSource = self
        loadData()
        resultTable.reloadData()
    }
}
