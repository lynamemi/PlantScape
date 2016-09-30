//
//  PlantListModel.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/29/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation; import SwiftCSV

class PlantList {
    
    var plantList = [Plant]()
    var ready = false
    var whenReadyCompletionHandler: (()->())? = nil
    
    init() {
        print("FIRST")
        let csvURL = Bundle(for: ViewController.self).url(forResource: "usdaPlantsEdited", withExtension: "csv")!
        print("SECOND")
        let backgroundQueue = DispatchQueue(label: "com.app.queue", qos: .background, target: nil)
        backgroundQueue.async {
            do {
                let csv = try CSV(url: csvURL as NSURL)
                print("THIRD")
                csv.enumerateAsDict () { dict in
                    let plant = Plant(droughtTolerant: dict["DroughtTolerance"]!, shadeLoving: dict["ShadeTolerance"]!, evergreen: dict["LeafRetention"]!, growthHabit: dict["GrowthHabit"]!, states: dict["State"]!, id: dict["betydb.species.id"]!, name: dict["CommonName"]!)
                    self.plantList.append(plant)
                }
                print("FORTH")
                self.whenReadyCompletionHandler?()
                self.ready = true
            } catch {
                print("Error in saving plants: \(error)")
            }
        }
    }
    
    func whenReady(completion: @escaping ()->() ) {
        if ready {
            completion()
        }
        whenReadyCompletionHandler = completion
    }
    
    // PLANT FILTERING FUNCTIONS
    func filterHighDroughtTolerance(listOfPlants: [Plant]) {
        let filteredDroughtPlants = listOfPlants.filter {
            list in
            return list.droughtTolerant == "High" || list.droughtTolerant == "Medium"
        }
    }
    func filterShadeTolerance(listOfPlants: [Plant]) {
        let filteredShadePlants = listOfPlants.filter {
            list in
            return list.shadeLoving == "Tolerant"
        }
    }
    func filterLeafRetention(listOfPlants: [Plant]) {
        let filteredEvergreenPlants = listOfPlants.filter {
            list in
            return list.evergreen == "Yes"
        }
    }
    
    // add state filter
//    func filterState(state: String) {
//        let filteredStates = plantList.filter {
//            list in
//            if let rangeOfState = list.states.range(of: state){
//                print(rangeOfState)
//                if (list.states.range(of: state) != nil) {
//                    return list.states == list.statrangeOfState
//                }
//                
//            }
//            return list.states
//        }
//    }
    
    
    func filterTree() -> [Plant] {
        let filteredTrees = plantList.filter {
            list in
            return list.growthHabit == "Tree"
        }
        print(filteredTrees)
        return filteredTrees
    }
    func filterShub() -> [Plant] {
        let filteredShrubs = plantList.filter {
            list in
            return list.growthHabit == "Shrub"
        }
        print(filteredShrubs)
        return filteredShrubs
    }
    func filterGrass() -> [Plant] {
        let filteredGrass = plantList.filter {
            list in
            return list.growthHabit == "Graminoid"
        }
        print(filteredGrass)
        return filteredGrass
    }
}
