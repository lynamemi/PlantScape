//
//  LocationSelectorViewController.swift
//  PlantScape
//
//  Created by Emily Lynam on 9/27/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import UIKit; import MapKit

class LocationSelectorViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var state = ""
    var options = MKMapSnapshotOptions()
    var currentImageDate: Double?
    
    @IBOutlet weak var searchedAddressLabel: UILabel!
    @IBOutlet weak var addressSearchBar: UISearchBar!
    @IBOutlet weak var locationSelectorMapView: MKMapView!
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Draw", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressSearchBar.delegate = self
        locationSelectorMapView.delegate = self
        locationSelectorMapView.mapType = MKMapType.satellite
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //1: Once you click the keyboard search button, the app will dismiss the presented search controller you were presenting over the navigation bar. Then, the map view will look for any previously drawn annotation on the map and remove it since it will no longer be needed.
        addressSearchBar.resignFirstResponder()
        if self.locationSelectorMapView.annotations.count != 0 {
            annotation = self.locationSelectorMapView.annotations[0]
            self.locationSelectorMapView.removeAnnotation(annotation)
        }
        
        //2: After that, the search process will be initiated asynchronously by transforming the search bar text into a natural language query
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = addressSearchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            //3 If the search API returns a valid coordinates for the place, then the app will instantiate a 2D point and draw it on the map within a pin annotation view.
            if self.localSearchRequest == nil {
                let alertController = UIAlertController(title: nil, message: "Location Not Found", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismis", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.searchedAddressLabel.text = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(localSearchResponse!.boundingRegion.center.latitude, localSearchResponse!.boundingRegion.center.longitude)
            
            
            // reverse geolocation to get the state
            let location = CLLocation(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                
                if (placemarks?.count)! > 0 {
                    let pm = placemarks![0]
                    // add conditional for not states
                    self.state = pm.addressDictionary?["State"] as! String
                    print(self.state)
                }
                else {
//                    print("Problem with the data received from geocoder")
                }
            })
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.locationSelectorMapView.addAnnotation(self.pinAnnotationView.annotation!)
            let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            
            let region = MKCoordinateRegionMake(self.pointAnnotation.coordinate, span)
            self.locationSelectorMapView.setRegion(region, animated: true)
        }

        
    }

    
    func saveSnapshot(currentDate: Double) {
        let snapshotter = MKMapSnapshotter()
        snapshotter.start { (snapshot, error) in
            if self.error != nil {
                print(self.error)
                return
            }
            let image = snapshot?.image
            let data = UIImagePNGRepresentation(image!)
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = "\(paths[0])/\(currentDate as Double).png"
            print(path)
            let url = URL(fileURLWithPath: path)
            do {
                try data?.write(to: url, options: .atomicWrite)
                // call some sort of func
                //
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.currentImageDate = NSDate().timeIntervalSince1970
        
        
        let destination = segue.destination as! DrawSpaceViewController
        
        saveSnapshot(currentDate: currentImageDate!) // pass in a handler
        
        destination.imageDate = currentImageDate!
        print(currentImageDate)
        // snapshot handler
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
