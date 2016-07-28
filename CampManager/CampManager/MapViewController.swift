//
//  MapViewController.swift
//  CampManager
//
//  Created by Jason Chan MBP on 5/5/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import MapKit
import UIKit
import CoreData

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBAction func backButtonMap(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    var appDelegate: AppDelegate!
    var sharedContext: NSManagedObjectContext!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    @IBAction func mapType(sender: AnyObject) {
        if mapView.mapType == MKMapType.Standard {
            mapView.mapType = MKMapType.Satellite
        } else {
            mapView.mapType = MKMapType.Standard
        }
    }
    @IBAction func findMeButton(sender: AnyObject) {
        
        let userLocation = mapView.userLocation
        
        if userLocation.location != nil {
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)
        
        
        mapView.setRegion(region, animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkLocationAuthorizationStatus()
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.showsUserLocation = true
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        sharedContext = appDelegate.managedObjectContext
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "dropPin:")
        
        longPress.minimumPressDuration = 0.5
        
        mapView.addGestureRecognizer(longPress)
        
        mapView.addAnnotations(fetchAllPins())
        
        
        
    }
    
    // MARK: - Pins
    
    func dropPin(gestureRecognizer: UIGestureRecognizer) {
        
        let tapPoint: CGPoint = gestureRecognizer.locationInView(mapView)
        let touchMapCoordinate: CLLocationCoordinate2D = mapView.convertPoint(tapPoint, toCoordinateFromView: mapView)
        
        if UIGestureRecognizerState.Began == gestureRecognizer.state {
            //initialize our Pin with our coordinates and the context from AppDelegate
            let pin = Pin(annotationLatitude: touchMapCoordinate.latitude, annotationLongitude: touchMapCoordinate.longitude, context: appDelegate.managedObjectContext)
            //add the pin to the map
            mapView.addAnnotation(pin)
            
            
            appDelegate.saveContext()
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        let pin = view.annotation as! Pin
        //delete from our context
        sharedContext.deleteObject(pin)
        //remove the annotation from the map
        mapView.removeAnnotation(pin)
        //save our context
        appDelegate.saveContext()
    }
    
    
    func fetchAllPins() -> [Pin] {
        
        let error: NSErrorPointer = nil
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Pin")
        // Execute the Fetch Request
        let results: [AnyObject]?
        do {
            results = try sharedContext.executeFetchRequest(fetchRequest)
        } catch let error1 as NSError {
            error.memory = error1
            results = nil
        }
        // Check for Errors
        if error != nil {
            print("Error in fectchAllActors(): \(error)")
        }
        // Return the results, cast to an array of Pin objects
        return results as! [Pin]
    }
    
    
    // MARK: - Live Updates
    func mapView(mapView: MKMapView, didUpdateUserLocation
        userLocation: MKUserLocation) {
        print(userLocation)
        
    }
    
    
    
    // MARK: - location manager to authorize user location for Maps app
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    


    
}
