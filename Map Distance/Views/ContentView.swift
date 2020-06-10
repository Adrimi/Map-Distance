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
    
    var body: some View {
        VStack {
            HStack {
                TextField(from, text: $from)
                    .font(.title)
                    .background(Color.gray)
                TextField(to, text: $to)
                    .font(.title)
                    .background(Color.gray)
            }
            .frame(height: 100)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.pink)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
