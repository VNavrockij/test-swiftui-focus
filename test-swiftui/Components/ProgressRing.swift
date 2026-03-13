//
//  ProgressRing.swift
//  FocusFuel
//

import SwiftUI

struct ProgressRing: View {
    let progress: Double // 0.0 to 1.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.backgroundSecondary, lineWidth: 8)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.accent, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
    }
}