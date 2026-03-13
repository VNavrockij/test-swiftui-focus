//
//  SessionDetailViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class SessionDetailViewModel: ObservableObject {
    @Published var selectedEnergy: Int = 3
    
    func createSession(for mode: FocusMode) -> FocusSession {
        FocusSession(
            id: UUID(),
            mode: mode,
            startedAt: Date(),
            endedAt: nil,
            durationMinutes: mode.durationMinutes,
            completed: false,
            preSessionEnergy: selectedEnergy,
            postSessionEnergy: nil,
            focusScore: nil,
            notes: nil
        )
    }
}
