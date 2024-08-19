//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Moody on 2024-08-19.
//

import SwiftUI

@main
struct Weather_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
