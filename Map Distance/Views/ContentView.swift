//
//  ContentView.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentVM()
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        VStack(spacing: 32) {
            
            // TODO: change to MapView
            MapView(fromCoordinate: $viewModel.fromCoordinate, toCoordinate: $viewModel.toCoordinate)
                .cornerRadius(20)
                .background(NeumorphBackgroundView())
                .layoutPriority(1)
            
            
            HStack(spacing: 32) {
                BasicTextField(label: BasicTextfieldLabel("FROM"), placeholder: viewModel.textFieldsPlaceholder, text: $viewModel.from)
                BasicTextField(label: BasicTextfieldLabel("TO"), placeholder: viewModel.textFieldsPlaceholder, text: $viewModel.to)
            }
            
            Button(action: {
                self.viewModel.serachForLocations()
            }) {
                Text("Search")
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
