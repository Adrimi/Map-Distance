//
//  NeumorphicTextFieldStyle.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import SwiftUI


public struct NeumorphicTextFieldStyle: ViewModifier {
    
    public func body(content: Content) -> some View {
        ZStack {
            NeumorphBackgroundView()
            
            content
                .padding(.horizontal, 24)
        }
    }
    
}
