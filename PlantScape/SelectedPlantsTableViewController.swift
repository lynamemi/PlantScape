//
//  PlantFiltersTableViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/28/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit; import SwiftCSV; import WebKit

class SelectedPlantsTableViewController: UITableViewController, CustomPlantFilterCellDelegate, CancelButtonDelegate {
    
    var countPlants = 0
    let filterOptions = ["Drought Tolerant", "Shade Loving", "Evergreen"]
    var selectedState: String?
    var drawnImageDate: Double?
    var newPlants: PlantList?
    var currentRandomTrees = [Plant]()
    var currentRandomShrubs = [Plant]()
    var currentRandomGrasses = [Plant]()
    var allRandomPlants = [Plant]()
    var trees = [Plant]()
    var shrubs = [Plant]()
    var grasses = [Plant]()
    var plantToSearch = ""
    
    
    @IBAction func usePlantsSelected(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Design", sender: -1)
    }
    @IBAction func loadPlantsButtonPressed(_ sender: AnyObject) {
        tableView.reloadData()
    }
    @IBAction func chooseNewPlantsPressed(_ sender: UIBarButtonItem) {
        currentRandomTrees = [Plant]()
        currentRandomShrubs = [Plant]()
        currentRandomGrasses = [Plant]()
        allRandomPlants = [Plant]()
        pickRandomGrass()
        pickRandomGrass()
        pickRandomGrass()
        pickRandomShrub()
        pickRandomShrub()
        pickRandomShrub()
        pickRandomTree()
        pickRandomTree()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        trees = (newPlants?.filterTree())!
        shrubs = (newPlants?.filterShub())!
        grasses = (newPlants?.filterGrass())!
        pickRandomGrass()
        pickRandomGrass()
        pickRandomGrass()
        pickRandomShrub()
        pickRandomShrub()
        pickRandomShrub()
        pickRandomTree()
        pickRandomTree()
    }
    
    func pickRandomTree() {
        let randomTreeIndex = Int(arc4random_uniform(UInt32(UInt(trees.count))))
        let currentTree = trees[randomTreeIndex]
        if currentTree.name != "" {
            if currentRandomTrees.count == 0 {
                currentRandomTrees.append(currentTree)
                allRandomPlants.append(currentTree)
            } else {
                for tree in currentRandomTrees {
                    if tree.id != currentTree.id {
                        currentRandomTrees.append(currentTree)
                        allRandomPlants.append(currentTree)
                    } else {
                        pickRandomTree()
                    }
                }
            }
        } else {
            pickRandomTree()
        }
    }
    func pickRandomShrub() {
        let randomShrubIndex = Int(arc4random_uniform(UInt32(UInt(shrubs.count))))
        let currentShrub = shrubs[randomShrubIndex]
        if currentShrub.name != "" {
            if currentRandomShrubs.count == 0 {
                currentRandomShrubs.append(currentShrub)
                allRandomPlants.append(currentShrub)
            } else {
                for shrub in currentRandomShrubs {
                    if shrub.id != currentShrub.id {
                        currentRandomShrubs.append(currentShrub)
                        allRandomPlants.append(currentShrub)
                    } else {
                        pickRandomShrub()
                    }
                }
            }
        } else {
            pickRandomShrub()
        }
    }
    func pickRandomGrass() {
        let randomGrassIndex = Int(arc4random_uniform(UInt32(UInt(grasses.count))))
        let currentGrass = grasses[randomGrassIndex]
        if currentGrass.name != "" {
            if currentRandomGrasses.count == 0 {
                currentRandomGrasses.append(currentGrass)
                allRandomPlants.append(currentGrass)
            } else {
                for grass in currentRandomGrasses {
                    if grass.id != currentGrass.id {
                        currentRandomGrasses.append(currentGrass)
                        allRandomPlants.append(currentGrass)
                    } else {
                        pickRandomGrass()
                    }
                }
            }
        } else {
            pickRandomGrass()
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
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return (allRandomPlants.count)
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedPlant", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = allRandomPlants[indexPath.row].name
        cell.detailTextLabel?.text = allRandomPlants[indexPath.row].growthHabit
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let name = allRandomPlants[indexPath.row].name
        plantToSearch = name.replacingOccurrences(of: " ", with: "")
        performSegue(withIdentifier: "Web", sender: (indexPath as NSIndexPath).row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? Int {
            print(button)
            if button < 0 {
                let destination = segue.destination as! DesignSpaceViewController
                destination.drawnImageDate = drawnImageDate
            } else {
                let navController = segue.destination as! UINavigationController
                let controller = navController.topViewController as! WebViewController
                controller.cancelDelegate = self
                controller.plantName = plantToSearch
            }
        } else {
            let navController = segue.destination as! UINavigationController
            let controller = navController.topViewController as! WebViewController
            controller.cancelDelegate = self
            controller.plantName = plantToSearch
        }
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
