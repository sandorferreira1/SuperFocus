//
//  ShieldConfigurationExtension.swift
//  ShieldConfiguration
//
//  Created by sandor ferreira on 23/10/23.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        return ShieldConfiguration(
            backgroundColor: .darkGray,
            title: .init(text: "\(application.localizedDisplayName!) is Locked.", color: .gray),
            subtitle: .init(text: "You're on Focus Mode. To unlock this app, press OK and then tap the notification", color: .gray),
            primaryButtonLabel: .init(text: "OK", color: .white))
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration(backgroundColor: .darkGray, primaryButtonLabel: .init(text: "OK", color: .blue))
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}
