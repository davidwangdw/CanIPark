//
//  SavedLocationsViewController.swift
//  CanIPark
//
//  Created by David Wang on 2/18/17.
//  Copyright © 2017 David Wang. All rights reserved.
//

import UIKit
import CoreData

class LocationCell: UITableViewCell {
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var signIDLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    @IBOutlet weak var streetNameLabel: UILabel!
}

class SavedLocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var locationTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTable.delegate = self
        locationTable.dataSource = self

    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationTable.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //core data
    
    
    let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*let newArray = UserDefaults.standard.array(forKey: "savedLocations")!
        return newArray.count*/
        do {
            let results = try getContext().fetch(fetchRequest)
            
            return results.count

        } catch {
            print("there was an error \(error)")
            
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        
        //consolidate code later like this
        /*let location = fetchedResultsController.object(at: indexPath)
        cell.configure(for: location)*/
        
        do {
            let results = try getContext().fetch(fetchRequest)
            
            //let location = fetchRequest.object(at: indexPath)
            
            let latitude = results[indexPath.row].value(forKey: "latitude") as! Double
            let longitude = results[indexPath.row].value(forKey: "longitude") as! Double
            
            let latitudeString = String(format: "%.5f", latitude)
            let longitudeString = String(format: "%.5f", longitude)
            let coordinates = latitudeString + "," + longitudeString
            cell.coordinateLabel.text = coordinates
            cell.userDescriptionLabel.text = String(describing: results[indexPath.row].value(forKey: "userDescription")!)
            cell.streetNameLabel.text = ""
            cell.signIDLabel.text = String(describing: results[indexPath.row].value(forKey: "signDescription")!)
            
            return cell
            
            /*for loc in results as [NSManagedObject] {
                print("\(loc.value(forKey: "userDescription"))")
            }*/
        } catch {
            print("there was an error \(error)")
            
            cell.signIDLabel.text = "Sorry, there was an error"
            
            return cell
        }
        
        /*let newArray = UserDefaults.standard.array(forKey: "savedLocations")
        //let newParkingSignObject = newArray[indexPath.row]
        let newObject = newArray?[indexPath.row] as! ParkingInfoSign?
        cell.signIDLabel.text = newObject?.returnSignDescription()
        return cell*/
        
    }
    
    //attempt at core data
    //var managedObjectContext: NSManagedObjectContext!
    //var managedContext: NSManagedObjectContext!

    /*func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            /*let context = getContext()
            
            do {
                let results =  try getContext().fetch(fetchRequest)
                let location = results[indexPath.row]
                context.delete(location)
                try context.save()

            } catch {
                print("ERORR! ERRRORR!!!!")
            }*/

        }
    }*/



}
