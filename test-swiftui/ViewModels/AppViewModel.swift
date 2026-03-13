//
//  AppViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    @Published var hasCompletedOnboarding: Bool = false
    @Published var sessions: [FocusSession] = []
    @Published var settings: UserSettings = UserSettings()
    
    private let persistence = PersistenceService()
    
    init() {
        loadData()
    }
    
    func completeOnboarding() {
        settings.hasCompletedOnboarding = true
        saveSettings()
        hasCompletedOnboarding = true
    }
    
    func addSession(_ session: FocusSession) {
        sessions.append(session)
        saveSessions()
    }
    
    func updateSession(_ session: FocusSession) {
        if let index = sessions.firstIndex(where: { $0.id == session.id }) {
            sessions[index] = session
            saveSessions()
        }
    }

    func removeSession(id: UUID) {
        sessions.removeAll { $0.id == id }
        saveSessions()
    }

    func session(for id: UUID) -> FocusSession? {
        sessions.first { $0.id == id }
    }
    
    private func loadData() {
        settings = persistence.loadSettings()
        hasCompletedOnboarding = settings.hasCompletedOnboarding
        sessions = persistence.loadSessions()
    }
    
    private func saveSettings() {
        persistence.saveSettings(settings)
    }
    
    private func saveSessions() {
        persistence.saveSessions(sessions)
    }
}
