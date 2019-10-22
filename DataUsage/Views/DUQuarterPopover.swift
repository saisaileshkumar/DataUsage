//
//  DUQuarterPopover.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 21/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import UIKit

class DUQuarterPopover: UIViewController {
    var cycles: [DataCycle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let cycle = cycles.first {
            self.navigationController?.navigationBar.topItem?.title = cycle.year
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(dismissFormSheet))
    }
    
    /// dismisses view
    @objc func dismissFormSheet() {
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DUQuarterPopover: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cycles.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DUQuarterCell") as? DUQuarterCell {
            let dataCycle = cycles[indexPath.row]
            cell.lblQuarter.text = dataCycle.quarter
            cell.lblDataVolume.text = dataCycle.dataUsed
            return cell
        }
        return UITableViewCell()
    }

}

extension DUQuarterPopover: UITableViewDelegate {
     public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DUQuarterCell") as? DUQuarterCell {
            return cell
        }
        return UIView()
    }

}
