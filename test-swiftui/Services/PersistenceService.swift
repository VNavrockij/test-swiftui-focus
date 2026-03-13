//
//  PersistenceService.swift
//  FocusFuel
//

import Foundation

class PersistenceService {
    private let settingsKey = "userSettings"
    private let sessionsKey = "focusSessions"
    
    func loadSettings() -> UserSettings {
        if let data = UserDefaults.standard.data(forKey: settingsKey),
           let settings = try? JSONDecoder().decode(UserSettings.self, from: data) {
            return settings
        }
        return UserSettings()
    }
    
    func saveSettings(_ settings: UserSettings) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: settingsKey)
        }
    }
    
    func loadSessions() -> [FocusSession] {
        if let data = UserDefaults.standard.data(forKey: sessionsKey),
           let sessions = try? JSONDecoder().decode([FocusSession].self, from: data) {
            return sessions
        }
        return []
    }
    
    func saveSessions(_ sessions: [FocusSession]) {
        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: sessionsKey)
        }
    }
    
    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: settingsKey)
        UserDefaults.standard.removeObject(forKey: sessionsKey)
    }
}