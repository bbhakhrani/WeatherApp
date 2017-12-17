//
//  File.swift
//  WeatherApp
//
//  Created by Bhakhrani on 12/13/17.
//  Copyright © 2017 Bhakhrani. All rights reserved.
//

import Foundation

class Weather{
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/"
    private let openWeatherMapAPIKey = "5b986aec3061a6ebe330affa40fbac0a"
    private var description: String
    private var temp: Double
    private var tempMin: Double
    private var tempMax: Double
    
    init(){
        description = ""
        temp = 0
        tempMin = 0
        tempMax = 0
    }
    
    func getWeatherData(lat:String, lon:String, closure: @escaping ([String: Any]) ->()) {
        let weatherRequestURLString = "\(openWeatherMapBaseURL)weather?lat=\(lat)&lon=\(lon)&appid=\(openWeatherMapAPIKey)"
        let weatherRequestURL = URL(string: weatherRequestURLString)!
        let session = URLSession.shared.dataTask(with: weatherRequestURL){(data, response, error) in
            if let error = error { //Error when getting data
                print("Error: \n\(error)")
            }
            else { //Success
                var weatherData = [String:Any]()
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                if let dictionary = json as? [String: Any] {
                    if let main = dictionary["main"] as? [String: Any] {
                        if let tmpTemp = main["temp"] as? Double {
                            self.temp = tmpTemp
                            weatherData["temp"] = self.temp
                        }
                        if let tmpTempMin = main["temp_min"] as? Double {
                            self.tempMin = tmpTempMin
                            weatherData["tempMin"] = self.tempMin
                        }
                        if let tmpTempMax = main["temp_max"] as? Double {
                            self.tempMax = tmpTempMax
                            weatherData["tempMax"] = self.tempMax
                        }
                    } else {
                        print("main not a sub dictionary")
                    }
                    if let weatherArray = dictionary["weather"] as? [[String: Any]] {
                        if let description = weatherArray[0]["description"] as? String {
                            weatherData["desc"] = description
                        }
                        
                    } else {
                        print("weatther is not an array")
                    }
                } else {
                    print("JSON invalid")
                }
                closure(weatherData)
            }
        }
        
        session.resume()
        
    }
    
    func getFiveDayWeather(lat:String, lon:String) {
        let weatherRequestURLString = "\(openWeatherMapBaseURL)forecast?lat=\(lat)&lon=\(lon)&appid=\(openWeatherMapAPIKey)"
        let weatherRequestURL = URL(string: weatherRequestURLString)!
        let session = URLSession.shared.dataTask(with: weatherRequestURL){(data, response, error) in
            if let error = error { //Error when getting data
                print("Error: \n\(error)")
            }
            else { //Success
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(json!)
            }
        }
        session.resume()
    }
    
}
