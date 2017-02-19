//
//  SavedLocationsViewController.swift
//  CanIPark
//
//  Created by David Wang on 2/18/17.
//  Copyright © 2017 David Wang. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var signIDLabel: UILabel!
}

class SavedLocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var locationTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTable.delegate = self
        locationTable.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let newArray = UserDefaults.standard.array(forKey: "savedLocations")!
        return newArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        
        /*let newArray = UserDefaults.standard.array(forKey: "savedLocations")
        let newParkingSignObject = newArray[indexPath]
        cell.signIDLabel.text = String(newParkingSignObject*/
        return cell
        
    }



}
