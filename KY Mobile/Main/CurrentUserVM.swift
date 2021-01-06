import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class CurrentUserViewModel: ObservableObject {
    
    @Published var currentUser: User = User()
    @Published var authenticationState: AuthenticationState = .undefined
    
    enum AuthenticationState {
        case undefined, signedOut, signedIn
    }
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        getCurrentUser()
    }
    
    func configureFirebaseStateDidChange() {
        // Detects if there is a change in authentication state
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let _ = user else {
                self.authenticationState = .signedOut
                return
            }
            self.authenticationState = .signedIn
        })
    }
    
    // Add snapshot listener for current user's details
    func getCurrentUser() {
        let uid = String(Auth.auth().currentUser?.uid ?? "")
        let userRef = Firestore.firestore().collection("Users").whereField("UID", isEqualTo: uid)
        
        userRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error retrieving current user: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    self.currentUser = User(userDict: diff.document.data())!
                }
            }
        }
    } 
}
