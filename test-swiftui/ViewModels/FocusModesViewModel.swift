//
//  FocusModesViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class FocusModesViewModel: ObservableObject {
    @Published var focusModes: [FocusMode] = []
    @Published var customModes: [FocusMode] = []

    private let persistence = PersistenceService()

    init() {
        loadModes()
    }

    func addCustomMode(title: String, subtitle: String, icon: String, duration: Int, category: String, energyDemand: Int, description: String, benefits: String) {
        let mode = FocusMode(
            id: UUID(),
            title: title,
            subtitle: subtitle,
            icon: icon,
            durationMinutes: duration,
            category: category,
            energyDemand: energyDemand,
            description: description,
            benefits: benefits
        )
        customModes.append(mode)
        saveCustomModes()
        rebuildList()
    }

    func deleteCustomMode(_ mode: FocusMode) {
        customModes.removeAll { $0.id == mode.id }
        saveCustomModes()
        rebuildList()
    }

    private func loadModes() {
        customModes = persistence.loadCustomModes()
        rebuildList()
    }

    private func rebuildList() {
        focusModes = FocusMode.sampleModes + customModes
    }

    private func saveCustomModes() {
        persistence.saveCustomModes(customModes)
    }
}
