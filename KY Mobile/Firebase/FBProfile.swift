import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBProfile {
    
    // Edit User details to the currentUser's document
    static func editUserDetails(uid: String,
                                info: [String: Any],
                                completion: @escaping (Result<Bool, Error>) -> () ){
        
        // Searches for User's document named (UID)_(Name)
        let reference = Firestore
            .firestore()
            .collection("Users")
            .document(uid)
        
        reference.setData(info, merge: true) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
}
