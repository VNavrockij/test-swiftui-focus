//
//  FocusModesViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class FocusModesViewModel: ObservableObject {
    @Published var focusModes: [FocusMode] = FocusMode.sampleModes
}
