//
//  AppOpennedDurationPickerView.swift
//  Focus
//
//  Created by sandor ferreira on 24/10/23.
//

import SwiftUI

struct AppOpennedDurationPickerView: View {
    @Bindable var appModel: AppModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .center) {
            HeaderView()
                .vSpacing(.top)
            
            Text("How long you want to use the app?")
                .font(.headline)
            
            TimeStepperView(duration: $appModel.openingDuration)
                .vSpacing(.center)
            
            Button {
                FocusModeManager.shared.open(app: appModel, for: appModel.openingDuration)
                appModel.openned()
                dismiss()
            } label: {
                Text("Confirm")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.accentColor)
                            .frame(width: 200, height: 50)
                    )
            }
            .safeAreaPadding(.bottom, 16)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        ZStack {
            VStack {
                Label(appModel.token)
                    .labelStyle(.titleOnly)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            HStack {
                Spacer()
                
                Button {
                    appModel.blocked = true
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .tint(.black.opacity(0.2))
                        .hSpacing(.trailing)
                        .padding(.horizontal, 4)
                }
            }
        }
        .padding(.top, 16)
    }
}
