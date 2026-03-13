//
//  UserSettings.swift
//  FocusFuel
//

import Foundation

struct UserSettings: Codable {
    var notificationsEnabled: Bool = true
    var hapticsEnabled: Bool = true
    var defaultDuration: Int = 60
    var hasCompletedOnboarding: Bool = false
}