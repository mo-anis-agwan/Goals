//
//  AddGoalViewModel.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation
import SwiftUI

class AddGoalViewModel: ObservableObject {
    private let repo: GoalRepositoryProtocol
        
    var name: String = ""
    var dueOnDate: Date = Date()
    var color: Color = .pink
    var icon: String = "☄️"
    var goal: String = ""
    
    @Published var saved: Bool = false
    @Published var items: [String] = []
    
    init(repo: GoalRepositoryProtocol) {
        self.repo = repo
    }
    
    func addGoalToList(item: String) {
        guard !item.isEmpty, item.count >= 3 else { return }
        items.append(item)
        goal = ""
    }
    
    func add() {
        let goal = Goal(name: name, dueOn: dueOnDate, color: UIColor(color).hexStringFromColor(), icon: icon, items: items)
        
        repo.add(goal: goal) { result in
            switch result {
            case .success(let savedGoal):
                DispatchQueue.main.async {
                    self.saved = savedGoal == nil ? false:true
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}
