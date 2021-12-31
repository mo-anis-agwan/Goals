//
//  GoalRepositoryProtocol.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation

protocol GoalRepositoryProtocol {
    func getAll(completion: @escaping (Result<[Goal]?, Error>) -> Void)
    func add(goal: Goal, completion: @escaping(Result<Goal?, Error>) -> Void)
    func deleteGoal(goalId: String, completion: @escaping(Result<Bool, Error>) -> Void)
    func addGoalItem(goalId: String, item: String, completion: @escaping(Result<Goal?, Error>) -> Void)
    func deleteItem(goalId: String, item: String, completion: @escaping(Result<Bool, Error>) -> Void)
}
