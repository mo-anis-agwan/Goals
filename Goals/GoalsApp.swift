//
//  GoalsApp.swift
//  Goals
//
//  Created by Anis Agwan on 30/12/21.
//

import SwiftUI
import Firebase

@main
struct GoalsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(repo: MockGoalRepository())
        }
    }
}
