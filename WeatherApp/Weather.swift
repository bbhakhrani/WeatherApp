//
//  File.swift
//  WeatherApp
//
//  Created by Bhakhrani on 12/13/17.
//  Copyright © 2017 Bhakhrani. All rights reserved.
//

import Foundation

struct WeatherData {
    var temp:Double
    var tempMin:Double
    var tempMax:Double
    var description: String
    var city: String
    var iconName: String
    var date: Date
}

class Weather{
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/"
    private let openWeatherMapAPIKey = "5b986aec3061a6ebe330affa40fbac0a"
    init(){
    }
    
    private func parseData(dictionary:[String:Any]) -> WeatherData {
        var temp:Double = 0
        var tempMin:Double = 0
        var tempMax:Double = 0
        var description = ""
        var city = ""
        var iconName = ""
        var time:Double = 0
        
        if let tmpCity = dictionary["name"] as? String {
            city = tmpCity
        }
        else {
            print("error wth name \n\n\n\n\n\n\n\n")
        }
        if let UTC = dictionary["dt"] as? Double {
            time = UTC
        }
            if let main = dictionary["main"] as? [String: Any] {
                if let tmpTemp = main["temp"] as? Double {
                    temp = tmpTemp
                }
                if let tmpTempMin = main["temp_min"] as? Double {
                    tempMin = tmpTempMin
                }
                if let tmpTempMax = main["temp_max"] as? Double {
                    tempMax = tmpTempMax
                }
            } else {
                print("main not a sub dictionary")
            }
            if let weatherArray = dictionary["weather"] as? [[String: Any]] {
                if let tmpDescription = weatherArray[0]["description"] as? String {
                    description = tmpDescription
                }
                if let tmpIconName = weatherArray[0]["icon"] as? String {
                    iconName = tmpIconName
                }
                
            } else {
                print("weatther is not an array")
            }
        let weatherData = WeatherData(temp: temp, tempMin: tempMin, tempMax: tempMax, description: description, city: city, iconName: iconName, date: Date(timeIntervalSince1970: time))
        
        return weatherData
    }
    func getWeatherData(city: String, closure: @escaping (WeatherData) -> ()) {
        let escapedCity = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print(escapedCity!)
        let weatherRequestURLString = "\(openWeatherMapBaseURL)weather?q=\(escapedCity!)&appid=\(openWeatherMapAPIKey)"
        if let weatherRequestURL = URL(string: weatherRequestURLString) {
        let session = URLSession.shared.dataTask(with: weatherRequestURL){(data, response, error) in
            if let error = error { //Error when getting data
                print("\n\n\n\n\n\n\n\nError: \n\(error)\n\n\n\n\n\n\n")
            }
            else { //Success
                print("\n\n\n\n\n\n\n\n\nsuccess")
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                //print(json!)
                if let dictionary = json as? [String: Any] {
                    print(dictionary)
                    let weatherData = self.parseData(dictionary: dictionary)
                    closure(weatherData)
                } else {
                    print("JSON invalid")
                }
            }
        }
        session.resume()

        }
        else {
            print(weatherRequestURLString)
        }
        
        
    }
    
    func getWeatherData(lat:String, lon:String, closure: @escaping (WeatherData) -> ()) {
        let weatherRequestURLString = "\(openWeatherMapBaseURL)weather?lat=\(lat)&lon=\(lon)&appid=\(openWeatherMapAPIKey)"
        let weatherRequestURL = URL(string: weatherRequestURLString)!
        let session = URLSession.shared.dataTask(with: weatherRequestURL){(data, response, error) in
            if let error = error { //Error when getting data
                print("Error: \n\(error)")
            }
            else { //Success
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let dictionary = json as? [String: Any] {
                    let weatherData = self.parseData(dictionary: dictionary)
                    closure(weatherData)
                } else {
                    print("JSON invalid")
                }
            }
        }
        
        session.resume()
        
    }
    
    func getFiveDayWeather(city: String, closure: @escaping ([WeatherData]) -> ()) {
        let escapedCity = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let weatherRequestURLString = "\(openWeatherMapBaseURL)forecast?q=\(escapedCity!)&appid=\(openWeatherMapAPIKey)"
        let weatherRequestURL = URL(string: weatherRequestURLString)!
        let session = URLSession.shared.dataTask(with: weatherRequestURL){(data, response, error) in
            if let error = error { //Error when getting data
                print("Error: \n\(error)")
            }
            else { //Success
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                var fiveDayData = [WeatherData]()
                if let dictionary = json as? [String: Any] {
                    if let dataArray = dictionary["list"] as? [[String:Any]] {
                        var j = 0;
                        var i = 0;
                        while i < dataArray.count {
                            fiveDayData.append(self.parseData(dictionary: dataArray[i]))
                            j+=1
                            i+=8
                        }
                        print(fiveDayData.count)
                        closure(fiveDayData)
                    } else {
                        print("ErrorError")
                    }
                } else {
                    print("Error")
                }
            }
        }
        session.resume()
    }
    
    func getFiveDayWeather(lat:String, lon:String, closure: @escaping ([WeatherData]) -> ()) {
        let weatherRequestURLString = "\(openWeatherMapBaseURL)forecast?lat=\(lat)&lon=\(lon)&appid=\(openWeatherMapAPIKey)"
        let weatherRequestURL = URL(string: weatherRequestURLString)!
        let session = URLSession.shared.dataTask(with: weatherRequestURL){(data, response, error) in
            if let error = error { //Error when getting data
                print("Error: \n\(error)")
            }
            else { //Success
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                var fiveDayData = [WeatherData]()
                if let dictionary = json as? [String: Any] {
                    if let dataArray = dictionary["list"] as? [[String:Any]] {
                        var j = 0;
                        var i = 0;
                        while i < dataArray.count {
                            fiveDayData.append(self.parseData(dictionary: dataArray[i]))
                            j+=1
                            i+=8
                        }
                        print(fiveDayData.count)
                        closure(fiveDayData)
                    } else {
                        print("ErrorError")
                    }
                } else {
                    print("Error")
                }
            }
        }
        session.resume()
    }
    
}
