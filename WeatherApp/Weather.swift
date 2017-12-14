//
//  File.swift
//  WeatherApp
//
//  Created by Bhakhrani on 12/13/17.
//  Copyright © 2017 Bhakhrani. All rights reserved.
//

import Foundation

class Weather{
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "5b986aec3061a6ebe330affa40fbac0a"
    private var lat: String
    private var lon: String
    init(currLat:String, currLon:String){
        lat = currLat;
        lon = currLon;
    }
    
    func setLocation(currLat:String, currLon:String) {
        lat = currLat;
        lon = currLon;
    }
    
    func getWeather(){
        let weatherRequestURLString = "\(openWeatherMapBaseURL)?lat=\(lat)&lon=\(lon)&appid=\(openWeatherMapAPIKey)"
        let weatherRequestURL = URL(string: weatherRequestURLString)!
        let session = URLSession.shared.dataTask(with: weatherRequestURL){(data, response, error) in
            if let error = error { //Error when getting data
                print("Error: \n\(error)")
            }
            else { //Success
                //print("Raw Data:\n\(data)")
                //let dataString = String(data: data!, encoding: String.Encoding.utf8)
                //print("Readable Data: \n\(dataString!)")
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("JSON: \n\(json)")
            }
        }
        
        session.resume()
        
    }
    
}
