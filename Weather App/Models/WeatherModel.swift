//
//  WeatherModel.swift
//  Weather App
//
//  Created by Moody on 2024-08-23.
//

import Foundation

struct WeatherModel: Codable {
    var name: String
    let main: Main
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let description: String
    }
    
    var temperature: String {
        return String(format: "%.0f", main.temp - 273.15) + "°C" // Converting Kelvin to Celsius
    }
    
    var condition: String {
        return weather.first?.description.capitalized ?? "N/A"
    }
}
