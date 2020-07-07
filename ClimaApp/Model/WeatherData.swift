//
//  WeatherData.swift
//  ClimaApp
//
//  Created by Ahmed Gaber on 6/28/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}
struct Weather: Codable {
    let id: Int
}
