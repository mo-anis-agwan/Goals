//
//  AnimationUtils.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import SwiftUI

extension Animation {
    func `repeat`(while expression: Bool, autoReverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoReverses)
        } else {
            return self
        }
    }
}
