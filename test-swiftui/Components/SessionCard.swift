//
//  SessionCard.swift
//  FocusFuel
//

import SwiftUI

struct SessionCard: View {
    let mode: FocusMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: mode.icon)
                    .font(.title2)
                    .foregroundColor(.accent)
                Text(mode.title)
                    .font(.headline)
                Spacer()
                Text("\(mode.durationMinutes)m")
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
            }
            Text(mode.subtitle)
                .font(.subheadline)
                .foregroundColor(.textSecondary)
            HStack {
                Text("Energy: \(mode.energyDemand)/5")
                    .font(.caption)
                Spacer()
                Text(mode.category)
                    .font(.caption)
                    .padding(4)
                    .background(Color.backgroundSecondary)
                    .cornerRadius(6)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}