//
//  ActiveSessionView.swift
//  FocusFuel
//

import SwiftUI

struct ActiveSessionView: View {
    @StateObject private var viewModel: ActiveSessionViewModel
    @Binding var path: NavigationPath
    @EnvironmentObject var appViewModel: AppViewModel
    
    init(session: FocusSession, path: Binding<NavigationPath>) {
        _viewModel = StateObject(wrappedValue: ActiveSessionViewModel(session: session))
        _path = path
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Progress Ring
            ZStack {
                ProgressRing(progress: progress)
                    .frame(width: 200, height: 200)
                VStack {
                    Text(timeString(from: viewModel.timeRemaining))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(viewModel.session.mode.title)
                        .font(.title2)
                }
            }
            
            // Controls
            HStack(spacing: 20) {
                Button(action: viewModel.togglePause) {
                    Image(systemName: viewModel.isPaused ? "play.fill" : "pause.fill")
                        .font(.title)
                        .foregroundColor(.accent)
                        .frame(width: 60, height: 60)
                        .background(Color(.systemBackground))
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }

                Button(action: {
                    viewModel.completeSession()
                }) {
                    Image(systemName: "checkmark")
                        .font(.title)
                        .foregroundColor(.green)
                        .frame(width: 60, height: 60)
                        .background(Color(.systemBackground))
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                
                Button(action: {
                    viewModel.cancelSession()
                    appViewModel.removeSession(id: viewModel.session.id)
                    navigateToHome()
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.red)
                        .frame(width: 60, height: 60)
                        .background(Color(.systemBackground))
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: viewModel.isCompleted) { completed in
            if completed, viewModel.session.completed {
                handleCompletion()
            }
        }
    }
    
    private var progress: Double {
        let total = Double(viewModel.session.durationMinutes * 60)
        return (total - viewModel.timeRemaining) / total
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func handleCompletion() {
        appViewModel.updateSession(viewModel.session)
        path.append(ReflectionRoute(sessionID: viewModel.session.id))
    }

    private func navigateToHome() {
        if !path.isEmpty {
            path.removeLast(path.count)
        }
    }
}
