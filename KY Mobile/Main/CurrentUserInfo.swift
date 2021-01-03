import Foundation
import SwiftUI
import FirebaseAuth

class CurrentUserInfo: ObservableObject {
    
    @Published var isUserAuthenticated: FBAuthState = .undefined
    @Published var currentUser: User = User()
    
    enum FBAuthState {
        case undefined, signedOut, signedIn
    }
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange() {
        // Detects if there is a change in authentication state
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let _ = user else {
                self.isUserAuthenticated = .signedOut
                return
            }
            self.isUserAuthenticated = .signedIn
        })
    }
}

