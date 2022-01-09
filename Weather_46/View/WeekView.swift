//
//  WeekView.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/29.
//

import SwiftUI

struct WeekView: View {
    
    var day: String = "12/29"
    var max: String = "0"
    var min: String = "0"
    var icon: String = "sample"
    var pop: String = "0"
    
    var body: some View {
        HStack{
            Text(day)
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
            Spacer()
            Text("\(max)℃")
                .foregroundColor(Color.red)
            Spacer()
            Text("\(min)℃")
                .foregroundColor(Color.blue)
            Spacer()
            Text("\(pop)%")
            
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
