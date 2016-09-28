//
//  ViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/25/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit; import SwiftCSV

class ViewController: UIViewController {
    
//    let csv = CSV(string: "betydb.species.id,Genus,Species,ScientificName,CommonName,Symbol,State,Duration,GrowthHabit,FlowerColor,FlowerConspicuous,FoliageColor,FoliagePorositySummer,FoliagePorosityWinter,FoliageTexture,FruitColor,FruitConspicuous,GrowthForm,GrowthRate,MaxHeight20Yrs,MatureHeight,LeafRetention,Shape_and_Orientation,DroughtTolerance,MoistureUse,SalinityTolerance,ShadeTolerance,TemperatureMinimum,BloomPeriod,CommercialAvailability\n3,Abies,NA,Abies,fir spp.,ABIES,USA(AK, AZ, CO, CT, GA, IA, ID, IN, MA, MD, ME, MI, MN, MT, NC, NH, NM, NV, NY, OH, OR, PA, RI, TN, UT, VA, VT, WA, WI, WV, WY), CAN(AB, BC, LB, MB, NB, NF, NS, NT, NU, ON, PE, QC, SK, YT, CA), FRA(SPM),,,,,,,,,,,,,0,0,,,,,,,0,,")
    
    var listOfDicts = [[String:String]]()
    var countPlants = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let csvURL = Bundle(for: ViewController.self).url(forResource: "usdaPlantsEdited", withExtension: "csv")!
        do {
            let csv = try CSV(url: csvURL as NSURL)
            csv.enumerateAsDict { tempDict in
                self.countPlants += 1
                if self.countPlants < 11 {
                    self.listOfDicts.append(tempDict)
                }
            }
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func filterHighDroughtTolerance() {
        var filteredDict = listOfDicts.filter {
            dict in
            return dict["DroughtTolerance"] == "Low"
        }
        print(filteredDict)
    }
    
}

