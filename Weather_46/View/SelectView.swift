//
//  SelectView.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/29.
//

import SwiftUI

struct SelectView: View {
    
    @EnvironmentObject var contentViewModel:ContentViewModel
    
    @Binding var isShowing: Bool
    
    @Binding var todouhukenn: String
    
    var body: some View {
        //listの引数が意味分かってない
        List(contentViewModel.kenmei, id: \.self){ name in
            Button{
               //引数に県名を渡す
                contentViewModel.getWeather(kenmei: name)
                todouhukenn = name
                isShowing.toggle()
            } label: {
                Text(name)
            }
            
        }
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView(isShowing: .constant(false), todouhukenn: .constant("")).environmentObject(ContentViewModel())
    }
}
