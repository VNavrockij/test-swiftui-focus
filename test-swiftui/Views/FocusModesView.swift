//
//  FocusModesView.swift
//  FocusFuel
//

import SwiftUI

struct FocusModesView: View {
    @StateObject private var viewModel = FocusModesViewModel()
    @Binding var path: NavigationPath
    @State private var showingAddSheet = false

    @State private var title: String = ""
    @State private var subtitle: String = ""
    @State private var icon: String = "flame.fill"
    @State private var duration: Int = 60
    @State private var category: String = "Custom"
    @State private var energyDemand: Int = 3
    @State private var descriptionText: String = ""
    @State private var benefits: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Focus Modes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Built-in")
                        .font(.headline)
                        .padding(.horizontal)
                    ForEach(FocusMode.sampleModes) { mode in
                        SessionCard(mode: mode)
                            .onTapGesture {
                                path.append(mode)
                            }
                            .padding(.horizontal)
                    }
                }

                if !viewModel.customModes.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Custom")
                            .font(.headline)
                            .padding(.horizontal)
                        ForEach(viewModel.customModes) { mode in
                            SessionCard(mode: mode)
                                .onTapGesture {
                                    path.append(mode)
                                }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.deleteCustomMode(mode)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Focus Modes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            NavigationStack {
                Form {
                    Section("Basics") {
                        TextField("Title", text: $title)
                        TextField("Subtitle", text: $subtitle)
                        TextField("SF Symbol (e.g. flame.fill)", text: $icon)
                        TextField("Category", text: $category)
                    }

                    Section("Session") {
                        Stepper(value: $duration, in: 15...180, step: 5) {
                            Text("Duration: \(duration) min")
                        }
                        Stepper(value: $energyDemand, in: 1...5) {
                            Text("Energy Demand: \(energyDemand)/5")
                        }
                    }

                    Section("Details") {
                        TextField("Description", text: $descriptionText)
                        TextField("Benefits", text: $benefits)
                    }
                }
                .navigationTitle("New Focus Mode")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            showingAddSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            viewModel.addCustomMode(
                                title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                                subtitle: subtitle.trimmingCharacters(in: .whitespacesAndNewlines),
                                icon: icon.trimmingCharacters(in: .whitespacesAndNewlines),
                                duration: duration,
                                category: category.trimmingCharacters(in: .whitespacesAndNewlines),
                                energyDemand: energyDemand,
                                description: descriptionText.trimmingCharacters(in: .whitespacesAndNewlines),
                                benefits: benefits.trimmingCharacters(in: .whitespacesAndNewlines)
                            )
                            resetForm()
                            showingAddSheet = false
                        }
                        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
            }
        }
    }

    private func resetForm() {
        title = ""
        subtitle = ""
        icon = "flame.fill"
        duration = 60
        category = "Custom"
        energyDemand = 3
        descriptionText = ""
        benefits = ""
    }
}
