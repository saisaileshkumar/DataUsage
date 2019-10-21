//
//  DUYearCell.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 21/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import UIKit

protocol DUDataCyclesDelegate {
    func didSelectShowDataCyclesDetails(_ dataCycles: [DataCycle])
}

class DUYearCell: UITableViewCell {

    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDataConsumption: UILabel!
    @IBOutlet weak var btnDecreaseInfo: UIButton!
    var delegate: DUDataCyclesDelegate?
    var year = Year()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        btnDecreaseInfo.imageView?.contentMode = .scaleAspectFit
        // Configure the view for the selected state
    }

    /// updates UI for labels
    func updateMobileDataConsumption() {
        self.lblYear.text = self.year.cycleYear
        self.lblDataConsumption.text = String(format: "%.6f", getTotalDataConsumed())
        self.btnDecreaseInfo.isHidden = !self.isQuartersDataDecreased()
    }
    
    /// button action for displaying quarter details of an year
    ///
    /// - Parameter sender: uibutton
    @IBAction func didTapForQuarterDetails(_ sender: Any) {
        DispatchQueue.main.async {
            self.delegate?.didSelectShowDataCyclesDetails(Array(self.year.cycles))
        }
    }
    /// gets total data consumed for the year
    ///
    /// - Returns: total data
    func getTotalDataConsumed() -> Double {
        return year.cycles.map({Double($0.dataUsed) ?? 0.0}).reduce(0.0, +)
    }
    
    /// checks if there is a decrease in data used
    ///
    /// - Returns: status is returned
    func isQuartersDataDecreased() -> Bool {
        let cycles = Array(year.cycles)
        debugPrint(cycles.count)
        for index in 0..<cycles.count - 1 {
            if Double(year.cycles[index].dataUsed) ?? 0.0 > Double(year.cycles[index+1].dataUsed) ?? 0.0 {
                return true
            }
        }
        return false
    }
}
