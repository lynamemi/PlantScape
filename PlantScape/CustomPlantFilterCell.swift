//
//  CustomPlantFilterCell.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/28/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation; import UIKit

class CustomPlantFilterCell: UITableViewCell {
    weak var plantFilterCellDelegate: CustomPlantFilterCellDelegate?
    
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var filterLabel: UILabel!
    
    @IBAction func switchIsChanged(_ sender: UISwitch) {
        filterSwitch.target(forAction: #selector(self.switchIsChanged(_:)), withSender: self)
        if filterSwitch.isOn {
            self.plantFilterCellDelegate?.didSwitchOnAtIndexPathOfCell(sender: self)
        }
        if filterSwitch.isOn == false {
            // ASK DAVID ABOUT THIS TOMORROW!!!!!!!!!!!!!!!!
            print("need to do an UNfilter filter")
            //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        }
    }
}
