//
//  DrawView.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/28/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation; import UIKit

class DrawView: UIView {
    
    // array of lines from our line class
    var lines: [Line] = []
    var lastPoint: CGPoint!
    var swiped = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // set the background image to be the map
        self.backgroundColor = UIColor.black
    }
    
    // get touch input from user - turn them into points - use those points to initiate a new line - add that line to the array of lines
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first as UITouch! {
            lastPoint = touch.location(in: self)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first as UITouch! {
            let currentPoint = touch.location(in: self)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
        
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
//        let touch = touches.first as UITouch!
//        let newPoint = touch?.location(in: self)
//        lines.append(Line(start: lastPoint, end: newPoint!))
//        // reset the start locaiton for the next line
//        lastPoint = newPoint
//        
//        // every time a new line is added, this will cause the graphics stack to redraw the view and call the method below
//        self.setNeedsDisplay()
    }
    
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint) {
        // get access to drawing context
        let context = UIGraphicsGetCurrentContext()
        // draw lines onto context
        context?.beginPath()
        for line in lines {
        // for each line object, we move to the start of it, the add a line to the end of it
        context?.move(to: CGPoint(x: line.start.x, y: line.start.y))
        context?.addLine(to: CGPoint(x: line.end.x, y: line.end.y))
        context?.setLineCap(CGLineCap.round)
        }
        // set stroke (with color)
        context?.setBlendMode(CGBlendMode.normal)
        context?.setStrokeColor(red: 1,green: 1,blue: 0,alpha: 1)
        context?.strokePath()
    }

    
    
    // draw
//    override func draw(_ rect: CGRect) {
//        // get access to drawing context
//        let context = UIGraphicsGetCurrentContext()
//        // draw lines onto context
//        context?.beginPath()
//        for line in lines {
//            // for each line object, we move to the start of it, the add a line to the end of it
//            context?.move(to: CGPoint(x: line.start.x, y: line.start.y))
//            context?.addLine(to: CGPoint(x: line.end.x, y: line.end.y))
//            context?.setLineCap(CGLineCap.round)
//        }
//        // set stroke (with color)
//        context?.setBlendMode(CGBlendMode.normal)
//        context?.setStrokeColor(red: 1,green: 1,blue: 0,alpha: 1)
//        context?.strokePath()
//    }
}
