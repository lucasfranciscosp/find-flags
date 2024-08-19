//
//  Data.swift
//  Find Flags
//
//  Created by Lucas Francisco on 14/08/24.
//

import Foundation
import SwiftData

@Model
class DataItem: Identifiable {
    
    var maxStreak: Int
    
    init() {
        self.maxStreak = 0
    }
    
    func updateStreak(currentStreak: Int) {
        self.maxStreak = max(maxStreak, currentStreak)
    }
}
