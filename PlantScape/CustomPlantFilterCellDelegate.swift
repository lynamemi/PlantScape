//
//  CustomPlantFilterCellDelegate.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/28/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation; import UIKit

protocol CustomPlantFilterCellDelegate: class {
    func didSwitchOnAtIndexPathOfCell(sender: CustomPlantFilterCell)
}
