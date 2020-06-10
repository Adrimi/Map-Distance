//
//  ContentView.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var from: String = ""
    @State private var to: String = ""
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        VStack(spacing: 32) {
            
            // TODO: change to MapView
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.offWhite)
                .background(NeumorphBackgroundView())
            
            
            HStack(spacing: 32) {
                BasicTextfield(label: BasicTextfieldLabel("FROM"), text: $from)
                BasicTextfield(label: BasicTextfieldLabel("TO"), text: $to)
            }
        }
        .padding(.all, 24)
        .background(Color.offWhite.edgesIgnoringSafeArea(.all))
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
