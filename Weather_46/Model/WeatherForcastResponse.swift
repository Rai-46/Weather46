//
//  WeatherForcastResponse.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/28.
//

import Foundation

struct WeatherForcastResponse: Decodable {
    let hourly: [Hourly]?
    struct Hourly: Decodable {
        //時刻
        let dt: Int?
        //気温（４８時間）
        let temp: Double?
        
        let pop: Double?
        
        let weather: [WeatherHourly]?
        
        
    }
    
    struct WeatherHourly: Decodable {
        let icon: String?
    }
    
    let daily: [Daily]?
    
    struct Daily: Decodable {
        let dt: Int?
        let temp: Temp?
        let pop: Double?
        let weather: [WeatherDaily]?
        
    }
    
    struct Temp: Decodable {
        //最高気温
        let max: Double?
        //最低気温
        let min: Double?
    }
    
    struct WeatherDaily: Decodable {

        let icon: String?
    }
    
}

struct ForcastHour: Identifiable {
    let id = UUID()
    let dt: String
    let temp: String
    let icon: String
    let pop: String
}

struct ForcastWeek: Identifiable {
    let id = UUID()
    let dt: String
    let max: String
    let min: String
    let icon: String
    let pop: String
}
