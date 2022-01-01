//
//  GoalDetailViewModel.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation
import UIKit
import SwiftUI

class GoalDetailViewModel: ObservableObject {
    private let repo: GoalRepositoryProtocol
    
    @Published var goal: GoalViewModel
    
    var item = ""
    
    init(repo: GoalRepositoryProtocol, goal: GoalViewModel) {
        self.repo = repo
        self.goal = goal
    }
    
    func add(item: String) {
        repo.addGoalItem(goalId: goal.id, item: item) { result in
            switch result {
            case .success(let newGoal):
                if let newGoal = newGoal {
                    DispatchQueue.main.async {
                        self.goal = GoalViewModel(goal: newGoal)
                        self.item = ""
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func delete(item: String) {
        repo.deleteItem(goalId: goal.id, item: item) { result in
            switch result {
            case .success(let newGoal):
                if let newGoal = newGoal {
                    DispatchQueue.main.async {
                        self.goal = GoalViewModel(goal: newGoal)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
