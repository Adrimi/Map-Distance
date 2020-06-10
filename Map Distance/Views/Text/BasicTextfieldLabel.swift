
//
//  BasicTextfieldLabel.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import SwiftUI

struct BasicTextfieldLabel: View {
    
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .semibold, design: .rounded))
    }
}

#if DEBUG
struct BasicTextfieldLabel_Previews: PreviewProvider {
    static var previews: some View {
        BasicTextfieldLabel("FROM")
            .previewLayout(.sizeThatFits)
    }
}
#endif
