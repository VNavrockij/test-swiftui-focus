//
//  FocusFuelApp.swift
//  FocusFuel
//
//  Created by Vitalii
//

import SwiftUI

@main
struct FocusFuelApp: App {
    @StateObject private var appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            if appViewModel.hasCompletedOnboarding {
                HomeView()
                    .environmentObject(appViewModel)
            } else {
                OnboardingView()
                    .environmentObject(appViewModel)
            }
        }
    }
}
