//
//  MapViewController.swift
//  CoffeApp
//
//  Created by Rached Fourati on 26/11/2018.
//  Copyright © 2018 Rached Fourati. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var coffeesArray:Coffees?
    var selectedCoffee:Coffee?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataSource.shared.retrieveData { (coffeesArray) in
            self.coffeesArray = coffeesArray
        }
        if selectedCoffee == nil{
        for coffee in (self.coffeesArray?.bars)!{
            addAnnotations(coffee: coffee)
        }
                    goToLocation(lattitude: (coffeesArray?.bars![0].latitude!)!, longitude: (coffeesArray?.bars![0].longitude!)!)
    }
    else {
    let allAnnotations = self.mapView.annotations
    self.mapView.removeAnnotations(allAnnotations)
    addAnnotations(coffee: selectedCoffee!)
    goToLocation(lattitude: (selectedCoffee?.latitude)!, longitude: (selectedCoffee?.longitude)!)
    }
    }
    
    @IBAction func currentPosition(_ sender: Any) {
        mapView.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
        } else {
            print("PLease turn on location services or GPS")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addAnnotations(coffee:Coffee){
        let address = coffee.name
        let longitude = coffee.longitude
        let lattitude = coffee.latitude
        
        let coffeePoint = MKPointAnnotation()
        coffeePoint.title = address
        coffeePoint.coordinate = CLLocationCoordinate2D(latitude: lattitude!, longitude: longitude!)
        mapView.addAnnotation(coffeePoint)
    }
    
    func goToLocation(lattitude:Double,longitude:Double){
        let location = CLLocationCoordinate2DMake(lattitude, longitude)
        let region = MKCoordinateRegionMakeWithDistance((location), 1500, 1500)
        mapView.setRegion(region, animated: true)
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
