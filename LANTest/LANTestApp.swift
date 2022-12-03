//
//  LANTestApp.swift
//  LANTest
//
//  Created by Owen Hildreth on 7/21/22.
//

import SwiftUI

@main
struct LANTestApp: App {
    @StateObject var controller = MultimeterController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(controller: controller)
                .frame(minWidth: 300, minHeight: 300, alignment: .topLeading)
        }
    }
}
