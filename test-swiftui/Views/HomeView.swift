//
//  HomeView.swift
//  FocusFuel
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel = HomeViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    // Greeting
                    Text("Good \(greeting()), Vitalii!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Current Energy
                    VStack(alignment: .leading) {
                        Text("Current Energy Level")
                            .font(.headline)
                        HStack {
                            ForEach(1...5, id: \.self) { level in
                                Circle()
                                    .fill(level <= viewModel.currentEnergy ? Color.accent : Color.backgroundSecondary)
                                    .frame(width: 30, height: 30)
                                    .onTapGesture {
                                        viewModel.currentEnergy = level
                                    }
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    // Recommended Session
                    VStack(alignment: .leading) {
                        Text("Recommended for Today")
                            .font(.headline)
                        SessionCard(mode: viewModel.recommendedMode)
                            .onTapGesture {
                                path.append(viewModel.recommendedMode)
                            }
                    }
                    .padding(.horizontal)

                    // Suggested Sessions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Suggested Sessions")
                            .font(.headline)
                        ForEach(viewModel.suggestedModes) { mode in
                            SessionCard(mode: mode)
                                .onTapGesture {
                                    path.append(mode)
                                }
                        }
                    }
                    .padding(.horizontal)

                    // Quick Actions
                    VStack(spacing: 12) {
                        Button {
                            path.append(viewModel.recommendedMode)
                        } label: {
                            HStack {
                                Image(systemName: "play.circle.fill")
                                Text("Start Recommended Session")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }

                        NavigationLink(value: "modes") {
                            HStack {
                                Image(systemName: "list.bullet")
                                Text("Browse Focus Modes")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        
                        NavigationLink(value: "history") {
                            HStack {
                                Image(systemName: "clock")
                                Text("View History")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        
                        NavigationLink(value: "settings") {
                            HStack {
                                Image(systemName: "gear")
                                Text("Settings")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationDestination(for: FocusMode.self) { mode in
                SessionDetailView(mode: mode, path: $path)
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "modes":
                    FocusModesView(path: $path)
                case "history":
                    HistoryView()
                case "settings":
                    SettingsView()
                default:
                    EmptyView()
                }
            }
            .navigationDestination(for: ReflectionRoute.self) { route in
                if let session = appViewModel.session(for: route.sessionID) {
                    SessionReflectionView(path: $path, session: session)
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    private func greeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12: return "morning"
        case 12..<17: return "afternoon"
        case 17..<22: return "evening"
        default: return "evening"
        }
    }
}
