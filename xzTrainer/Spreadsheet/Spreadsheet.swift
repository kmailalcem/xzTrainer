//
//  Spreadsheet.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/3/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

protocol Spreadsheet : UITableViewDataSource {
    var name : String { get }
    var type : String { get }
    func delegatedSegue(_ viewController: ThemeViewController, _ m: Int, _ n: Int)
    func save()
}
