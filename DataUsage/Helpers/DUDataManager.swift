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
            var yearStr: String = ""
            let identifier = record[DUDBConstants.identifier] as? Int ?? 0
            if let cycle = record[DUDBConstants.Quarter] as? String {
                yearStr = cycle.components(separatedBy: "-").first ?? ""
                let quarterStr = cycle.components(separatedBy: "-").last ?? ""
                dataCycle.quarter = quarterStr
            }
            dataCycle.year = yearStr
            dataCycle.dataUsed = record[DUDBConstants.DataVolume] as? String ?? ""
            dataCycle.identifier = identifier
            if let yearObj  = realm?.objects(Year.self).filter("cycleYear == %@",yearStr).first {
                try? realm?.write {
                    if let _ = realm?.objects(DataCycle.self).filter("identifier == %@",identifier).first {
                        realm?.add(dataCycle, update: .modified)
                    } else {
                        yearObj.cycles.append(dataCycle)
                    }
                }
            } else {
                let year = Year()
                year.cycleYear = yearStr
                year.cycles.append(dataCycle)
                try? realm?.write() {
                    realm?.add(year)
                }
            }
        }
        debugPrint("Realm DB Path: \(String(describing: realm?.configuration.fileURL))")
        
    }
    
    /// fetches the data cycles saved in the data base
    ///
    /// - Returns: data cycle objects array
     func fetchOfflineCachedCycles()-> [Year] {
        let years = Array((realm?.objects(Year.self))!.sorted(byKeyPath: "cycleYear"))
        return years
    }
    
}


struct DUDBConstants {
    static let Quarter = "quarter"
    static let DataVolume = "volume_of_mobile_data"
    static let identifier = "_id"
}
