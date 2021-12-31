//
//  Goal.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation

struct Goal: Codable {
    var id: String?
    var name: String
    var dueOn: Date
    var color: String
    var icon: String
    var items: [String]
}

extension Goal {
    static func sampleGoals() -> [Goal] {
        return [
            Goal(id: UUID().uuidString, name: "Work", dueOn: Date(), color: "#0984e3", icon: "🗂", items: [
                "Uicollection fix",
                "Fix the Real estate bug"
            ]),
            Goal(id: UUID().uuidString, name: "Personal", dueOn: Date(), color: "#e17055", icon: "🤖", items: [
                "Learn SwiftUI",
                "Learn Flutter"
            ]),
            Goal(id: UUID().uuidString, name: "Fitness", dueOn: Date(), color: "#0984e3", icon: "🗂", items: [
                "Walk 5kms",
                "Eat Healthy"
            ])
        ]
    }
}
