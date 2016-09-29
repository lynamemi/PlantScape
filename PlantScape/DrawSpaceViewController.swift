//
//  DrawSpaceViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/28/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit

class DrawSpaceViewController: UIViewController {
    
    var lastPoint: CGPoint!
    var swiped = false
    var color = UIColor.yellow.cgColor
    var imageDate = Double()
    var drawnImageDate = Double()
    var selectedState: String?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loadingAlertLabel: UILabel!
    @IBOutlet weak var drawImageView: UIImageView!
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        drawImageView.image = nil
    }
    @IBAction func brushColorButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Pick a Brush Color", message: "choose one that you can read easily over your image", preferredStyle: .alert)
        let changeBrushColorToBlack = UIAlertAction(title: "Black", style: .default) {
            (action: UIAlertAction!) -> Void in
            self.color = UIColor.black.cgColor
        }
        let changeBrushColorToRed = UIAlertAction(title: "Red", style: .default) {
            (action: UIAlertAction!) -> Void in
            self.color = UIColor.red.cgColor
        }
        let changeBrushColorToYellow = UIAlertAction(title: "Yellow", style: .default) {
            (action: UIAlertAction!) -> Void in
            self.color = UIColor.yellow.cgColor
        }
        alert.addAction(changeBrushColorToBlack)
        alert.addAction(changeBrushColorToRed)
        alert.addAction(changeBrushColorToYellow)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveDrawingButtonPressed(_ sender: UIButton) {
        loadingAlertLabel.text = "Please wait while we save your drawing and load your plant choices"
        loadingAlertLabel.isHidden = false
        saveDrawnImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageDate)
        backgroundImageView.image = imageFromUrlString(double: imageDate)
        self.view.backgroundColor = UIColor.lightGray
        loadingAlertLabel.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // get touch input from user - turn them into points - use those points to initiate a new line - add that line to the array of lines
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first as UITouch! {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first as UITouch! {
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        drawImageView.image?.draw(in: CGRect(x:0, y:0, width: self.view.frame.width, height: self.view.frame.height))
        // get access to drawing context
        let context = UIGraphicsGetCurrentContext()
        // for each line object, we move to the start of it, the add a line to the end of it
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // set stroke (with color)
        context?.setLineCap(CGLineCap.round)
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineWidth(5)
        context?.setStrokeColor(color)
        context?.strokePath()
        
        drawImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    
    func imageFromUrlString(double: Double) -> UIImage? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0].appending("/"+String(double)+".png")
        print(path)
        if let data = NSData(contentsOfFile: path) {
            let image = UIImage(data: data as Data)
            return image
        }
        print("couldn't return image")
        return nil
    }
    
    func saveDrawnImage() {
        if let image = drawImageView.image {
            drawnImageDate = NSDate().timeIntervalSince1970
            let data = UIImagePNGRepresentation(image)
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = "\(paths[0])/\(drawnImageDate as Double).png"
            let url = URL(fileURLWithPath: path)
            do {
                try data?.write(to: url, options: .atomicWrite)
                performSegue(withIdentifier: "PlantFilters", sender: -1)
            } catch {
                print(error)
            }
        } else {
            print("doesn't like image")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PlantFiltersTableViewController
        destination.drawnImageDate = drawnImageDate
        destination.selectedState = selectedState
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
