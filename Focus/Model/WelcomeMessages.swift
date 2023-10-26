//
//  WelcomeMessages.swift
//  Focus
//
//  Created by sandor ferreira on 26/10/23.
//

import Foundation

struct WelcomeMessages {
    private static var lastMessage: String = messages.first ?? ""
    
    static let messages = [
        "Get more of life",
        "Overcome phone addiction",
        "Spend time on what matters",
        "Stay present",
        "Do something you love"
    ]
    
    static func randomElement() -> String {
        var newMessage = messages.randomElement()
        while newMessage == lastMessage {
            newMessage = messages.randomElement()
        }
        
        lastMessage = newMessage!
        return newMessage!
    }
}
