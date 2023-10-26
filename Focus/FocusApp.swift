//
//  FocusApp.swift
//  Focus
//
//  Created by sandor ferreira on 22/10/23.
//

import SwiftUI
import ManagedSettings
import SwiftData

@main
struct FocusApp: App {
    @StateObject var model = FocusModeManager.shared
    @StateObject var store = ManagedSettingsStore(named: .focus)
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: AppModel.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(store)
        }
        .modelContainer(modelContainer)
    }
}
