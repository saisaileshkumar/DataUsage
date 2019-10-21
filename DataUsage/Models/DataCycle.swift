//
//  Quarters.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 20/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import Foundation
import RealmSwift

class DataCycle: Object {
    @objc dynamic var dataUsed: String = ""
    @objc dynamic var quarter: String = ""
    @objc dynamic var identifier: Int = 0
    @objc dynamic var year: String = ""

    override static func primaryKey() -> String? {
        return "identifier"
    }
}


