//
//  ContentView.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var contentViewModel:ContentViewModel
    
    @State var isShowing = false
    
    @State var todouhukenn = "東京都"
    
    
    var body: some View {
        VStack{
            //天気に合わせた背景画像
            ZStack{
                                
                Color(contentViewModel.getColor()).ignoresSafeArea()
                
                VStack{
                    Spacer()
                    Text(todouhukenn)
                        .font(.title)
                        .onTapGesture {
                            isShowing.toggle()
                        }
                        .sheet(isPresented: $isShowing){
                            SelectView(isShowing:$isShowing, todouhukenn: $todouhukenn)
                        }
                    
                    Spacer()

                    Image(contentViewModel.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                    
                    Spacer()
                    
                    Text(contentViewModel.description)
                        .font(.title2)
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        Text("気温：\(contentViewModel.temp)℃")
                        
                        Spacer()
                        
                        Text("湿度：\(contentViewModel.humidity)%")
                        Spacer()
                    }
                    Spacer()

                }
            }.frame(height: 210)
            
            
            List{
                Text("今日の詳細")
                    .font(.title2)
                
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Text("日の出")
                        Spacer()
                        Text("日の入り")
                        Spacer()

                    }
                    Spacer()
                    VStack{
                        Spacer()
                        Text(contentViewModel.sunrise)
                        Spacer()
                        Text(contentViewModel.sunset)
                        Spacer()
                    }
                    Spacer()
                }
                
                
                
                Text("時間ごとの天気")
                    .font(.title2)
                HStack{
                    SupportView().frame(width: 70, height: 150)
                    ScrollView(.horizontal, showsIndicators: true){
                    HStack{
                        ForEach(contentViewModel.hourForcast){ forcast in
                            HourView(time: forcast.dt, icon: forcast.icon, temp: forcast.temp, pop: forcast.pop)
                            
                        }
                    }
                }
                }
                Text("週間予報")
                    .font(.title2)
                
                ForEach(contentViewModel.weekForcast){ forcast in
                    WeekView(day: forcast.dt, max: forcast.max, min: forcast.min, icon: forcast.icon, pop:forcast.pop)
                }
                
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ContentViewModel())
    }
}
