//
//  ContentView.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import SwiftUI

struct ContentView: View, Tappable {
    
    @ObservedObject var viewModel = ContentVM()
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        VStack(spacing: 32) {
            
            ZStack(alignment: .bottom) {
                MapView(fromCoordinate: $viewModel.fromAnnotation, toCoordinate: $viewModel.toAnnotation, toggleUpdate: $viewModel.mapUpdate)
                    .cornerRadius(20)
                    .background(NeumorphBackgroundView())

                if viewModel.isShowingDistanceInfo {
                    DistanceInfoView(distance: viewModel.distance)
                        .padding(.all, 8)
                        .transition(.scale)
                }
            }
            .layoutPriority(1)
            
            HStack(spacing: 32) {
                BasicTextField(label: BasicTextfieldLabel("FROM"), placeholder: viewModel.textFieldsPlaceholder, text: $viewModel.from)
                BasicTextField(label: BasicTextfieldLabel("TO"), placeholder: viewModel.textFieldsPlaceholder, text: $viewModel.to)
            }

            Button(action: {
                self.viewModel.serachForLocations()
                withAnimation {
                    self.viewModel.checkDistance()
                }
            }) {
                Text("Search")
            }
        }
        .padding(.all, 24)
        .gesture(tap)
        .background(Color.offWhite.edgesIgnoringSafeArea(.all))
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
        .modifier(KeyboardObserving(updateUI: viewModel.updateMap))
    }

}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
