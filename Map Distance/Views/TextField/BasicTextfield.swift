//
//  BasicTextField.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import SwiftUI

struct BasicTextField<Label: View>: View {
    
    let label: Label
    let placeholder: String
    @Binding var text: String
    
    init(label: Label, placeholder: String, text: Binding<String>) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        VStack(spacing: 16) {
            label
            
            TextField(placeholder, text: $text)
                .frame(height: 50)
                .modifier(NeumorphicTextFieldStyle())
        }
    }
}

#if DEBUG
struct BasicTextfield_Previews: PreviewProvider {
    static var previews: some View {
        BasicTextField(label: BasicTextfieldLabel("FROM"),
                       placeholder: "Coordinates or Name",
                       text: .mock(""))
            .previewLayout(.sizeThatFits)
    }
}
#endif
