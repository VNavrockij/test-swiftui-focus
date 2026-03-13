//
//  HomeViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var currentEnergy: Int = 3
    @Published var todaysSessions: [FocusSession] = []
    
    let recommendedMode = FocusMode.sampleModes.first!
    let suggestedModes = Array(FocusMode.sampleModes.prefix(3))
    
    func startSession(mode: FocusMode, energy: Int) -> FocusSession {
        let session = FocusSession(
            id: UUID(),
            mode: mode,
            startedAt: Date(),
            endedAt: nil,
            durationMinutes: mode.durationMinutes,
            completed: false,
            preSessionEnergy: energy,
            postSessionEnergy: nil,
            focusScore: nil,
            notes: nil
        )
        return session
    }
}
