//
//  WebViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/29/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var plantName = String()
    var cancelDelegate: CancelButtonDelegate?
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        cancelDelegate?.cancelButtonPressedFrom(controller: self)
    }
    @IBOutlet weak var webSearchView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.google.com/search?q=\(plantName)")!
        webSearchView.loadRequest(URLRequest(url: url))
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
