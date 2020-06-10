//
//  BasicTextfield.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import SwiftUI

struct BasicTextfield<Label: View>: View {
    
    let label: Label
    @Binding var text: String
    
    init(label: Label, text: Binding<String>) {
        self.label = label
        self._text = text
    }
    
    var body: some View {
        VStack(spacing: 16) {
            label
            
            TextField("", text: $text)
                .frame(height: 50)
                .background(NeumorphBackgroundView())
        }
    }
}

#if DEBUG
struct BasicTextfield_Previews: PreviewProvider {
    static var previews: some View {
        BasicTextfield(label: BasicTextfieldLabel("FROM"),
                       text: .mock(""))
            .previewLayout(.sizeThatFits)
    }
}
#endif
