//
//  FocusModesView.swift
//  FocusFuel
//

import SwiftUI

struct FocusModesView: View {
    @StateObject private var viewModel = FocusModesViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Focus Modes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ForEach(viewModel.focusModes) { mode in
                    SessionCard(mode: mode)
                        .onTapGesture {
                            path.append(mode)
                        }
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Focus Modes")
        .navigationBarTitleDisplayMode(.inline)
    }
}