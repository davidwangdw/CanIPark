//
//  ParkingLocationDetailsViewController.swift
//  CanIPark
//
//  Created by David Wang on 1/19/17.
//  Copyright © 2017 David Wang. All rights reserved.
//

import UIKit

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

    @IBAction func saveParkingLocationButton(_ sender: Any) {
    
        var newArray = UserDefaults.standard.array(forKey: "savedLocations")!
        let latitude = String(parkingSignInfoObject.latitude)
        let longitude = String(parkingSignInfoObject.longitude)
        let coordinates = latitude + "," + longitude
        newArray.append(coordinates)
        UserDefaults.standard.setValue(newArray, forKey: "savedLocations")
        //print(newArray)
        
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
