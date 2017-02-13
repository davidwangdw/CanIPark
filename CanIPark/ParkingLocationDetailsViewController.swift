//
//  ParkingLocationDetailsViewController.swift
//  CanIPark
//
//  Created by David Wang on 1/19/17.
//  Copyright © 2017 David Wang. All rights reserved.
//

import UIKit

class ParkingLocationDetailsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var parkingDetailLabel: UITextView!
    var parkingInfoObject = ParkingInfo()
    //temp variable for now
    var parkingSignInfoObject = ParkingInfoSign()
    
    @IBOutlet weak var parkingTrueFalseLabel: UITextView!
    
    @IBAction func doneButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        parkingDetailLabel.text = parkingSignInfoObject.returnSignDescription()
        //parkingTrueFalseLabel.text = ""
        //parkingTrueFalseLabel.text = parkingInfoObject.


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 5
    }*/
    


}
