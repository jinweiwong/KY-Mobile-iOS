import Foundation
import SwiftUI

// Lower down the keyboard
// Used when users type in a TextEditor when creating an Post of a Notice
extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
