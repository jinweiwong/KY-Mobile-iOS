import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBProfile {
    
    //  Retrieves FBUser information using its UID
    static func retrieveFBUser(uid: String,
                               completion: @escaping (Result<User, Error>) -> () ){
        let reference = Firestore
            .firestore()
            .collection("Users")
            .whereField("UID", isEqualTo: uid)
        
        reference.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = querySnapshot else {
                print("Error getting query Snapshot")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                completion(.success(User(UserData: diff.document.data())!))
            }
        }
    }
    
    
    // Merges FBUser information with a UUID-specified document
    static func mergeFBUser(uid: String,
                            info: [String: Any],
                            completion: @escaping (Result<Bool, Error>) -> () ){
        let reference = Firestore
            .firestore()
            .collection("Users")
            .document("\(String(describing: info["UID"]!))_\(String(describing: info["Name"]!).replacingOccurrences(of: " ", with: ""))")
        
        reference.setData(info, merge: true) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
}
