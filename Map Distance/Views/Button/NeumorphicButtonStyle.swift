//
//  NeumorphicButtonStyle.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import SwiftUI


struct NeumorphicButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(RoundedRectangle(cornerRadius: 20))
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.offWhite)
                    } else {
                        NeumorphBackgroundView()
                    }
                })
        
    }
    
}
