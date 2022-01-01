//
//  FirebaseGoalRepository.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseGoalRepository: GoalRepositoryProtocol {
    
    
    private let db = Firestore.firestore()
    
    func add(goal: Goal, completion: @escaping(Result<Goal?, Error>) -> Void) {
        do {
            let ref = try db.collection("Goals").addDocument(from: goal)
            
            ref.getDocument { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(error ?? NSError(domain: "Snapshot is nil", code: 101, userInfo: nil)))
                    return
                }
                
                let goal = try? snapshot.data(as: Goal.self)
                completion(.success(goal))
            }
            
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    func getAll(completion: @escaping (Result<[Goal]?, Error>) -> Void) {
        db.collection("Goals").getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(.failure(error ?? NSError(domain: "Snapshot get all documents is nil", code: 102, userInfo: nil)))
                return
            }
            
            let goals: [Goal] = snapshot.documents.compactMap { doc in
                var goal = try? doc.data(as: Goal.self)
                if goal != nil {
                    goal!.id = doc.documentID
                }
                return goal
            }
            
            completion(.success(goals))
        }
    }
    
    func deleteGoal(goalId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        db.collection("Goals").document(goalId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func addGoalItem(goalId: String, item: String, completion: @escaping (Result<Goal?, Error>) -> Void) {
        let ref = db.collection("Goals").document(goalId)
        
        ref.updateData(["items": FieldValue.arrayUnion([item])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                ref.getDocument { snapshot, error in
                    guard let snapshot = snapshot, error == nil else {
                        completion(.failure(error ?? NSError(domain: "Snapshot item update document is nil", code: 103, userInfo: nil)))
                        return
                    }
                    
                    var goal: Goal? = try? snapshot.data(as: Goal.self)
                    if goal != nil {
                        goal!.id = snapshot.documentID
                        completion(.success(goal))
                    }
                    
                }
            }
        }
    }
    
    func deleteItem(goalId: String, item: String, completion: @escaping (Result<Goal?, Error>) -> Void) {
        let ref = db.collection("Goals").document(goalId)
        
        ref.updateData(["items": FieldValue.arrayRemove([item])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                ref.getDocument { snapshot, error in
                    guard let snapshot = snapshot, error == nil else {
                        completion(.failure(error ?? NSError(domain: "Snapshot item update document is nil", code: 103, userInfo: nil)))
                        return
                    }
                    
                    var goal: Goal? = try? snapshot.data(as: Goal.self)
                    if goal != nil {
                        goal!.id = snapshot.documentID
                        completion(.success(goal))
                    }
                }
            }
        }
    }
}
