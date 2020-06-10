//
//  Binding.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import SwiftUI


extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}
