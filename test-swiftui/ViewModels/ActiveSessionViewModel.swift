//
//  ActiveSessionViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class ActiveSessionViewModel: ObservableObject {
    @Published var session: FocusSession
    @Published var timeRemaining: TimeInterval
    @Published var isPaused: Bool = false
    @Published var isCompleted: Bool = false
    
    private var timer: Timer?
    private var cancellables = Set<AnyCancellable>()
    
    init(session: FocusSession) {
        self.session = session
        self.timeRemaining = TimeInterval(session.durationMinutes * 60)
        startTimer()
    }
    
    func togglePause() {
        isPaused.toggle()
        if isPaused {
            timer?.invalidate()
        } else {
            startTimer()
        }
    }
    
    func completeSession() {
        timer?.invalidate()
        session.endedAt = Date()
        session.completed = true
        isCompleted = true
    }
    
    func cancelSession() {
        timer?.invalidate()
        session.completed = false
        isCompleted = true
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, !self.isPaused else { return }
            self.timeRemaining -= 1
            if self.timeRemaining <= 0 {
                self.completeSession()
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
