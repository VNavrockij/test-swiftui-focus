//
//  SessionDetailView.swift
//  FocusFuel
//

import SwiftUI

struct SessionDetailView: View {
    let mode: FocusMode
    @Binding var path: NavigationPath
    @StateObject private var viewModel = SessionDetailViewModel()
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: mode.icon)
                        .font(.system(size: 60))
                        .foregroundColor(.accent)
                    Text(mode.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(mode.subtitle)
                        .font(.title2)
                        .foregroundColor(.textSecondary)
                }
                
                // Details
                VStack(alignment: .leading, spacing: 16) {
                    DetailRow(title: "Duration", value: "\(mode.durationMinutes) minutes")
                    DetailRow(title: "Category", value: mode.category)
                    DetailRow(title: "Energy Demand", value: "\(mode.energyDemand)/5")
                    DetailRow(title: "Description", value: mode.description)
                    DetailRow(title: "Benefits", value: mode.benefits)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Energy Slider
                VStack(alignment: .leading) {
                    Text("Current Energy Level")
                        .font(.headline)
                    HStack {
                        ForEach(1...5, id: \.self) { level in
                            Circle()
                                .fill(level <= viewModel.selectedEnergy ? Color.accent : Color.backgroundSecondary)
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    viewModel.selectedEnergy = level
                                }
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Start Button
                PrimaryButton(title: "Start Session") {
                    let session = viewModel.createSession(for: mode)
                    appViewModel.addSession(session)
                    path.append(session)
                }
            }
            .padding()
        }
        .navigationTitle(mode.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: FocusSession.self) { session in
            ActiveSessionView(session: session, path: $path)
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.textSecondary)
            Text(value)
                .font(.body)
        }
    }
}