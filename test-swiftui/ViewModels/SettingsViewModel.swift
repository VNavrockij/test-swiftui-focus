//
//  SettingsViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var settings: UserSettings
    @Published var showResetOnboardingAlert = false
    
    private let persistence = PersistenceService()
    
    init(settings: UserSettings) {
        self.settings = settings
    }
    
    func saveSettings() {
        persistence.saveSettings(settings)
    }
    
    func resetOnboarding() {
        settings.hasCompletedOnboarding = false
        saveSettings()
    }
    
    func clearData() {
        persistence.clearAllData()
        // Reload or notify
    }
}
