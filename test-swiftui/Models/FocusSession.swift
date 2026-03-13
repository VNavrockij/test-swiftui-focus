//
//  FocusSession.swift
//  FocusFuel
//

import Foundation

struct FocusSession: Identifiable, Codable, Hashable {
    let id: UUID
    let mode: FocusMode
    let startedAt: Date
    var endedAt: Date?
    let durationMinutes: Int
    var completed: Bool
    var preSessionEnergy: Int // 1-5 scale
    var postSessionEnergy: Int?
    var focusScore: Int? // 1-5 scale
    var notes: String?
    
    var actualDuration: TimeInterval? {
        guard let endedAt = endedAt else { return nil }
        return endedAt.timeIntervalSince(startedAt)
    }
}
