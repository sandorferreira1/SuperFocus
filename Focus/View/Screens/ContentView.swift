//
//  ContentView.swift
//  Focus
//
//  Created by sandor ferreira on 22/10/23.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings
import SwiftData

struct ContentView: View {
    @State private var appsPickerIsPresented = false
    @EnvironmentObject var manager: FocusModeManager
    @ObservedObject var appState = AppState.shared
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Group {
            switch appState.state {
            case .requestAuthorization:
                RequestAuthorizationView()
            case .focusMode:
                HomeView()
            }
        }
    }
    
    // MARK: - Home View
    /// The view that appears on Home Screen when state is focusMode (on or off)
    @ViewBuilder
    private func HomeView() -> some View {
        ZStack {
            LinearGradient(colors: [.topGradient, .bottomGradient], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "eyeglasses")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.top, 60)
                
                ScrollView(.vertical) {
                    LockedAppsView(selection: $manager.activitySelection)
                        .modelContext(context)
                    .padding()
                }
                
                Spacer()
                
                Button {
                    appState.toggleFocusMode()
                    if appState.state == .focusMode(on: true) {
                        FocusModeManager.shared.setShieldRestrictions()
                    } else if appState.state == .focusMode(on: false) {
                        FocusModeManager.shared.clearAllShieldRestrictions()
                    }
                    
                } label: {
                    Text(appState.actionTitle)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.bottomGradient)
                        .background(
                            RoundedRectangle(cornerRadius: 35)
                                .fill(.white)
                                .frame(width: 200, height: 60)
                        )
                }
            }
            .safeAreaPadding(.bottom, 16)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FocusModeManager())
        .environmentObject(ManagedSettingsStore())
}
