//
//  HomeViewModel.swift
//  FocusFuel
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var currentEnergy: Int = 3
    
    let recommendedMode = FocusMode.sampleModes.first!
    let suggestedModes = Array(FocusMode.sampleModes.prefix(3))
}
