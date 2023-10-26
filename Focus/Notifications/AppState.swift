//
//  AppState.swift
//  Focus
//
//  Created by sandor ferreira on 24/10/23.
//

import SwiftUI
import ManagedSettings

// MARK: - App States
///  Request Authorization state represents the screen that asks the user for permission
///  to use both Notification Settings and ScreenTime features
/// - requestAuthorization
///
/// Focus Mode represents the state where the user start shielding apps for a given time
/// When in this mode, the only way to open an app is through the Shield and notification
/// - focusMode(on: Bool)

extension AppState {
    enum State: Equatable {
        case requestAuthorization
        case focusMode(on: Bool)
    }
}

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var state: AppState.State = .requestAuthorization
    @Published var selectTime: Bool = false
    
    func setState(_ state: AppState.State) {
        self.state = state
    }
    
    func toggleFocusMode() {
        guard case let .focusMode(on) = state else { return }
        
        if on {
            setState(.focusMode(on: false))
        } else {
            setState(.focusMode(on: true))
        }
    }
}

extension AppState {
    var actionTitle: String {
        switch state {
        case .requestAuthorization:
            "Authorize"
        case .focusMode(let on):
            on ? "Stop" : "Start"
        }
    }
}
