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
    var color = UIColor.orange.cgColor
    var imageDate = Double()
    var drawnImageDate = Double()
    var selectedState: String?
    var newPlants: PlantList?
    
    
    @IBOutlet weak var waitingForCSV: UIActivityIndicatorView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var drawImageView: UIImageView!
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        drawImageView.image = nil
    }
    @IBAction func brushColorButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Pick a Brush Color", message: "choose one that you can read easily over your image", preferredStyle: .alert)
        let changeBrushColorToPurple = UIAlertAction(title: "Purple", style: .default) {
            (action: UIAlertAction!) -> Void in
            self.color = UIColor.purple.cgColor
        }
        let changeBrushColorToRed = UIAlertAction(title: "Red", style: .default) {
            (action: UIAlertAction!) -> Void in
            self.color = UIColor.red.cgColor
        }
        let changeBrushColorToOrange = UIAlertAction(title: "Orange", style: .default) {
            (action: UIAlertAction!) -> Void in
            self.color = UIColor.orange.cgColor
        }
        alert.addAction(changeBrushColorToPurple)
        alert.addAction(changeBrushColorToRed)
        alert.addAction(changeBrushColorToOrange)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveDrawingButtonPressed(_ sender: UIButton) {
        waitingForCSV.startAnimating()
        waitingForCSV.isHidden = false
        newPlants?.whenReady {
            self.waitingForCSV.isHidden = true
            self.waitingForCSV.stopAnimating()
            DispatchQueue.main.async {
                self.saveDrawnImageAndSegue()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageDate)
        backgroundImageView.image = imageFromUrlString(double: imageDate)
        self.view.backgroundColor = UIColor.lightGray
        waitingForCSV.isHidden = true
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
    
    func saveDrawnImageAndSegue() {
        if let image = drawImageView.image {
            drawnImageDate = NSDate().timeIntervalSince1970
            let data = UIImagePNGRepresentation(image)
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = "\(paths[0])/\(drawnImageDate as Double).png"
            let url = URL(fileURLWithPath: path)
            do {
                try data?.write(to: url, options: .atomicWrite)
                performSegue(withIdentifier: "SelectedPlants", sender: -1)
            } catch {
                print(error)
            }
        } else {
            print("doesn't like image")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SelectedPlantsTableViewController
        destination.drawnImageDate = drawnImageDate
        destination.selectedState = selectedState
        destination.newPlants = newPlants
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
