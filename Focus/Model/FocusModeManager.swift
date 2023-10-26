//
//  FamilyActivitySelectionModel.swift
//  Focus
//
//  Created by sandor ferreira on 23/10/23.
//

import SwiftUI
import FamilyControls
import ManagedSettings
import SwiftData

private let _Manager = FocusModeManager()

class FocusModeManager: ObservableObject {
    let store = ManagedSettingsStore()
    
    @Query var applicationsActivities: [AppModel]
    @Published var activitySelection: FamilyActivitySelection
    @Published var focusActivity: FocusActivity
    
    @Published var appTest: ApplicationToken?
    
    init() {
        activitySelection = FamilyActivitySelection()
        self._applicationsActivities = Query(animation: .snappy)
        focusActivity = FocusActivity()
    }
    
    class var shared: FocusModeManager {
        _Manager
    }
    
    func setShieldRestrictions() {
        let applications = FocusModeManager.shared.activitySelection
        
        store.shield.applications = applications.applicationTokens
    }
    
    func setShieldRestriction(for app: ApplicationToken) {
        store.shield.applications = Set<ApplicationToken>(arrayLiteral: app)
    }
    
    func open(app: AppModel, for duration: Int) {
        clearShieldRestriction(for: app.token)
        focusActivity.schedule(app: app, for: duration)
    }
    
    func setSchedule() {
        focusActivity.schedule()
    }
    
    func clearAllShieldRestrictions() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
    }
    
    func clearShieldRestriction(for app: ApplicationToken) {
        store.shield.applications?.remove(app)
    }
    
    func openned(_ application: ApplicationToken) {
        if let appModel = applicationsActivities.first(where: { $0.token == application }) {
            appModel.openned()
        }
    }
}

