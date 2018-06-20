//
//  Data.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/19/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit
import CoreData

// Provide single port of entry for accessing data managed by Core Data.
// Manages creations, loads, saves, and deletes of Solve.
class GlobalData: NSObject {
    
    // singleton
    public static var shared: GlobalData {
        if GlobalData.data == nil {
            GlobalData.data = GlobalData()
        }
        return GlobalData.data!
    }
    
    public var count: Int {
        return userSolves.count
    }
    
    public func updateStatsFromIndex(_ index: Int) {
        if index < userSolves.count {
            for i in index ..< userSolves.count {
                let currentSolve = userSolves[i]
                currentSolve.best = userSolves.min()!.timeIncludingPenalty
                currentSolve.mo3 = userSolves.mo(3, ending: i + 1)
                currentSolve.ao5 = userSolves.ao(5, ending: i + 1)
                currentSolve.ao12 = userSolves.ao(12, ending: i + 1)
                currentSolve.ao50 = userSolves.ao(50, ending: i + 1)
                currentSolve.ao100 = userSolves.ao(100, ending: i + 1)
                currentSolve.ao1000 = userSolves.ao(1000, ending: i + 1)
                userSolves[i] = currentSolve
            }
        }
    }
    
    public func plusTwo(forSolveAt index: Int) {
        userSolves[index].penalty = 2
    }
    
    public func dnf(forSolveAt index: Int) {
        userSolves[index].penalty = Double.infinity
    }
    
    public func okay(forSolveAt index: Int) {
        userSolves[index].penalty = 0
    }
    
    public func penalty(forSolveAt index: Int) -> Double {
        return userSolves[index].penalty
    }
    
    public func backIndex(_ index: Int) -> Int {
        return count - index - 1
    }
    
    // Every instance of Solve outside this class is provided by one of these
    // two factory functions. Only copies are provided. Copies are not inserted
    // into the managed context unless append is called.
    public func requestSolve() -> Solve {
        let entity = NSEntityDescription.entity(forEntityName: "Solve",
                                                in: managedObjectContext)
        return Solve(entity: entity!, insertInto: nil)
    }
    
    public func requestSolve(at index: Int) -> Solve {
        let solve = requestSolve()
        solve.copyFrom(copy: userSolves[index])
        return solve
    }
    
    public func append(solve: Solve) {
        solve.best = userSolves.min()!.time
        userSolves.append(solve)
        updateStatsFromIndex(count - 1)
        managedObjectContext.insert(solve)
    }
    
    public func saveData() {
        do {
            try managedObjectContext.save()
        }catch {
            print("Error saving solve data. Message: \(error.localizedDescription)")
        }
    }
    
    public func deleteSolve(atIndex index: Int) {
        
        if index < userSolves.count {
            managedObjectContext.delete(userSolves[index])
            saveData()
            userSolves.remove(at: index)
        }
    }
    
    
    public func free() {
        GlobalData.data = nil
        // reference count goes to 0, triggers deinitializer
    }
    
    
    private static var data: GlobalData?
    private var userSolves: [Solve]
    private let managedObjectContext: NSManagedObjectContext
    
    private override init() {
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        userSolves = []
        super.init()
        loadData()
    }
    
    private func loadData() {
        let solvesRequest: NSFetchRequest<Solve> = Solve.fetchRequest()
        do {
            try userSolves = managedObjectContext.fetch(solvesRequest)
        } catch {
            print("error fetching solves request. No data is fetched. Message: \(error.localizedDescription)")
            userSolves = []
        }
    }
    
    deinit {
        saveData()
    }
}

extension GlobalData: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSolves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ResultCell", for: indexPath)
        if let resultCell = cell as? ResultCell {
            resultCell.configureCell(index: backIndex(indexPath.row),
                                     solveStats: userSolves)
            let newView = UIView()
            let extractedExpr: UIColor = UIColor(red: 0x92/255 ,
                                                 green: 0xa6/255,
                                                 blue:0xbe/255,
                                                 alpha: 1)
            newView.backgroundColor = extractedExpr
            resultCell.selectedBackgroundView? = newView
            return resultCell
        }
        return UITableViewCell()
    }
    
    
}
