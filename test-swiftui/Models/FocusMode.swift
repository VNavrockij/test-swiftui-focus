//
//  FocusMode.swift
//  FocusFuel
//

import Foundation

struct FocusMode: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let icon: String
    let durationMinutes: Int
    let category: String
    let energyDemand: Int // 1-5 scale
    let description: String
    let benefits: String
    
    static let sampleModes: [FocusMode] = [
        FocusMode(id: UUID(), title: "Deep Work", subtitle: "Intensive focused coding", icon: "brain.head.profile", durationMinutes: 90, category: "Work", energyDemand: 5, description: "Block out distractions and dive deep into complex coding tasks.", benefits: "High productivity, problem-solving breakthroughs"),
        FocusMode(id: UUID(), title: "Learning Sprint", subtitle: "Study new technologies", icon: "book.fill", durationMinutes: 60, category: "Learning", energyDemand: 4, description: "Dedicated time for learning new frameworks or concepts.", benefits: "Skill acquisition, knowledge retention"),
        FocusMode(id: UUID(), title: "Admin Cleanup", subtitle: "Organize and maintain", icon: "folder.fill", durationMinutes: 30, category: "Maintenance", energyDemand: 2, description: "Handle emails, documentation, and project organization.", benefits: "Reduced clutter, better project health"),
        FocusMode(id: UUID(), title: "Creative Flow", subtitle: "Design and ideation", icon: "lightbulb.fill", durationMinutes: 75, category: "Creative", energyDemand: 4, description: "Brainstorm ideas, design interfaces, or write creatively.", benefits: "Innovation, creative satisfaction"),
        FocusMode(id: UUID(), title: "Reading Focus", subtitle: "Technical reading", icon: "doc.text.fill", durationMinutes: 45, category: "Learning", energyDemand: 3, description: "Read documentation, articles, or books.", benefits: "Knowledge expansion, informed decisions")
    ]
}
