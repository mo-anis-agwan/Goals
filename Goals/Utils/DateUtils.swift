//
//  DateUtils.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import Foundation

extension Date {
    func toRelativeDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
}
