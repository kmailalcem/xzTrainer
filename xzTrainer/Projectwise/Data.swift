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
// Manages creations, loads, saves, and deletes of Solve and Session.
class GlobalData: NSObject {
    
    public func plusTwo(forSolveAt index: Int) {
        userSolves[index].penalty = 2
        timeUpdated(at: index)
    }
    
    private func timeUpdated(at index: Int) {
        updateStatsFromIndex(index)
        saveData()
    }
    
    private func updateStatsFromIndex(_ index: Int) {
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
    
    private func saveData() {
        do {
            try managedObjectContext.save()
        } catch let err {
            print(err)
        }
    }
    
    public func dnf(forSolveAt index: Int) {
        userSolves[index].penalty = Double.infinity
        timeUpdated(at: index)
    }
    
    public func okay(forSolveAt index: Int) {
        userSolves[index].penalty = 0
        timeUpdated(at: index)
    }
    
    public func newSolve(time: Double, scramble: String, edgeMemo: String, cornerMemo: String) {
        let solve = Solve(context: managedObjectContext)
        solve.time = time
        solve.scramble = scramble
        solve.edgeMemo = edgeMemo
        solve.cornerMemo = cornerMemo
        solve.date = Date()
        solve.penalty = 0
        solve.session = currentSession
        currentSession.solve?.adding(solve)
        userSolves.append(solve)
        //userSolves[last()].best = userSolves.min()!.time
        timeUpdated(at: last())
    }
    
    public func last(_ index: Int = 0) -> Int {
        return userSolves.count - index - 1
    }
    
    // Every instance of Solve outside this class is provided by this factory function. Only copies are provided. Copies are not inserted into the managed context.
    public func requestSolve(at index: Int) -> Solve {
        let entity = NSEntityDescription.entity(forEntityName: "Solve",
                                                in: managedObjectContext)
        let solve = Solve(entity: entity!, insertInto: nil)
        solve.copyFrom(copy: userSolves[index])
        return solve
    }
    
    public func deleteSolve(atIndex index: Int) {
        
        if index < userSolves.count {
            managedObjectContext.delete(userSolves[index])
            saveData()
            userSolves.remove(at: index)
            updateStatsFromIndex(index)
        }
    }
    
    public func newSession(withName name: String) {
        let session = Session(context: managedObjectContext)
        session.name = name
        session.id = Int32(Date().timeIntervalSince1970)
        session.mode = currentMode
        sessions.append(session)
    }
    
    // Every instance of Session outside this class is provided this factory function. Only copies are provided.
    public func requestSession(at index: Int) -> Session {
        let entity = NSEntityDescription.entity(forEntityName: "Session",
                                                in: managedObjectContext)
        let session = Session(entity: entity!, insertInto: nil)
        session.copyFrom(sessions[index])
        return session
    }
    
    public func deleteSession(atIndex index: Int) {
        if index >= sessions.count {
            return
        }
        if currentSession == sessions[index] {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeletedCurrentSession"), object: nil)
        }
        clearSession(atIndex: index)
        managedObjectContext.delete(sessions[index])
        saveData()
        sessions.remove(at: index)
        let lastSavedIndex = UserDefaults.standard.integer(forKey: sessionRetrieveKey)
        if (index < lastSavedIndex) {
            UserDefaults.standard.set(lastSavedIndex - 1, forKey: sessionRetrieveKey)
        }
    }
    
    public func clearSession(atIndex index: Int) {
        for solve in requestSolves(forSessionAtIndex: index) {
            managedObjectContext.delete(solve)
        }
        
        if currentSession == sessions[index] {
            userSolves.removeAll()
        }
        saveData()
    }
    
    public func renameSession(atIndex index: Int, to newName: String) {
        sessions[index].name = newName
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SessionNameNeedsUpdate"), object: nil, userInfo: ["name" : newName])
        saveData()
    }
    
    public func reloadSolve(forSessionAtIndex index: Int) {
        currentSession = sessions[index]
        UserDefaults.standard.set(index, forKey: sessionRetrieveKey)
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
    
    public var currentMode: String = "execute" {
        didSet {
            reloadDataForCurrentMode()
        }
    }
    
    public var currentSessionName: String {
        get {
            return currentSession.name!
        }
    }
    
    // singleton
    public static var shared: GlobalData {
        if GlobalData.data == nil {
            GlobalData.data = GlobalData()
        }
        return GlobalData.data!
    }
    
    private static var data: GlobalData?
    
    private override init() {
        super.init()
        loadData()
        currentSession = sessions[0]
    }
    
    private var userSolves: [Solve] = []
    private var sessions: [Session] = []
    private let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var currentSession: Session!
    private var sessionRetrieveKey = "LastSessionBeforeExit"
    
    
    private func reloadDataForCurrentMode() {
        userSolves = []
        loadData()
        let reloadIndex = keyExists(sessionRetrieveKey) ? UserDefaults.standard.integer(forKey: sessionRetrieveKey) : 0
        currentSession = sessions[reloadIndex]
        reloadSolve(forSessionAtIndex: reloadIndex)
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
            let session = Session(context: managedObjectContext)
            session.id = Int32(Date().timeIntervalSince1970)
            session.mode = currentMode
            session.name = LocalizationGeneral.defaultt.localized
            
            saveData()
            sessions.append(session)
            
        }
        if keyExists(sessionRetrieveKey) {
            reloadSolve(forSessionAtIndex: UserDefaults.standard.integer(forKey: sessionRetrieveKey))
        } else {
            reloadSolve(forSessionAtIndex: 0)
        }
    }
    
    deinit {
        saveData()
    }
}

extension GlobalData: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let resultTableView = tableView as? ResultTableView {
            return tableViewHelper(resultTableView, cellForRowAt: indexPath)
        }
        if let sessionTableView = tableView as? SessionTableView {
            return tableViewHelper(sessionTableView, cellForRowAt: indexPath)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView is ResultTableView {
             return userSolves.count
        }
        return sessions.count
    }
    
    private func tableViewHelper(_ tableView: ResultTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ResultCell", owner: self, options: nil)?.first as! ResultCell
        
        cell.configureCell(index: last(indexPath.row), solveStats: userSolves)
        return cell
    }
    
    private func tableViewHelper(_ tableView: SessionTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SessionCell", owner: self, options: nil)?.first as! SessionCell
        cell.sessionNameLabel.text = sessions[indexPath.row].name!
        return cell
    }
}

