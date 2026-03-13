//
//  OnboardingView.swift
//  FocusFuel
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var currentPage = 0
    
    let pages = [
        OnboardingPage(
            title: "Welcome to FocusFuel",
            subtitle: "Boost your productivity with structured focus sessions",
            icon: "flame.fill",
            description: "Plan, track, and reflect on your deep work sessions to achieve more."
        ),
        OnboardingPage(
            title: "How It Works",
            subtitle: "Choose a mode, set your energy, and focus",
            icon: "timer",
            description: "Select from predefined focus modes, track your mental energy, and complete sessions with reflection."
        )
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPageView(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            
            HStack {
                ForEach(0..<pages.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? Color.accent : Color.backgroundSecondary)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.bottom)
            
            if currentPage == pages.count - 1 {
                PrimaryButton(title: "Get Started") {
                    appViewModel.completeOnboarding()
                }
                .padding(.horizontal)
            } else {
                Button("Next") {
                    withAnimation {
                        currentPage += 1
                    }
                }
                .font(.headline)
                .padding()
            }
        }
    }
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let description: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: page.icon)
                .font(.system(size: 80))
                .foregroundColor(.accent)
            Text(page.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(page.subtitle)
                .font(.title2)
                .foregroundColor(.textSecondary)
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
        .padding()
    }
}