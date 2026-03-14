//
//  PersistenceService.swift
//  FocusFuel
//

import Foundation

class PersistenceService {
    private let settingsKey = "userSettings"
    private let sessionsKey = "focusSessions"
    private let customModesKey = "customFocusModes"
    
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
        UserDefaults.standard.removeObject(forKey: customModesKey)
    }

    func loadCustomModes() -> [FocusMode] {
        if let data = UserDefaults.standard.data(forKey: customModesKey),
           let modes = try? JSONDecoder().decode([FocusMode].self, from: data) {
            return modes
        }
        return []
    }

    func saveCustomModes(_ modes: [FocusMode]) {
        if let data = try? JSONEncoder().encode(modes) {
            UserDefaults.standard.set(data, forKey: customModesKey)
        }
    }
}
