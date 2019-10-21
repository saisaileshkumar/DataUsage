//
//  Year.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 21/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Year: Object {
    @objc dynamic var cycleYear: String = ""
    var cycles = List<DataCycle>()
    
    override static func primaryKey() -> String? {
        return "cycleYear"
    }
    
}
