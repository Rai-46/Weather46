//
//  ContentViewModel.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/29.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    let kenmei = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]
    
    
    //座標
    @Published var lon = 0.0
    
    @Published var lat = 0.0
    
    //id
    @Published var id = 0
    
    //今の気温
    @Published var temp = "0.0"
    
    //今の湿度
    @Published var humidity = "0.0"
    //今の天気
    @Published var description = "今の天気"
    //今のアイコン
    @Published var icon = "sample"
    //今日の日の出
    @Published var sunrise = "00:00"
    //今日の日の入り
    @Published var sunset = "00:00"
    
    
    
    
    //時間予報
    @Published var hourForcast: [ForcastHour] = []

    
    //週間予報
    @Published var weekForcast: [ForcastWeek] = []
    
    
    func getWeather(kenmei: String){
        
        guard let kenmei_encode = kenmei.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        //URLの読み込み
        let currentConverter = CurrentRequest(urlString: "https://api.openweathermap.org/data/2.5/weather?q=\(kenmei_encode)&appid=&lang=ja&units=metric")
        
        
        
        currentConverter.resume() { data, response, error in
            //エラーの確認していかないといけない
            //データがあるかどうか
            guard let data = data else  {
                return
            }
            
            do{
                //受け取ったJSONデータを解析して格納する
                let currentWeather = try JSONDecoder().decode(WeatherCurrentResponse.self, from: data)
                
                
                DispatchQueue.main.async {
                    
                    //coordがあれば値を入れる
                    if let coord = currentWeather.coord {
                        if let lon = coord.lon,
                           let lat = coord.lat{
                            self.lon = lon
                            self.lat = lat
                            self.getForcast(lon: lon, lat: lat)
                            
                        }
                    }
                    
                    
                    //weatherがあれは値を入れる
                    if let weather = currentWeather.weather {
                        for weathers in weather{
                            
                            if let description = weathers.description,
                               let id = weathers.id,
                               let icon = weathers.icon{
                                self.id = id
                                self.description = description
                                self.icon = icon
                                print("今からアイコン撮りたい")
                                //TODO: JSONでアイコンを取得したいけどとりあえずダウンロードしたアイコンで表示させよう
                            }
                            
                        }
                        
                    }
                    
                    //mainがあれば値を入れる
                    if let main = currentWeather.main {
                        if let temp = main.temp,
                           let humidity = main.humidity {
                            self.temp = String((Int)(round((temp * 100)/100)))
                            self.humidity = String((Int)(humidity * 100)/100)
                            print(temp)
                            print("---------")
                        }
                    }
                    
                    //sysがあれば値を入れる
                    if let sys = currentWeather.sys {
                        if let sunrise = sys.sunrise,
                           let sunset = sys.sunset {
                            let rise = Date(timeIntervalSince1970: TimeInterval(sunrise))
                            let set = Date(timeIntervalSince1970: TimeInterval(sunset))
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "HH:mm"
                            self.sunrise = dateFormatter.string(from: rise)
                            self.sunset = dateFormatter.string(from: set)
                        }
                    }
                    
                    
                    print("解析できた")
                    print(currentWeather)
                }
                
            } catch {
                print("エラーです")
                print(error)
            }
        }
    }
    
    
    func getForcast(lon: Double, lat: Double){
        
        
        let forcastConverter = CurrentRequest(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&appid=&lang&units=metric")
        
        forcastConverter.resume() { data, response, error in
            //予報についてのクロージャー書く
            guard let data = data else {
                return
            }
            
            do{
                let forcastWeather = try JSONDecoder().decode(WeatherForcastResponse.self, from: data)
                
                DispatchQueue.main.async {
                    if let hourly = forcastWeather.hourly{
                        self.hourForcast.removeAll()
                        for hourlys in hourly {
                            if let dtFH = hourlys.dt,
                               let tempFH = hourlys.temp,
                               let pop = hourlys.pop,
                               let weather = hourlys.weather{
                                for weathers in weather {
                                    if let iconFH = weathers.icon{
                                        
                                        //プロパティに入れる処理
                                        let time = Date(timeIntervalSince1970: TimeInterval(dtFH))
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "dd日HH"
                                            
                                        let forcasthour = ForcastHour(dt: dateFormatter.string(from: time), temp: String((Int)(round((tempFH * 100)/100))), icon: iconFH, pop: String((Int)(pop * 100)))

                                        self.hourForcast.append(forcasthour)

                                    }
                                    
                                }
                            }
                        }
                    }
                    
                    if let daily = forcastWeather.daily{
                        self.weekForcast.removeAll()
                        for dailys in daily {
                            if let dtFW = dailys.dt,
                               let temp = dailys.temp{
                                if let maxFW = temp.max,
                                   let minFW = temp.min{
                                    if let popFW = dailys.pop,
                                       let weather = dailys.weather{
                                        for weathers in weather{
                                            if let iconFW = weathers.icon{
                                                //プロパティに入れる処理
                                                let time = Date(timeIntervalSince1970: TimeInterval(dtFW))
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "M/d"
                                                
                                                
                                                let forcastWeek = ForcastWeek(dt: dateFormatter.string(from: time), max: String((Int)(round((maxFW * 100)/100))), min: String((Int)(round((minFW * 100)/100))), icon: iconFW, pop: String((Int)(popFW * 100)))
                                                
                                                self.weekForcast.append(forcastWeek)
                                            }
                                        }
                                    }
                                }
                            }
                               
                        }
                    }
                }
            } catch {
                print("予報でエラーです")
                print(error)
            }
        }
    }
    
    func getColor() -> String{
        var color: String = "default"
        if (id >= 200) && (id < 300) {
            color = "200<"
        } else if (id >= 300) && (id < 400) {
            color = "300<"
        } else if (id >= 400) && (id < 500) {
            color = "400<"
        } else if (id >= 500) && (id < 600) {
            color = "500<"
        } else if (id >= 600) && (id < 700) {
            color = "600<"
        } else if (id >= 700) && (id < 800) {
            color = "700<"
        } else if id == 800 {
            color = "800"
        } else if id > 800 {
            color = "800<"
        }
        
        return color
    }
    
}
