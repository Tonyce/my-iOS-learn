//
//  LocationsViewController.swift
//  keep
//
//  Created by D_ttang on 15/5/17.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit
import CoreLocation

class LocationsViewController: UIViewController, CLLocationManagerDelegate {
    
    var location: CLLocation?
    let locationManager = CLLocationManager()
    var lastLocationError: NSError?
    var timer: NSTimer?
    var updatingLocation = false
    
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeocodingError: NSError?
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var getButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func getLocation() {
        
        let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if authStatus == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .Denied || authStatus == .Restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        if updatingLocation {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            placemark = nil
            lastGeocodingError = nil
            startLocationManager()
        }
        
        printLocations()
        configureGetButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("didFailWithError \(error)")
            
        if error.code == CLError.LocationUnknown.rawValue {
            return
        }
            
        lastLocationError = error

        stopLocationManager()
        configureGetButton()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last as! CLLocation
                
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }
                
        if newLocation.horizontalAccuracy < 0 {
            return
        }
                
        var distance = CLLocationDistance(DBL_MAX)
        if let location = location {
            distance = newLocation.distanceFromLocation(location)
        }
                
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
                    
            lastLocationError = nil
            location = newLocation
            printLocations()
                    
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("*** We're done!")
                stopLocationManager()
                configureGetButton()
                    
                if distance > 0 {
                    performingReverseGeocoding = false
                }
            }
                    
            if !performingReverseGeocoding {
                print("*** Going to geocode")
                        
                performingReverseGeocoding = true
    
                geocoder.reverseGeocodeLocation(location,
                    completionHandler: { placemarks, error in
                        print("*** Found placemarks: \(placemarks), error: \(error)")
                
                        self.lastGeocodingError = error
                        if error == nil && !placemarks.isEmpty {
                            self.placemark = placemarks.last as? CLPlacemark
                        } else {
                            self.placemark = nil
                        }
                        
                        self.performingReverseGeocoding = false
                        self.printLocations()
                    })
            
            } else if distance < 1.0 {
                let timeInterval = newLocation.timestamp.timeIntervalSinceDate(location!.timestamp)
                if timeInterval > 10 {
                    print("*** Force done!")
                    stopLocationManager()
                    configureGetButton()
                }
            }
        }
    }
    
    //--
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled",message: "Please enable location services for this app in Settings.",preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        presentViewController(alert, animated: true, completion: nil)
        alert.addAction(okAction)
    }
    
    // --
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        
            timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("didTimeOut"), userInfo: nil, repeats: false)
        }
    }
    
    func stopLocationManager() {
        if updatingLocation {
            if let timer = timer {
                timer.invalidate()
            }
            
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    func configureGetButton() {
        if updatingLocation {
            getButton.setTitle("Stop", forState: .Normal)
        } else {
            getButton.setTitle("Get My Location", forState: .Normal)
        }
    }
    
    func printLocations(){
            
        if let location = location {
            latitude.text = String(format: "%.8f", location.coordinate.latitude)
            longitude.text = String(format: "%.8f", location.coordinate.longitude)
        } else {
            var statusMessage: String!
            if let error = lastLocationError {
                if error.domain == kCLErrorDomain && error.code == CLError.Denied.rawValue {
                    statusMessage = "Location Services Disabled"
                } else {
                    statusMessage = "Error Getting Location"
                }
            } else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "Location Services Disabled"
            } else if updatingLocation {
                statusMessage = "Searching..."
            } else {
                statusMessage = "Tap 'Get My Location' to Start"
            }
            print("error: \(statusMessage)")
        }
    }
}
