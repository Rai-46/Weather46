//
//  Weather_46App.swift
//  Weather_46
//
//  Created by cmStudent on 2021/12/23.
//

import SwiftUI

@main
struct Weather_46App: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ContentViewModel())
        }
    }
}
