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
    private var description: String
    private var temp: Double
    private var tempMin: Double
    private var tempMax: Double
    init(currLat:String, currLon:String){
        lat = currLat
        lon = currLon
        description = ""
        temp = 0
        tempMin = 0
        tempMax = 0
        getWeatherData()
    }
    
    func setLocation(currLat:String, currLon:String) {
        lat = currLat
        lon = currLon
        getWeatherData()
    }
    
    func getTemp() -> Double? {
        if temp == 0 && tempMin == 0 && tempMax == 0 {
            return nil
        } else {
            return ((temp-273.15)*1.8 + 32)
        }
    }
    
    func getMinTemp() -> Double? {
        if temp == 0 && tempMin == 0 && tempMax == 0 {
            return nil
        } else {
            return ((tempMin-273.15)*1.8 + 32)
        }
    }
    
    func getMaxTemp() -> Double? {
        if temp == 0 && tempMin == 0 && tempMax == 0 {
            return nil
        } else {
            return ((tempMax-273.15)*1.8 + 32)
        }
    }
    
    func getDescription() -> String? {
        if description == "" {
            return nil
        } else {
            return description
        }
    }
    
    private func getWeatherData(){
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
                //print("JSON: \n\(json)\n")
                
                if let dictionary = json as? [String: Any] {
                    print(dictionary)
                    if let main = dictionary["main"] as? [String: Any] {
                        if let tmpTemp = main["temp"] as? Double {
                            self.temp = tmpTemp
                            print(self.temp)
                        }
                        if let tmpTempMin = main["temp_min"] as? Double {
                            self.tempMin = tmpTempMin
                            print(self.tempMin)
                        }
                        if let tmpTempMax = main["temp_max"] as? Double {
                            self.tempMax = tmpTempMax
                            print(self.tempMax)
                        }
                    } else {
                        print("main not a sub dictionary")
                    }
                    if let weatherArray = dictionary["weather"] as? [[String: Any]] {
                        if let description = weatherArray[0]["description"] as? String {
                            print(description)
                        }
                        
                    } else {
                        print("weatther is not an array")
                    }
                } else {
                    print("JSON invalid")
                }
            }
        }
        
        session.resume()
        
    }
    
}
