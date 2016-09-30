//
//  PlantFiltersTableViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/28/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit; import SwiftCSV

class PlantFiltersTableViewController: UITableViewController, CustomPlantFilterCellDelegate {
    
    var countPlants = 0
    let filterOptions = ["Drought Tolerant", "Shade Loving", "Evergreen"]
    var selectedState: String?
    var drawnImageDate: Double?
    var newPlants: PlantList?
    var currentRandomTrees: [Plant]?
    var currentRandomShrubs: [Plant]?
    var currentRandomGrasses: [Plant]?
    var allRandomPlants: [Plant]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedState!)
        pickRandomGrass()
        pickRandomShrub()
        pickRandomTree()
    }
    
    func pickRandomTree() {
        let trees = newPlants?.filterTree()
        let randomTreeIndex = Int(arc4random_uniform(UInt32(UInt(trees!.count))))
        let currentTree = trees![randomTreeIndex]
        for tree in currentRandomTrees! {
            if tree.id != currentTree.id {
                currentRandomTrees?.append(currentTree)
                allRandomPlants?.append(currentTree)
            } else {
                pickRandomTree()
            }
        }
    }
    func pickRandomShrub() {
        let shrubs = newPlants?.filterShub()
        let randomShrubIndex = Int(arc4random_uniform(UInt32(UInt(shrubs!.count))))
        let currentShrub = shrubs![randomShrubIndex]
        for shrub in currentRandomShrubs! {
            if shrub.id != currentShrub.id {
                currentRandomShrubs?.append(currentShrub)
                allRandomPlants?.append(currentShrub)
            } else {
                pickRandomShrub()
            }
        }
    }
    func pickRandomGrass() {
        let grasses = newPlants?.filterGrass()
        let randomGrassIndex = Int(arc4random_uniform(UInt32(UInt(grasses!.count))))
        let currentGrass = grasses![randomGrassIndex]
        for grass in currentRandomGrasses! {
            if grass.id != currentGrass.id {
                currentRandomGrasses?.append(currentGrass)
                allRandomPlants?.append(currentGrass)
            } else {
                pickRandomGrass()
            }
        }
    }


    func didSwitchOnAtIndexPathOfCell(sender: CustomPlantFilterCell) {
//        let index = tableView.indexPath(for: sender)
//        if sender.filterLabel.text == filterOptions[0] {
//            let droughtTolerantPlants = newPlants?.filterHighDroughtTolerance(listOfPlants: newPlants!)
//        }
//        if sender.filterLabel.text == filterOptions[1] {
//            let shadePlants = newPlants?.filterShadeTolerance(listOfPlants: newPlants!)
//        }
//        if sender.filterLabel.text == filterOptions[2] {
//            newPlants?.filterLeafRetention()
//        }
    }
    
    // MAKE SURE TO ADD FILTER FOR STATE THAT THE USER SEARCHED FOR
    // AFTER THE PLANTS ARE FILTERED, IN PREPARE FOR SEGUE, RANDOMLY CHOOSE 6 PLANTS TO PASS THROUGH TO THE NEXT PAGE
    // 3 PLANTS THAT ARE LOW (GROWTH HABIT: GRAMINOID), 2 PLANTS THAT ARE MEDIUM (GROWTH HABIT:SHRUB), AND 1 THAT IS TALL (GROWTH HABIT: TREE)
    // ON THE NEXT VIEW, SHOW THE PLANTS SELECTED.  GIVE OPTION FOR USER TO PICK AGAIN. SHOW CORRESPONDING PLANT SYMBOLS FOR EACH PLANT.
    // ON THE NEXT PAGE, LET THE USER MOVE THE PLANTS AROUND AND ADD MORE OF EACH.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomPlantFilterCell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! CustomPlantFilterCell

        // Configure the cell...
        cell.plantFilterCellDelegate = self
        cell.filterLabel.text = filterOptions[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // set the next destination's "drawnImageDate" as this "drawnImageDate" then pass once more
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
