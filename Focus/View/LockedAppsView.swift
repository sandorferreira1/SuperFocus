//
//  LockedAppsView.swift
//  Focus
//
//  Created by sandor ferreira on 25/10/23.
//

import SwiftUI
import FamilyControls
import SwiftData
import ManagedSettings

struct LockedAppsView: View {
    @Query var apps: [AppModel]
    
    @Environment(\.modelContext) private var context
    
    @Binding var selection: FamilyActivitySelection
    @State private var appsPickerIsPresented = false
    
    var body: some View {
        Group {
            if apps.isEmpty {
                EmptyListView()
            } else {
                FilledListView()
            }
        }
        .familyActivityPicker(isPresented: $appsPickerIsPresented, selection: $selection)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .onChange(of: selection, { _, _ in
            selection.applicationTokens.forEach { token in
                if !apps.contains(where: {$0.token == token}) {
                    context.insert(AppModel(token: token))
                }
            }
        })
        .onAppear {
            if selection.applicationTokens.isEmpty {
                selection.applicationTokens = Set<ApplicationToken>(apps.map { $0.token })
            }
        }
        
    }
    
    @ViewBuilder
    private func FilledListView() -> some View {
        LazyVStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Locked \(apps.count) apps")
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding([.leading, .top])
                
                Spacer()
                
                Button {
                    appsPickerIsPresented.toggle()
                } label: {
                    Text("Add")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(Color.accentColor)
                }
                .padding([.top, .trailing])
            }
            
            ForEach(apps) { app in
                AppActivityView(app: app)
            }
            
        }
    }
    
    @ViewBuilder
    private func EmptyListView() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Locked apps")
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding([.leading, .top])
                
                Text("0")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.accentColor)
                    .padding([.top, .bottom], 4)
                    .padding(.leading)
            }
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .foregroundStyle(Color.accentColor)
                .padding(.horizontal, 16)
        }
        .onTapGesture {
            appsPickerIsPresented.toggle()
        }
    }
}
