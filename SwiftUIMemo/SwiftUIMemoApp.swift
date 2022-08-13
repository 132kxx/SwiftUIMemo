//
//  SwiftUIMemoApp.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/07/14.
//

import SwiftUI

@main
struct SwiftUIMemoApp: App {
    @StateObject var store = MemoStore()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainListVIew()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
        }
    }
}
