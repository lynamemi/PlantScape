//
//  PlantFiltersTableViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/28/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit; import SwiftCSV

class PlantFiltersTableViewController: UITableViewController, CustomPlantFilterCellDelegate {
    
    var listOfDicts = [Plant]()
    var countPlants = 0
    let filterOptions = ["Drought Tolerant", "Shade Loving", "Evergreen"]
    var selectedState: String?
    var drawnImageDate: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedState!)
        // read csv file
        print("FIRST")
        let csvURL = Bundle(for: ViewController.self).url(forResource: "usdaPlantsEdited", withExtension: "csv")!
        print("SECOND")
        do {
            let csv = try CSV(url: csvURL as NSURL)
            print("THIRD")
            csv.enumerateAsDict () { dict in
//                print(arr)
//                self.countPlants += 1
//                if self.countPlants < 11 {
//                    print(arr)
//                self.listOfDicts.append(dict)
//                } else {
//                    return
//                }
                let plant = Plant(droughtTolerant: dict["DroughtTolerance"]!, shadeLoving: dict["ShadeTolerance"]!, evergreen: dict["LeafRetention"]!, growthHabit: dict["GrowthHabit"]!, states: dict["State"]!)
                self.listOfDicts.append(plant)
            }
            print("FORTH")
            print(listOfDicts[1].growthHabit)
        } catch {
            print(error)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // PLANT FILTERING FUNCTIONS
//    func filterHighDroughtTolerance() {
//        let filteredDict = listOfDicts.filter {
//            dict in
//            return dict["DroughtTolerance"] == "High" || dict["DroughtTolerance"] == "Medium"
//        }
//        print(filteredDict)
//    }
//    func filterShadeTolerance() {
//        let filteredDict = listOfDicts.filter {
//            dict in
//            return dict["ShadeTolerance"] == "Tolerant"
//        }
//        print(filteredDict)
//    }
//    func filterLeafRetention() {
//        let filteredDict = listOfDicts.filter {
//            dict in
//            return dict["LeafRetention"] == "Yes"
//        }
//        print(filteredDict)
//    }

    func didSwitchOnAtIndexPathOfCell(sender: CustomPlantFilterCell) {
//        let index = tableView.indexPath(for: sender)
//        if sender.filterLabel.text == filterOptions[0] {
//            filterHighDroughtTolerance()
//        }
//        if sender.filterLabel.text == filterOptions[1] {
//            filterShadeTolerance()
//        }
//        if sender.filterLabel.text == filterOptions[2] {
//            filterLeafRetention()
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
