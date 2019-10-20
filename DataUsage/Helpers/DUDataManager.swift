//
//  DUDataManager.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 20/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class DUDataManager: NSObject {
    
     var realm: Realm? {
        get {
            do {
                let realm = try Realm()
                return realm
            }
            catch let error as NSError {
                print("Realm error: ", error.localizedDescription)
            }
            return self.realm //ToDo Assume Realm initialise next as per documentation
        }
    }
    
    /// saves data into realm db
    ///
    /// - Parameter records: records
    func saveDataUsageForOfflineCaching(_ records: [[String: Any]]) {
            for record in records {
                let dataCycle = DataCycle()
                if let cycle = record[DUDBConstants.Quarter] as? String {
                    let yearStr = cycle.components(separatedBy: "-").first ?? ""
                    let quarterStr = cycle.components(separatedBy: "-").last ?? ""
                    dataCycle.year = yearStr
                    dataCycle.quarter = quarterStr
                }
                dataCycle.dataUsed = record[DUDBConstants.DataVolume] as? String ?? ""
                dataCycle.identifier = record[DUDBConstants.identifier] as? Int ?? 0
                if let realm = realm {
                    do {
                        try realm.write() {
                            realm.add(dataCycle, update: .modified)
                        }
                    } catch let error {
                        debugPrint(error.localizedDescription)
                    }
                }
               
            }
        
        debugPrint("Realm DB Path: \(String(describing: realm?.configuration.fileURL))")
        
    }
    
    /// fetches the data cycles saved in the data base
    ///
    /// - Returns: data cycle objects array
    func fetchOfflineCachedCycles()-> [DataCycle] {
        let dataCycles = Array((realm?.objects(DataCycle.self))!.sorted(byKeyPath: "year"))
        for cycle in dataCycles {
            print("Quarter:  --> \(cycle.year)")
        }
        return dataCycles
    }

}


struct DUDBConstants {
   static let Quarter = "quarter"
    static let DataVolume = "volume_of_mobile_data"
    static let identifier = "_id"
}
