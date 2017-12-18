//
//  FiveDayViewControllerTableViewController.swift
//  WeatherApp
//
//  Created by Bhakhrani on 12/17/17.
//  Copyright © 2017 Bhakhrani. All rights reserved.
//

import UIKit
import CoreLocation

class FiveDayViewControllerTableViewController: UITableViewController, CLLocationManagerDelegate {
    func kelvinToFarenheit(kelvinTemp: Double) -> Double {
        return ((kelvinTemp * 1.8) - 459.67)
    }
    
    var fiveDayData = [WeatherData]()
    let manager = CLLocationManager()
    
    func updateFiveDay(weatherData: [WeatherData]) {
        self.fiveDayData = weatherData
            
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let weather = Weather()
        if GlobalCityData.useLocation {
            weather.getFiveDayWeather(lat: String(location.coordinate.latitude), lon: String(location.coordinate.longitude), closure: updateFiveDay)
        }
        else {
            let weather = Weather()
            weather.getFiveDayWeather(city: GlobalCityData.name, closure: updateFiveDay)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadInputViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("five day forcast")
        manager.delegate = self
        if GlobalCityData.useLocation {
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        }
        else {
            let weather = Weather()
            weather.getFiveDayWeather(city: GlobalCityData.name, closure: updateFiveDay)
        }
        print(GlobalCityData.name)
        //manager.startMonitoringSignificantLocationChanges()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fiveDayData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fiveDayCell", for: indexPath)

        let weatherObject = fiveDayData[indexPath.row]
        cell.textLabel?.text = weatherObject.description
        cell.detailTextLabel?.text = String(format: "%.2f", kelvinToFarenheit(kelvinTemp: weatherObject.tempMax)) + " \u{00B0}F / " + String(format: "%.2f", kelvinToFarenheit(kelvinTemp: weatherObject.tempMin)) + " \u{00B0}F"
        cell.imageView?.image = UIImage(named: weatherObject.iconName)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
