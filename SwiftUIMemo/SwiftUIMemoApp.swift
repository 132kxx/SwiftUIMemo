//
//  SwiftUIMemoApp.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/07/14.
//

import SwiftUI

@main
struct SwiftUIMemoApp: App {
    let manager = CoreDataManager.shared
    
    @StateObject var navigationState = NavigationState()

    var body: some Scene {
        WindowGroup {
            MainListVIew()
                .environment(\.managedObjectContext, manager.mainContext)
                .environmentObject(manager)
                .environmentObject(navigationState)
        }
    }
}
