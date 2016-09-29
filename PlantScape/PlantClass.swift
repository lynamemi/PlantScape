//
//  PlantClass.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/29/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation

class Plant {
    let droughtTolerant: String
    let shadeLoving: String
    let evergreen: String
    let growthHabit: String
    let states: String
    init(droughtTolerant: String, shadeLoving: String, evergreen: String, growthHabit: String, states: String ) {
        self.droughtTolerant = droughtTolerant
        self.shadeLoving = shadeLoving
        self.evergreen = evergreen
        self.growthHabit = growthHabit
        self.states = states
    }
//    static let list = PlantList()
}
