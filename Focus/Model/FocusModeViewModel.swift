//
//  FamilyActivitySelectionModel.swift
//  Focus
//
//  Created by sandor ferreira on 23/10/23.
//

import SwiftUI
import FamilyControls
import ManagedSettings

private let _DataModel = FocusModeManager()

class FocusModeManager: ObservableObject {
    let store = ManagedSettingsStore()
    
    @Published var applicationsActivities: [AppModel]
    @Published var activitySelection: FamilyActivitySelection
    @Published var focusActivity: FocusActivity
    
    init() {
        activitySelection = FamilyActivitySelection()
        applicationsActivities = []
        focusActivity = FocusActivity()
    }
    
    class var shared: FocusModeManager {
        _DataModel
    }
    
    private func appendApplications(_ applications: Set<ApplicationToken>) {
        applicationsActivities = applications.map { AppModel(token: $0) }
    }
    
    func setShieldRestrictions() {
        let applications = FocusModeManager.shared.activitySelection
        
        store.shield.applications = applications.applicationTokens
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
        
        appendApplications(applications.applicationTokens)
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

