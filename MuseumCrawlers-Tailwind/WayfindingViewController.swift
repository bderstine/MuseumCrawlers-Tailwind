//
//  WayfindingViewController.swift
//  MuseumCrawlers-Tailwind
//
//  Created by Brad Derstine on 5/6/18.
//  Copyright © 2018 Brad Derstine. All rights reserved.
//

import UIKit
import PMAMobileFramework
import CoreLocation

struct Gallery {
    var id = 111
    var name = "Gallery 111 - American Art"
}

class WayfindingViewController: UIViewController {

    @IBOutlet weak var GalleryName: UILabel!
    
    let defaults = UserDefaults.standard
    private let locationManager = GalleryLocationManager(locationManager: CLLocationManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //updateGalleryInfo()
        let someGallery = Gallery()
        GalleryName.text = someGallery.name
        
        Constants.backend.host = "https://hackathon.philamuseum.org";
        
        // Make sure to set the API key here, otherwise the app will scream!
        Constants.backend.apiKey = "removed-for-security-purposes";
        
        do {
            NSLog("Retrieving location assets from backend...\n")
            try BackendService.shared.retrieveGeolocationData(completion: {
                DispatchQueue.main.async {
                    NSLog("Successfully loaded location assets from backend.\n")
                    //self.locationSensingButton.isEnabled = true
                }
            })
        } catch let error {
            NSLog("Error loading location assets from backend: \(error)\n")
        }
        
        checkPermissions()
        startLocationSensing()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGalleryInfo(){
        


//        if let something = defaults.object(forKey: "didFirstGallery") as? String {
//            GalleryName.text = "GALLERY 116 - AMERICAN ART"
//        } else {
//            GalleryName.text = "GALLERY 111 - AMERICAN ART"
//        }
        //GalleryName.text = "GALLERY 244 - ASIAN ART"
    }

    func checkPermissions(){
        locationManager.delegate = self as? GalleryLocationManagerDelegate
    
        // we need to ask the user for when in use permissions
        locationManager.requestPermissions()
    }
    
    func startLocationSensing() {
        
        // setting ourselfs up as delegate for location updates
        locationManager.delegate = self as? GalleryLocationManagerDelegate
        
        // we need to ask the user for when in use permissions
        locationManager.requestPermissions()
        
        do {
            try locationManager.startLocationRanging(with: Constants.locationSensing.method.apple)
            NSLog("Starting Location Sensing...\n")
            //self.locationSensingButton.isEnabled = false
        } catch let error {
            NSLog("Error starting Location Sensing: \(error)\n")
        }
        
        // this is a sample test call to match a given location with the geojson file
        // note that we need to set ignoreFloors to true since we cannot define a floor in CLLocation (yeah, really...)
        //        let location = CLLocation(latitude: 39.965186632142064, longitude: -75.1815766902897)
        //        let matchedLocation = LocationStore.sharedInstance.locationForCLLocation(location: location, ignoreFloors: true)
        //        print("Location: \(String(describing: matchedLocation?.name))") // this will return gallery 119
        
    }
    
    @IBAction func ImHere(_ sender: Any) {
        performSegue(withIdentifier: "ViewGallery", sender: nil)
    }
    
}

extension ViewController : GalleryLocationManagerDelegate {
    func locationManager(locationManager: GalleryLocationManager, didEnterKnownLocation location: Location) {
        // do your magic here
        DispatchQueue.main.async {
            NSLog("Entered Location: \(location.name) \n")
            self.performSegue(withIdentifier: "ViewGallery", sender: nil)
        }
    }
    
    @nonobjc func locationManager(locationManager: GalleryLocationManager, didUpdateHeading newHeading: CLHeading) {
    }
    
}

