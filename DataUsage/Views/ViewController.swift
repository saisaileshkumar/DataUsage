//
//  ViewController.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 20/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var years: [Year] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let networkManager = DUNetworkManager()
        networkManager.delegate = self
        networkManager.fetchMobileDataConsumptionVolumeDetails()
        self.reloadDataUsageDetails()
    }
    
    /// reloads the view with latest data received from service and cached offline.
    func reloadDataUsageDetails() {
        let dataManager = DUDataManager()
        years = dataManager.fetchOfflineCachedCycles()
        self.tableView.reloadData()
    }


}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return years.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let yearCell = tableView.dequeueReusableCell(withIdentifier: "DUYearCell") as? DUYearCell {
            yearCell.year = years[indexPath.row]
            yearCell.updateMobileDataConsumption()
            yearCell.delegate = self
            return yearCell
        }
        return UITableViewCell()
    }

}

extension ViewController: DUNetworkManagerDelegate {
    /// view is notified oon receiving the latest data updates.
    func didCompleteReceivingConsumptionDetails() {
        DispatchQueue.main.async {
            self.reloadDataUsageDetails()
        }
    }
}

extension ViewController: DUDataCyclesDelegate {
    
    /// did selectt action for showing quarter details
    ///
    /// - Parameter dataCycles: data cycles.
    func didSelectShowDataCyclesDetails(_ dataCycles: [DataCycle]) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let popOver = storyBoard.instantiateViewController(withIdentifier: "DUQuarterPopover") as? DUQuarterPopover {
            let nav = UINavigationController(rootViewController: popOver)

            popOver.cycles = dataCycles
            nav.popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
            nav.popoverPresentationController?.sourceView = self.view
            nav.popoverPresentationController?.sourceRect = self.view.bounds
            nav.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width/2, height: 221)
            nav.modalPresentationStyle = .formSheet
            nav.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(nav, animated: true) {
                
            }
            
        }
    }
}
