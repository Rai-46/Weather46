//
//  WeatherCurrent.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/23.
//

import Foundation

struct WeatherCurrentResponse: Decodable {
    
    //現在の天気のやつ
    let coord: Coord?
    struct Coord: Decodable {
        let lon: Double?
        let lat: Double?
    }
    
    let weather: [Weather]?
    struct Weather: Decodable {
        let id: Int?
        let description: String?
        let icon: String?
    }
    
    let main: Main?
    struct Main: Decodable {
        //気温
        let temp: Double?
        //湿度
        let humidity: Double?
    }
    
    let sys: Sys?
    struct Sys: Decodable {
        //日の出時刻
        let sunrise: Int?
        //日の入り時刻
        let sunset: Int?
    }
}
