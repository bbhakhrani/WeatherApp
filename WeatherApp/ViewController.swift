//
//  ViewController.swift
//  WeatherApp
//
//  Created by Bhakhrani on 12/13/17.
//  Copyright © 2017 Bhakhrani. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
//    @IBOutlet weak var tempLabel: UILabel!
//    
//    @IBOutlet weak var descLabel: UILabel!
//
//    @IBOutlet weak var cityLabel: UILabel!
    
    
    
    
    func kelvinToFarenheit(kelvinTemp: Double) -> Double {
        return ((kelvinTemp * 1.8) - 459.67)
    }
    
    func updateToday(weatherData: WeatherData) {
        print(weatherData)
        let temp = kelvinToFarenheit(kelvinTemp: weatherData.temp)
        self.tempLabel.text = String(format: "%.2f", temp) + " \u{00B0}F"
        self.tempLabel.sizeToFit()
        self.descLabel.text = weatherData.description
        self.cityLabel.text = weatherData.city
        self.iconImageView.image = UIImage(named: weatherData.iconName)
        
        print("updated")
    }
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let weather = Weather()
        weather.getWeatherData(lat: String(location.coordinate.latitude), lon: String(location.coordinate.longitude), closure: updateToday)
        //weather.getFiveDayWeather(lat: String(location.coordinate.latitude), lon: String(location.coordinate.longitude))
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        manager.startMonitoringSignificantLocationChanges()
        
        //manager.desiredAccuracy left as default (best)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

