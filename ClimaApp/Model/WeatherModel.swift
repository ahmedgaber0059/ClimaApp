//
//  WeatherModel.swift
//  ClimaApp
//
//  Created by Ahmed Gaber on 6/30/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let condtionId : Int
    let cityName: String
    let temperature : Double
    
     //computed value
    var temperatureString: String {
        return String (format: "%.1f", temperature)
    }
    
    //computed value
    var conditionName: String {
        switch condtionId {
        case   200 ... 232:
            return "5"
            
        case   300 ... 321:
            return "4"
        default:
            return "1"
        }
    }



}
