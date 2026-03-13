//
//  SettingsView.swift
//  FocusFuel
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel: SettingsViewModel
    @State private var showResetAlert = false
    
    init() {
        _viewModel = StateObject(wrappedValue: SettingsViewModel(settings: UserSettings()))
    }
    
    var body: some View {
        Form {
            Section("Notifications") {
                Toggle("Enable Notifications", isOn: $viewModel.settings.notificationsEnabled)
            }
            
            Section("Feedback") {
                Toggle("Enable Haptics", isOn: $viewModel.settings.hapticsEnabled)
            }
            
            Section("Session Defaults") {
                Picker("Default Duration", selection: $viewModel.settings.defaultDuration) {
                    Text("30 min").tag(30)
                    Text("45 min").tag(45)
                    Text("60 min").tag(60)
                    Text("90 min").tag(90)
                }
            }
            
            Section("Data") {
                Button("Reset Onboarding") {
                    showResetAlert = true
                }
                .foregroundColor(.red)
                
                Button("Clear All Data") {
                    viewModel.clearData()
                    appViewModel.sessions = []
                    appViewModel.settings = UserSettings()
                    appViewModel.hasCompletedOnboarding = false
                    viewModel.settings = appViewModel.settings
                }
                .foregroundColor(.red)
            }
            
            Section("About") {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.textSecondary)
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.settings = appViewModel.settings
        }
        .onDisappear {
            viewModel.saveSettings()
            appViewModel.settings = viewModel.settings
        }
        .alert("Reset Onboarding", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                viewModel.resetOnboarding()
                appViewModel.hasCompletedOnboarding = false
            }
        } message: {
            Text("This will show the onboarding screens again on next launch.")
        }
    }
}
