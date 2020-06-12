//
//  Tappable.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import SwiftUI

protocol Tappable {}

extension Tappable where Self: View {
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                UIApplication.shared.windows.forEach { $0.endEditing(true) }
        }
    }
}
