//
//  HomeViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/30/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    @IBAction func getStartedButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Start", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "plantBackground"))
        getStartedButton.layer.cornerRadius = 20
        getStartedButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
