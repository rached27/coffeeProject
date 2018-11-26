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

    var locationManager: CLLocationManager!
    @IBOutlet weak var map: MKMapView!
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
    let allAnnotations = self.map.annotations
    self.map.removeAnnotations(allAnnotations)
    addAnnotations(coffee: selectedCoffee!)
    goToLocation(lattitude: (selectedCoffee?.latitude)!, longitude: (selectedCoffee?.longitude)!)
    }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    
    
    
    
    
    
    @IBAction func currentPosition(_ sender: Any) {
        let userlocation = map.userLocation
        let region = MKCoordinateRegionMakeWithDistance((userlocation.location?.coordinate)!, 1500, 1500)
        map.setRegion(region, animated: true)
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
        map.addAnnotation(coffeePoint)
    }
    
    func goToLocation(lattitude:Double,longitude:Double){
        let location = CLLocationCoordinate2DMake(lattitude, longitude)
        let region = MKCoordinateRegionMakeWithDistance((location), 1500, 1500)
        map.setRegion(region, animated: true)
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
