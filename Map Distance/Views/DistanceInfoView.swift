//
//  DistanceInfoView.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import SwiftUI

struct DistanceInfoView: View {
    
    var straightDistance: Double
    @Binding var navigationDistance: Double
    
    var body: some View {
        ZStack {
            NeumorphBackgroundView()
            
            VStack(spacing: 8) {
                Text("Straight is \(straightDistance.kilometers) km · \(straightDistance.meters) m")
                if navigationDistance > 0 {
                    Text("Navigation is \(navigationDistance.kilometers) km · \(navigationDistance.meters) m")
                }
            }
            .padding(.vertical, 8)
        }
        .opacity(0.7)
    }
}

extension Double {
    var kilometers: Int {
        meters / 1000
    }
    
    var meters: Int {
        Int(self)
    }
}

#if DEBUG
struct DistanceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceInfoView(straightDistance: 2137, navigationDistance: .mock(4000))
    }
}
#endif
