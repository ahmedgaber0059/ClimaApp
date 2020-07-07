//
//  WeatherManger.swift
//  ClimaApp
//
//  Created by Ahmed Gaber on 6/26/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherMangerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error	)
}

struct WeatherManger {
    let weatherURL = "https://samples.openweathermap.org/data/2.5/weather?&appid=925a5b05367004c5ba659590074333c4"
    var delegate: WeatherMangerDelegate?
	
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"

        performRequest(with: urlString)
    }
    
    func fetchWeather (latitude: CLLocationDegrees , longtitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(with: urlString)
        
    }
    
    func performRequest (with urlString: String){
        //1-create url
        if let url = URL(string: urlString) {
            //2-create session
            let session = URLSession (configuration: .default)
            
            //3-give the session task
            let task = session.dataTask(with: url) { (data, reponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                    //return mean break funnc
                }
                if let safeData = data {
                    //let dataString = String (data:  safeData, encoding: .utf8)
                    
                    //we add self cause closure
                    if let weather = self.parseJSNO(weatherData: safeData){
			    self.delegate?.didUpdateWeather(weather: weather)
                        
                    }
                }
            }
            //4-start the task
            task.resume()
        }
   
    }
    
    func parseJSNO(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder ()
        do{
            
            //self to refrence to type not object
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel (condtionId: id, cityName: name, temperature: temp)
   
            return weather
        }
        catch {
            delegate?.didFailWithError(error: error)

            return nil
        }
        
    }

}








