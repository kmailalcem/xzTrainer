//
//  Solve+CoreDataProperties.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//
//

import Foundation
import CoreData


extension Solve {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Solve> {
        return NSFetchRequest<Solve>(entityName: "Solve")
    }

    @NSManaged public var ao5: Double
    @NSManaged public var ao12: Double
    @NSManaged public var ao50: Double
    @NSManaged public var ao100: Double
    @NSManaged public var ao1000: Double
    @NSManaged public var best: Double
    @NSManaged public var cornerMemo: String?
    @NSManaged public var cornerTwists: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var edgeFlips: String?
    @NSManaged public var edgeMemo: String?
    @NSManaged public var mo3: Double
    @NSManaged public var penalty: Double
    @NSManaged public var scramble: String?
    @NSManaged public var time: Double
    @NSManaged public var session: Session?

}
