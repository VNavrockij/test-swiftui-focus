//
//  SessionReflectionView.swift
//  FocusFuel
//

import SwiftUI

struct SessionReflectionView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var focusScore: Int = 3
    @State private var postEnergy: Int = 3
    @State private var notes: String = ""
    @Binding var path: NavigationPath
    
    let session: FocusSession
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Session Complete!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("How focused were you?")
                    .font(.title2)
                HStack {
                    ForEach(1...5, id: \.self) { level in
                        Circle()
                            .fill(level <= focusScore ? Color.accent : Color.backgroundSecondary)
                            .frame(width: 40, height: 40)
                            .overlay(Text("\(level)").foregroundColor(.white))
                            .onTapGesture {
                                focusScore = level
                            }
                    }
                }
                
                Text("Energy after session?")
                    .font(.title2)
                HStack {
                    ForEach(1...5, id: \.self) { level in
                        Circle()
                            .fill(level <= postEnergy ? Color.accent : Color.backgroundSecondary)
                            .frame(width: 40, height: 40)
                            .overlay(Text("\(level)").foregroundColor(.white))
                            .onTapGesture {
                                postEnergy = level
                            }
                    }
                }
                
                TextField("Notes (optional)", text: $notes)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                PrimaryButton(title: "Save & Return Home") {
                    saveReflection()
                    if !path.isEmpty {
                        path.removeLast(path.count) // Go back to root
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Reflection")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveReflection() {
        var updatedSession = session
        updatedSession.completed = true
        if updatedSession.endedAt == nil {
            updatedSession.endedAt = Date()
        }
        updatedSession.focusScore = focusScore
        updatedSession.postSessionEnergy = postEnergy
        updatedSession.notes = notes.isEmpty ? nil : notes
        appViewModel.updateSession(updatedSession)
    }
}
