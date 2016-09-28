//
//  Line.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/28/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation; import UIKit

// line class tells where each line starts and ends so that we can have an array of lines
class Line {
    var start: CGPoint
    var end: CGPoint
    
    init(start _start: CGPoint, end _end: CGPoint) {
        start = _start
        end = _end
    }
}
