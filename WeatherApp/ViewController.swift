//
//  ViewController.swift
//  WeatherApp
//
//  Created by Bhakhrani on 12/13/17.
//  Copyright © 2017 Bhakhrani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBAction func setCityClicked(_ sender: UIButton) {
        print("City button clicked")
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let weather = Weather(currLat: "33.7592", currLon: "-117.9897")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

