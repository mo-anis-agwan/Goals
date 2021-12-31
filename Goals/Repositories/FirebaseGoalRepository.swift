//
//  FirebaseGoalRepository.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseGoalRepository {
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
}
