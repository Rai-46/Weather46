//
//  HourView.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/29.
//

import SwiftUI

struct HourView: View {
    @EnvironmentObject var contentViewModel:ContentViewModel
    
    var time: String = "0"
    var icon: String = "sample"
    var temp: String = "0.0"
    var pop: String = "0.0"
    

    var body: some View {
        
        VStack{
            Text("\(time)時")
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            Text("\(temp)℃")
            Text("\(pop)%")
        }
    }
}

//struct HourView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourView().environmentObject(ContentViewModel())
//    }
//}
