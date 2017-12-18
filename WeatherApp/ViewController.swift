//
//  ViewController.swift
//  WeatherApp
//
//  Created by Bhakhrani on 12/13/17.
//  Copyright © 2017 Bhakhrani. All rights reserved.
//

import UIKit
import CoreLocation

struct GlobalCityData {
    static var name = "New York"
    static var useLocation = true
}

class ViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //top 100 cities by population
    var dataArray = ["New York","Los Angeles","Chicago","Houston","Philadelphia","Phoenix","San Antonio","San Diego","Dallas","San Jose","Austin","Indianapolis","Jacksonville","San Francisco","Columbus","Charlotte","Fort Worth","Detroit","El Paso","Memphis","Seattle","Denver","Washington","Boston","Nashville","Baltimore","Oklahoma City","Louisville","Portland","Las Vegas","Milwaukee","Albuquerque","Tucson","Fresno","Sacramento","Long Beach","Kansas City","Mesa","Virginia Beach","Atlanta","Colorado Springs","Omaha","Raleigh","Miami","Oakland","Minneapolis","Tulsa","Cleveland","Wichita","Arlington","New Orleans","Bakersfield","Tampa","Honolulu","Aurora","Anaheim","Santa Ana","St. Louis","Riverside","Corpus Christi","Lexington","Pittsburgh","Anchorage","Stockton","Cincinnati","St. Paul","Toledo","Greensboro","Newark","Plano","Henderson","Lincoln","Buffalo","Jersey City","Chula Vista","Fort Wayne","Orlando","St. Petersburg","Chandler","Laredo","Norfolk","Durham","Madison","Lubbock","Irvine","Winston-Salem","Glendale","Garland","Hialeah","Reno","Chesapeake","Gilbert","Baton Rouge","Irving","Scottsdale","North Las Vegas","Fremont","Boise City","Richmond","San Bernardino"]
    
    var pickedIndex = 0;
    
    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet var CityPicker: UIPickerView! = UIPickerView()
    
    @IBAction func locationSwitch(_ sender: UISwitch) {
        if sender.isOn == false {
            GlobalCityData.useLocation = false
            let weather = Weather()
            weather.getWeatherData(city: GlobalCityData.name, closure: updateToday)
            print(GlobalCityData.useLocation)
        } else {
            GlobalCityData.useLocation = true
            manager.requestLocation()
        }
    }
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
//    @IBOutlet weak var tempLabel: UILabel!
//    
//    @IBOutlet weak var descLabel: UILabel!
//
//    @IBOutlet weak var cityLabel: UILabel!
    
////////////////Picker Related Methods////////////////////
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectTextField.text = dataArray[row]
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        selectTextField.inputAccessoryView = toolbar
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        GlobalCityData.name = selectTextField.text!
        print(GlobalCityData.name)
    }

    
    
///////////////Weather Related Methods//////////////////////////////
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
        let weather = Weather()
        if GlobalCityData.useLocation {
            let location = locations[0]
            weather.getWeatherData(lat: String(location.coordinate.latitude), lon: String(location.coordinate.longitude), closure: updateToday)
        //weather.getFiveDayWeather(lat: String(location.coordinate.latitude), lon: String(location.coordinate.longitude))
        } else {
            print("Use Location is off")
            weather.getWeatherData(city: GlobalCityData.name, closure: updateToday)
        }
        
        
        
    }
//////////Shared Code///////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectTextField.delegate = self
        CityPicker.delegate = self
        CityPicker.dataSource = self
        selectTextField.inputView = CityPicker
        //CityPicker.isHidden = true
        selectTextField.text = dataArray[0]
        createToolbar()
        
        
    
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

