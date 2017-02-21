//
//  ParkingLocationDetailsViewController.swift
//  CanIPark
//
//  Created by David Wang on 1/19/17.
//  Copyright © 2017 David Wang. All rights reserved.
//

import UIKit
import CoreData

class ParkingInfoCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlotImage1: UIImageView!
    @IBOutlet weak var timeSlotImage2: UIImageView!
    @IBOutlet weak var timeSlotImage3: UIImageView!
    @IBOutlet weak var timeSlotImage4: UIImageView!
    @IBOutlet weak var timeSlotImage5: UIImageView!
    @IBOutlet weak var timeSlotImage6: UIImageView!
    @IBOutlet weak var timeSlotImage7: UIImageView!
    
}

class ParkingLocationDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var parkingDetailLabel: UITextView!
    var parkingInfoObject = ParkingInfo()
    //temp variable for now
    var parkingSignInfoObject = ParkingInfoSign()
    
    //@IBOutlet weak var parkingTrueFalseLabel: UITextView!
    @IBOutlet weak var parkingStreetCodeLabel: UILabel!
    
    @IBOutlet weak var parkingInfoTable: UITableView!
    
    let timeLabelArray = ["12 AM", "1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "4 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM", "12 PM"]
    
    @IBAction func doneButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        parkingDetailLabel.text = parkingSignInfoObject.returnSignDescription()
        parkingStreetCodeLabel.text = parkingSignInfoObject.streetCode
        
        parkingInfoTable.delegate = self
        parkingInfoTable.dataSource = self
        
        //parkingTrueFalseLabel.text = ""
        //parkingTrueFalseLabel.text = parkingInfoObject.

    }
    
    //attempt at core data
    //var managedObjectContext: NSManagedObjectContext!
    var managedContext: NSManagedObjectContext!
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func saveParkingLocationButton(_ sender: Any) {
    
        //var newArray = UserDefaults.standard.array(forKey: "savedLocations")!
        
        //newArray.append(parkingSignInfoObject)
        //UserDefaults.standard.setValue(newArray, forKey: "savedLocations")
        //print(newArray)
        
        //attempt at core data storage
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: context)
        
        let locationObject = NSManagedObject(entity: entity!, insertInto: context)

        
        locationObject.setValue(parkingSignInfoObject.latitude, forKey: "latitude")
        locationObject.setValue(parkingSignInfoObject.longitude, forKey: "longitude")
        locationObject.setValue("sign description", forKey: "signDescription")
        
        //get user description, maybe put in its own function later
        let alert = UIAlertController(title: "Description",
                                      message: "Add a description",
                                      preferredStyle: .alert)
        
        var userDescriptionInput = "[No Description]"
        
        //messy - find better way to do this later
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                
                                                return
                                        }
                                        userDescriptionInput = nameToSave
                                        locationObject.setValue(userDescriptionInput, forKey: "userDescription")
                                        
                                        do {
                                            try context.save()
                                            print("saved!")
                                        } catch {
                                            print("did not save, you bum")
                                        }
        }
        

        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
 

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 5
    }*/
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parkingInfoCell", for: indexPath) as! ParkingInfoCell
        cell.timeLabel.text = timeLabelArray[indexPath.row]
        //print(indexPath)
        return cell
        
    }
    


}
