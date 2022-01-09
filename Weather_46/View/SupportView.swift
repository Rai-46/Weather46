//
//  SupportView.swift
//  Weather_46
//
//  Created by cmStudent on 2022/01/01.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        ZStack{
            Color.gray
                             .ignoresSafeArea()
            VStack{
                Text("日付")
                    .foregroundColor(Color.white)
                Spacer()
                Text("気温")
                    .foregroundColor(Color.white)
                Text("降水確率")
                    .foregroundColor(Color.white)
            }
        }
        
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
