//
//  ApplicationActivity.swift
//  Focus
//
//  Created by sandor ferreira on 23/10/23.
//

import Foundation
import ManagedSettings
import SwiftData

@Model
class AppModel: Identifiable {
    @Attribute(.unique) var id: String
    var token: ApplicationToken
    var timesOpenned: Int = 0
    var openingDuration: Int = 0
    var blocked: Bool = true
    
    var description: String {
        timesOpenned > 0 ? "openned \(timesOpenned)" : ""
    }
    
    init(id: String = UUID().uuidString, token: ApplicationToken, timesOpenned: Int = 0, openingDuration: Int = 0) {
        self.id = id
        self.token = token
        self.timesOpenned = timesOpenned
        self.openingDuration = openingDuration
    }
    
    func openned() {
        timesOpenned += 1
    }
    
    func toggleLockedState() {
        blocked.toggle()
    }
    
    static func == (lhs: AppModel, rhs: AppModel) -> Bool {
        lhs.token == rhs.token
    }
}
