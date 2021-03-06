//
//  ViewController.swift
//  CanIPark
//
//  Created by David Wang on 1/17/17.
//  Copyright © 2017 David Wang. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

class ViewController: UIViewController, GMSMapViewDelegate {
    
    //used to determine current location
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    
    @IBOutlet weak var controllerView: UIView!
    
    //NSUserDefaults for saved locations, we won't have much info so it should be okay
    var savedLocationsArray = [ParkingInfoSign]()
    var savedLocationsArray2 = [String]()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //var managedContext: NSManagedObjectContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let defaults = UserDefaults.standard
        
        UserDefaults.standard.setValue(savedLocationsArray, forKey: "savedLocations")
        
        // for getting current location
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.78, longitude: -73.95, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 50.0, right: 0.0)
        mapView.padding = mapInsets
        mapView.delegate = self
        view = mapView
        
        //let zoomLevel = mapView.camera.zoom
        //print(zoomLevel)

        if let path = Bundle.main.path(forResource: "JSONData", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile:path)
            {
                do { if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                        //set default value as middle of central park
                        //find out how to get rid of this later
                        var position = CLLocationCoordinate2D(latitude: 40.771980, longitude: -73.974828)
                        
                        for (key, value) in jsonResult {

                            //print("marker mapped")
                            let streetArray = value as! NSArray
                            
                            //duplicate code - fix later
                            let streetSignArray = streetArray[0] as! NSArray
                            let coordinateStartEndArray = streetArray[streetArray.count - 1] as! NSArray
                            let coordinateStart = coordinateStartEndArray[0] as! NSArray
                            let coordinateEnd = coordinateStartEndArray[1] as! NSArray
                            
                            //loop through streetArray to add all street signs
                            
                            //let newParkingInfoObj = ParkingInfo(newStreetCode: key as! String)
                            
                            let newParkingInfoObj = ParkingInfo(newStreetCode: key as! String, newLatitudeStart: coordinateStart[0] as! Double, newLatitudeEnd: coordinateEnd[0] as! Double, newLongitudeStart: coordinateStart[1] as! Double, newLongitudeEnd: coordinateEnd[1] as! Double)
                            //print("parkinginfo object initialized")
                            
                            //temp fix until we can get something else
                            var loop = 0
                            
                            for streetSign in streetArray {
                                
                                let streetSignArray = streetSign as! NSArray

                                loop += 1
                                
                                if loop != streetArray.count {
                                    
                                    let coordinateArray = streetSignArray[2] as! NSArray
                                    
                                    let newParkingSign = ParkingInfoSign(newLatitude: coordinateArray[1] as! Double, newLongitude: coordinateArray[0] as! Double, newStreetCode: key as! String, newSignDescription: streetSignArray[1] as! String)
                                    
                                    newParkingInfoObj.addSignInfo(signInfo: newParkingSign)
                                    
                                    position = CLLocationCoordinate2D(latitude: coordinateArray[1] as! Double, longitude: coordinateArray[0] as! Double)
                                    
                                    let marker = GMSMarker(position: position)
                                    //marker.userData = newParkingInfoObj
                                    marker.icon = UIImage(named: "MapMarker")
                                    marker.userData = newParkingSign
                                    marker.map = mapView
                                    
                                }
                                
                            }
                            
                            let streetArrayLength: Int = streetArray.count - 1
                            //print(streetArrayLength)
                            print(streetArray[streetArrayLength])
                            
                            let streetCoordinateArray = streetArray[streetArrayLength] as! NSArray
                            
                            print(streetCoordinateArray[0])
                            
                            //test out drawing out a line
                            //let path = GMSMutablePath()
                            
                        }
                    }
                    
                    } catch {
                    print(error)
                    print("there was an error reading the data")
                }
            }
        }
        
        // how to draw a line
        /*let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 40.78, longitude: -73.95))
        path.add(CLLocationCoordinate2D(latitude: 40.82, longitude: -74.15))
        let polyline = GMSPolyline(path: path)
        polyline.spans = [GMSStyleSpan(color: .red)]
        polyline.isTappable = true
        polyline.map = mapView*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }

    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        
        /*geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
            guard error == nil else {
                return
            }
            
            if let result = response?.firstResult() {
                let marker = GMSMarker()
                marker.position = cameraPosition.target
                marker.title = result.lines?[0]
                marker.snippet = result.lines?[1]
                marker.map = mapView
            }
        }*/
        //print("Map stopped moving")
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        //print("Line has been tapped")
    }
    
    //FIX THIS
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        //let storeMarker = marker as StoreMarker
        //performSegueWithIdentifier("productMenu", sender: storeMarker.store)
        let parkingInfoFromMarker = marker.userData as! ParkingInfoSign
        //let parkingInfoFromMarker = marker.userData as? ParkingInfoSign
        performSegue(withIdentifier: "presentParkingInfo", sender: parkingInfoFromMarker)
        
    }
    
    //fix segue functions later
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("in prepare for segue")
        if segue.identifier == "presentParkingInfo" {
            let controller = segue.destination as! ParkingLocationDetailsViewController
            //print("first line ran")
            let parkingInfoFromMarker = sender as! ParkingInfoSign
            //print("second lines ran")
            controller.parkingSignInfoObject = parkingInfoFromMarker
            //print("third line ran")
        }
    }
    
    //custom info window
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)?.first as! CustomInfoWindow
        //let currentParkingInfo: ParkingInfo = (marker.userData as? ParkingInfo)!
        //infoWindow.detailsLabel.text = currentParkingInfo.returnStreetCode()
        let currentParkingInfo: ParkingInfoSign = (marker.userData as? ParkingInfoSign)!
        infoWindow.detailsLabel.text = currentParkingInfo.returnSignDescription()
        return infoWindow
    }
    

}

extension ViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        //print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }

    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
}



