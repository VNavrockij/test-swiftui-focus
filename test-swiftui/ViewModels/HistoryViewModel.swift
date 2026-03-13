//
//  HistoryViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class HistoryViewModel: ObservableObject {
    @Published var sessions: [FocusSession]
    
    var totalSessions: Int { sessions.count }
    var totalMinutes: Int { sessions.reduce(0) { $0 + $1.durationMinutes } }
    var mostUsedMode: String? {
        let modeCounts = Dictionary(grouping: sessions, by: { $0.mode.title })
            .mapValues { $0.count }
        return modeCounts.max(by: { $0.value < $1.value })?.key
    }
    var averageFocusScore: Double? {
        let scores = sessions.compactMap { $0.focusScore }
        return scores.isEmpty ? nil : Double(scores.reduce(0, +)) / Double(scores.count)
    }
    
    init(sessions: [FocusSession]) {
        self.sessions = sessions.filter { $0.completed }
    }
}
