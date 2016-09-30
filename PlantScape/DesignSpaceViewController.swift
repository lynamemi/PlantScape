//
//  DesignSpaceViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/29/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit

class DesignSpaceViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var drawnImageDate: Double?
    var shrub1Location = CGPoint(x: 0, y: 0)
    var shrub2Location = CGPoint(x: 0, y: 0)
    var shrub3Location = CGPoint(x: 0, y: 0)

    @IBOutlet weak var shrub3Image: UIImageView!
    @IBOutlet weak var shrub2Image: UIImageView!
    @IBOutlet weak var shrub1Image: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var grass1Image: UIImageView!
    @IBOutlet weak var grass2Image: UIImageView!
    @IBOutlet weak var grass3Image: UIImageView!
    @IBOutlet weak var grass4Image: UIImageView!
    @IBOutlet weak var tree1Image: UIImageView!
    @IBOutlet weak var tree2Image: UIImageView!
    
    @IBAction func shrub2Move(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func plantTapped(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Add More Trees", message: "select the number of trees you want to use for your project", preferredStyle: .alert)
        let addImage = UIAlertAction(title: "add", style: .default) { (action: UIAlertAction!) -> Void in
            print("figure out how to add new images on tap - maybe segue to a controller where you can set all quantities")
            var imageViewObject: UIImageView
            
            imageViewObject = UIImageView(frame: CGRect(x: 100, y: 100, width: 70, height: 70))
            imageViewObject.image = UIImage(named:"tree1.png")
            self.view.addSubview(imageViewObject)
        }
        alert.addAction(addImage)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let layer = UIApplication.shared.keyWindow?.layer
        UIGraphicsBeginImageContextWithOptions((backgroundImage.image?.size)!, true, (backgroundImage.image?.scale)!)
        layer?.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved!", message: "Your drawing has been saved to your photo library", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) {
            (action: UIAlertAction!) -> Void in
            print("ok")
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(drawnImageDate)
        backgroundImage.image = imageFromUrlString(double: drawnImageDate!)
        shrub1Image.image = #imageLiteral(resourceName: "shrub1")
        shrub2Image.image = #imageLiteral(resourceName: "shrub2")
        shrub3Image.image = #imageLiteral(resourceName: "shrub3")
        grass1Image.image = #imageLiteral(resourceName: "grass1")
        grass2Image.image = #imageLiteral(resourceName: "grass2")
        grass3Image.image = #imageLiteral(resourceName: "grass3")
        grass4Image.image = #imageLiteral(resourceName: "grass4")
        tree1Image.image = #imageLiteral(resourceName: "tree1")
        tree2Image.image = #imageLiteral(resourceName: "tree2")
        shrub1Image.center = CGPoint(x: 160, y: 330)
        shrub2Image.center = CGPoint(x: 150, y: 350)
        shrub3Image.center = CGPoint(x: 120, y: 300)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
