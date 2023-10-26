//
//  AppActivityView.swift
//  Focus
//
//  Created by sandor ferreira on 23/10/23.
//

import SwiftUI
import ManagedSettings

struct AppActivityView: View {
    @Bindable var app: AppModel
    @State private var openApp: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Label(app.token)
                .labelStyle(.titleAndIcon)
                .padding()
            
            Spacer()
            
            Toggle("", isOn: $app.blocked)
                .padding(.horizontal, 16)
        }
        .sheet(isPresented: $openApp) {
            AppOpennedDurationPickerView(appModel: app)
                .interactiveDismissDisabled(false)
                .presentationCornerRadius(15)
                .presentationDetents([.height(300)])
        }
        .onChange(of: app.blocked) { _, newValue in
            openApp = !newValue
            if newValue {
                FocusModeManager.shared.setShieldRestriction(for: app.token)
            }
        }
    }
}
