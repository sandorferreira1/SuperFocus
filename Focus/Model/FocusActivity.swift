//
//  ScheduleFocus.swift
//  Focus
//
//  Created by sandor ferreira on 24/10/23.
//

import Foundation
import DeviceActivity
import ManagedSettings

extension DeviceActivityEvent.Name {
    static let shieldContent = Self("Focus.ShieldApp")
}

extension DeviceActivityName {
    static let everydayActivity = Self("Focus.MonitoringActivity")
    static let appActivity = Self("Focus.AppActivity")
}

extension ManagedSettingsStore.Name {
    static let focus = Self("Focus.focusStore")
}

extension Date {
    func nextByMinutes(by: Int) -> Self {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: by, to: self)!
    }
    
    func nextBySeconds(by: Int) -> Self {
        let calendar = Calendar.current
        return calendar.date(byAdding: .second, value: by, to: self)!
    }
}

class FocusActivity {
    private let scheduleActivity = DeviceActivitySchedule(intervalStart: DateComponents(hour: 0, minute: 0), intervalEnd: DateComponents(hour: 23, minute: 59), repeats: true)
    
    public func schedule() {
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .shieldContent: DeviceActivityEvent(
                applications: FocusModeManager.shared.activitySelection.applicationTokens,
                categories: FocusModeManager.shared.activitySelection.categoryTokens,
                threshold: DateComponents(second: 1))
        ]
        
        let center = DeviceActivityCenter()
        
        do {
            try center.startMonitoring(.everydayActivity, during: scheduleActivity, events: events)
        } catch {
            debugPrint("Scheduling focus mode on apps and categories FAILED")
        }
    }
    
    public func schedule(app: AppModel, for seconds: Int) {
        let calendar = Calendar.current
        let start = Date.now
        let end = Calendar.current.date(byAdding: .second, value: seconds, to: start)
        
        let intervalStart = Calendar.current.dateComponents([.hour, .minute, .second, .weekday], from: .now)
        let intervalEnd = Calendar.current.dateComponents([.hour, .minute, .second, .weekday], from: end!)
        let schedule = DeviceActivitySchedule(
            intervalStart: intervalStart,
            intervalEnd: intervalEnd,
            repeats: true
        )
        
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            DeviceActivityEvent.Name("BlockedAppEvent"): DeviceActivityEvent(
                applications: Set<ApplicationToken>(arrayLiteral: app.token),
                threshold: DateComponents(calendar: calendar, hour: 22, minute: 46, weekday: 4))
        ]
        
        let center = DeviceActivityCenter()
        center.stopMonitoring()
        
        do {
            try center.startMonitoring(.appActivity, during: schedule, events: events)
        } catch {
            debugPrint("Scheduling focus mode on apps and categories FAILED")
        }
    }
}


