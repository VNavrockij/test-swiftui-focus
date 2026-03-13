//
//  HistoryView.swift
//  FocusFuel
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel: HistoryViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: HistoryViewModel(sessions: []))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Session History")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // Insights
                VStack(alignment: .leading, spacing: 8) {
                    Text("Insights")
                        .font(.headline)
                    HStack {
                        InsightCard(title: "Total Sessions", value: "\(viewModel.totalSessions)")
                        InsightCard(title: "Total Minutes", value: "\(viewModel.totalMinutes)")
                    }
                    if let mode = viewModel.mostUsedMode {
                        InsightCard(title: "Most Used Mode", value: mode)
                    }
                    if let avg = viewModel.averageFocusScore {
                        InsightCard(title: "Avg Focus Score", value: String(format: "%.1f", avg))
                    }
                }
                .padding(.horizontal)
                
                // Sessions List
                VStack(spacing: 12) {
                    ForEach(viewModel.sessions) { session in
                        HistoryRow(session: session)
                    }
                }
                .padding(.horizontal)
                
                if viewModel.sessions.isEmpty {
                    Text("No completed sessions yet")
                        .foregroundColor(.textSecondary)
                        .padding()
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.sessions = appViewModel.sessions.filter { $0.completed }
        }
    }
}

struct InsightCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct HistoryRow: View {
    let session: FocusSession
    
    var body: some View {
        HStack {
            Image(systemName: session.mode.icon)
                .foregroundColor(.accent)
            VStack(alignment: .leading) {
                Text(session.mode.title)
                    .font(.headline)
                Text("\(session.durationMinutes)m • \(session.startedAt.formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
            }
            Spacer()
            if let score = session.focusScore {
                Text("\(score)/5")
                    .font(.subheadline)
                    .foregroundColor(.accent)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}