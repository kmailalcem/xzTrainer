//
//  Data.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/19/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit
import CoreData

class GlobalData: NSObject {
    private static var data: GlobalData?
    
    private var userSolves: [Solve]
    private let managedObjectContext: NSManagedObjectContext
    
    private override init() {
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate)
                                .persistentContainer.viewContext
        let solvesRequest: NSFetchRequest<Solve> = Solve.fetchRequest()
        
        userSolves = []
        do {
            try userSolves = managedObjectContext.fetch(solvesRequest)
        } catch {
            print("error fetching solves request. No data is fetched. Message: \(error.localizedDescription)")
            userSolves = []
        }
        super.init()
    }
    
    public func saveData() {
        do {
            try managedObjectContext.save()
        }catch {
            print("Error saving solve data. Message: \(error.localizedDescription)")
        }
    }
    
    public func shared() -> GlobalData {
        if GlobalData.data == nil {
            return GlobalData()
        } else {
            return GlobalData.data!
        }
    }
    
    private func deleteSolve(atIndex index: Int) {
        
        if index < userSolves.count {
            managedObjectContext.delete(userSolves[index])
            saveData()
            userSolves.remove(at: index)
        }
    }
    
    public func append(solve: Solve) {
        let newSolve = Solve(context: managedObjectContext)
        newSolve.copyFrom(copy: solve)
        newSolve.best = userSolves.min()!.time
        userSolves.append(newSolve)
    }
    
    public func free() {
        GlobalData.data = nil
        // reference count goes to 0, triggers deinitializer
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
            resultCell.configureCell(index: userSolves.count - indexPath.row - 1,
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
