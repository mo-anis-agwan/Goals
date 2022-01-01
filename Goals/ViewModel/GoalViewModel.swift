//
//  GoalViewModel.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation
import SwiftUI
import UIKit

struct GoalViewModel {
    var goal: Goal
    
    var id: String {
        goal.id ?? ""
    }
    
    var name: String {
        goal.name
    }
    
    var dueOnDate: Date {
        goal.dueOn
    }
    
    var dueOn: String {
        goal.dueOn.toRelativeDate()
    }
    
    var color: Color {
        Color(UIColor(hexString: goal.icon))
    }
    
    var icon: String {
        goal.icon
    }
    
    var items: [String] {
        get {
            return goal.items
        }
        
        set(newItems) {
            return goal.items = newItems
        }
    }
    
}
