//
//  DistanceInfoView.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import SwiftUI

struct DistanceInfoView: View {
    
    var distance: Double
    
    private var kilometers: Int {
        meters / 1000
    }
    
    private var meters: Int {
        Int(round(distance))
    }
    
    init(distance: Double) {
        self.distance = distance
    }
    
    var body: some View {
        ZStack {
            NeumorphBackgroundView()
            Text("Distance is \(kilometers) km · \(meters) m")
        }
        .opacity(0.7)
        .frame(height: 50)
    }
}

#if DEBUG
struct DistanceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceInfoView(distance: 2137)
    }
}
#endif
