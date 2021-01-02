import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User = User()
    
    init() {
        getCurrentUser()
    }
    
    func getCurrentUser() {
        let uid = String(Auth.auth().currentUser?.uid ?? "")
        let userRef = Firestore.firestore().collection("Users").whereField("UID", isEqualTo: uid)
        
        userRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error retrieving current user: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    self.currentUser = User(UserData: diff.document.data())!
                }
            }
        }
    }
}
