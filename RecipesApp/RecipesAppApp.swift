//
//  RecipesAppApp.swift
//  RecipesApp
//
//  Created by Ramandeep Singh on 11/25/24.
//

import SwiftUI

@main
struct RecipesAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(networkMonitor: NetworkConnection())
        }
    }
}
