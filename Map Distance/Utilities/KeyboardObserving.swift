//
//  KeyboardObserving.swift
//  Map Distance
//
//  Created by Nick Fox
//  https://www.nickfox.io/handling-keyboard-animations-in-swiftui
//

import SwiftUI
import Combine

struct KeyboardObserving: ViewModifier {
    
    @State var keyboardHeight: CGFloat = 0
    @State var keyboardAnimationDuration: Double = 0
    var updateUI: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .padding([.bottom], keyboardHeight)
            .edgesIgnoringSafeArea((keyboardHeight > 0) ? [.bottom] : [])
            .animation(.easeOut(duration: keyboardAnimationDuration))
            .onReceive(
                NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                    .receive(on: RunLoop.main),
                perform: updateKeyboardHeight
        )
            .onReceive(
                NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)
                    .receive(on: RunLoop.main),
                perform: updateUI
        )
            .onReceive(
                NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)
                    .receive(on: RunLoop.main),
                perform: updateUI
        )
    }
    
    func updateKeyboardHeight(_ notification: Notification) {
        guard let info = notification.userInfo else { return }
        // Get the duration of the keyboard animation
        keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25
        
        guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        // If the top of the frame is at the bottom of the screen, set the height to 0.
        if keyboardFrame.origin.y == UIScreen.main.bounds.height {
            keyboardHeight = 0
        } else {
            // IMPORTANT: This height will _include_ the SafeAreaInset height.
            keyboardHeight = keyboardFrame.height
        }
    }
    
    func updateUI(_ notification: Notification) {
        updateUI?()
    }
    
}

