//
//  MockGoalRepository.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation

class MockGoalRepository: GoalRepositoryProtocol {
    
    var goals: [Goal] = Goal.sampleGoals()
    
    func getAll(completion: @escaping (Result<[Goal]?, Error>) -> Void) {
        completion(.success(goals))
    }
    
    func add(goal: Goal, completion: @escaping (Result<Goal?, Error>) -> Void) {
        var goal = goal
        goal.id = UUID().uuidString
        goals.append(goal)
        completion(.success(goal))
    }
    
    func deleteGoal(goalId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        goals.removeAll { goal in
            goal.id == goalId
        }
        
        completion(.success(true))
    }
    
    func addGoalItem(goalId: String, item: String, completion: @escaping (Result<Goal?, Error>) -> Void) {
        for i in 0..<goals.count {
            if goals[i].id == goalId {
                goals[i].items.append(item)
                completion(.success(goals[i]))
                return
            }
        }
    }
    
    func deleteItem(goalId: String, item: String, completion: @escaping (Result<Goal?, Error>) -> Void) {
        for i in 0..<goals.count {
            if goals[i].id == goalId {
                goals[i].items.removeAll { unit in
                    unit == item
                }
                completion(.success(goals[i]))
                return
            }
        }
    }
    
    
}
