//
//  RequestAuthorizationView.swift
//  Focus
//
//  Created by sandor ferreira on 24/10/23.
//

import SwiftUI
import FamilyControls
import Combine

struct RequestAuthorizationView: View {
    @State private var message: String = WelcomeMessages.messages.first ?? ""
    @State private var timer: AnyCancellable?
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.topGradient, .bottomGradient], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("SuperFocus")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .fontWeight(.thin)
                    .padding(.top, 60)
                
                Spacer()
                
                Text(message)
                    .font(.body)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    let ac = AuthorizationCenter.shared
                    Task {
                        do {
                            try await ac.requestAuthorization(for: .individual)
                            if ac.authorizationStatus == .approved {
                                AppState.shared.setState(.focusMode(on: false))
                            }
                        } catch {
                            fatalError("Didnt allow app to monitor app activities")
                        }
                    }
                    
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("Yay")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Text("Authorize")
                        .font(.headline)
                        .fontWeight(.semibold)
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
        .onAppear {
            timer = Timer.publish(every: 3, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    withAnimation {
                        message = WelcomeMessages.randomElement()
                    }
                }
        }
    }
}

#Preview {
    RequestAuthorizationView()
}
