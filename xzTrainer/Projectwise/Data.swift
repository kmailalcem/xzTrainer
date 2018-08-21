//
//  Data.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/19/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
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
        NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "TimeUpdated")))
    }
    
    public func plusTwo(forSolveAt index: Int) {
        userSolves[index].penalty = 2
        timeUpdated(at: index)
    }
    
    public func dnf(forSolveAt index: Int) {
        userSolves[index].penalty = Double.infinity
        timeUpdated(at: index)
    }
    
    public func okay(forSolveAt index: Int) {
        userSolves[index].penalty = 0
        timeUpdated(at: index)
    }
    
    private func timeUpdated(at index: Int) {
        updateStatsFromIndex(index)
        saveData()
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
        managedObjectContext.insert(solve)
        solve.session = currentSession
        currentSession.solve?.adding(solve)
        userSolves.append(solve)
        userSolves[count - 1].best = userSolves.min()!.time
        timeUpdated(at: count - 1)
    }
    
    // Every instance of Session outside this class is provided by one of these
    // two factory functions. Only copies are provided. Copies are not inserted
    // into the managed context unless append is called.
    public func requestSession() -> Session {
        let entity = NSEntityDescription.entity(forEntityName: "Session",
                                                in: managedObjectContext)
        return Session(entity: entity!, insertInto: nil)
    }
    
    public func requestSession(at index: Int) -> Session {
        let session = requestSession()
        session.copyFrom(sessions[index])
        return session
    }
    
    public func append(session: Session) {
        session.mode = currentMode
        sessions.append(session)
        managedObjectContext.insert(session)
        saveData()
    }
    
    public func saveData() {
        do {
            try managedObjectContext.save()
        } catch let err {
            print(err)
        }
    }
    
    public func deleteSolve(atIndex index: Int) {
        
        if index < userSolves.count {
            managedObjectContext.delete(userSolves[index])
            saveData()
            userSolves.remove(at: index)
            updateStatsFromIndex(index)
        }
    }
    
    public func deleteSession(atIndex index: Int) {
        if index < sessions.count {
            if currentSession == sessions[index] {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeletedCurrentSession"), object: nil)
            }
            clearSession(atIndex: index)
            managedObjectContext.delete(sessions[index])
            saveData()
            sessions.remove(at: index)
        }
    }
    
    public func clearSession(atIndex index: Int) {
        for solve in requestSolves(forSessionAtIndex: index) {
            managedObjectContext.delete(solve)
        }
        
        if currentSession == sessions[index] {
            userSolves = []
        }
        saveData()
    }
    
    public func renameSession(atIndex index: Int, to newName: String) {
        sessions[index].name = newName
        saveData()
    }
    
    public func reloadSolve(forSessionAtIndex index: Int) {
        currentSession = sessions[index]
        userSolves = requestSolves(forSessionAtIndex: index)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SessionSelected"), object: nil, userInfo: ["selectedSessionName": currentSession.name ?? "nil"])
    }
    
    private func requestSolves(forSessionAtIndex index: Int) -> [Solve] {
        let fetchRequest: NSFetchRequest<Solve> = Solve.fetchRequest()
        let predicate = NSPredicate(format: "session.id = %d", sessions[index].id)
        fetchRequest.predicate = predicate
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error reloading session. Message: \(error.localizedDescription)")
        }
        return []
    }
    
    public func free() {
        GlobalData.data = nil
        // reference count goes to 0, triggers deinitializer
    }
    
    public var currentMode: String = "execute" {
        didSet {
            reloadDataForCurrentMode()
        }
    }
    
    private static var data: GlobalData?
    private var userSolves: [Solve]
    private var sessions: [Session]
    private let managedObjectContext: NSManagedObjectContext
    private var currentSession: Session!
    
    private override init() {
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        userSolves = []
        sessions = []
        super.init()
        loadData()
        currentSession = sessions[0]
    }
    
    private func reloadDataForCurrentMode() {
        userSolves = []
        loadData()
        currentSession = sessions[0]
        reloadSolve(forSessionAtIndex: 0)
    }
    
    private func loadData() {
        
        let sessionRequest: NSFetchRequest<Session> = Session.fetchRequest()
        let predicate = NSPredicate(format: "mode = %@", currentMode)
        sessionRequest.predicate = predicate
        do {
            try sessions = managedObjectContext.fetch(sessionRequest)
        } catch {
            print("error fetching sessions. No session is fetched. Message: \(error.localizedDescription)")
        }
        
        if sessions.count == 0 {
            let  session = Session(context: managedObjectContext)
            session.id = Int32(Date().timeIntervalSince1970)
            session.mode = currentMode
            session.name = LocalizationGeneral.defaultt.localized
            
            saveData()
            sessions.append(session)
            
        }
        reloadSolve(forSessionAtIndex: 0)
    }
    
    deinit {
        saveData()
    }
}

extension GlobalData: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView is ResultTableView {
             return count
        }
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView is ResultTableView {
            let cell = Bundle.main.loadNibNamed("ResultCell", owner: self, options: nil)?.first as! ResultCell
            
            cell.configureCell(index: backIndex(indexPath.row), solveStats: userSolves)
            return cell
            
        }
        
        if tableView is SessionTableView {
            let cell = Bundle.main.loadNibNamed("SessionCell", owner: self, options: nil)?.first as! SessionCell
            cell.sessionNameLabel.text = sessions[indexPath.row].name!
            return cell
        }
        return UITableViewCell()
    }
}

