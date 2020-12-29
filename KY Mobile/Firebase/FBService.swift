import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBService {
    
    //  Retrieves FBUser information using its UUID
    static func retrieveFBUser(uid: String,
                               completion: @escaping (Result<User, Error>) -> () ){
        let reference = Firestore
            .firestore()
            .collection("Users")
            .document(uid)
        
        reference.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documentSnapshot = documentSnapshot else {
                completion(.failure(FirebaseError.noDocumentSnapshot))
                return
            }
            guard let data = documentSnapshot.data() else {
                completion(.failure(FirebaseError.noSnapshotData))
                return
            }
            guard let userInformation = User(UserData: data) else {
                completion(.failure(FirebaseError.noUser))
                return
            }
            completion(.success(userInformation))
        }
    }
    
    // Merges FBUser information with a UUID-specified document
    static func mergeFBUser(uid: String,
                            info: [String: Any],
                            completion: @escaping (Result<Bool, Error>) -> () ){
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
    
    
    static func uploadImage(chosenImage: UIImage,
                            location: String,
                            completionHandler: @escaping (Result<URL, Error>) -> () ){
        
        let storageRef = Storage.storage().reference().child(location).child("123")
        let imagePNG = chosenImage.pngData()
        
        storageRef.putData(imagePNG!, metadata: nil) { (metadata, error) in
            if error == nil {
                storageRef.downloadURL { (url, err) in
                    guard let imageURL = url else {
                        completionHandler(.failure(err!))
                        return
                    }
                    completionHandler(.success(imageURL))
                    return
                }
            }
            else {
                completionHandler(.failure(error!))
                return
            }
        }
    }
    
    
    static func uploadNewEvent(newEvent: Event, completion: @escaping (Result<Bool, Error>) -> () ) {
        var _newEvent = newEvent
        if _newEvent.Cover == "placeholder" {
            _newEvent.Cover = ""
        }
        _newEvent.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
        
        let reference = Firestore
            .firestore()
            .collection("Events")
            .document(_newEvent.TimeStamp)
        
        reference.setData(_newEvent.eventToDict(), merge: true) { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
    
    static func uploadNewNotice(newNotice: Notice, completion: @escaping (Result<Bool, Error>) -> () ) {
        var _newNotice = newNotice
        _newNotice.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
        
        let reference = Firestore
            .firestore()
            .collection("Notice")
            .document(newNotice.TimeStamp)
        
        reference.setData(_newNotice.noticeToDict(), merge: true) { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
}
    
    
//    static func countAccountsWithStudentID(studentID: String) -> Int {
//        var number: Int = 0
//        let reference = Firestore
//            .firestore()
//            .collection("Users")
//            .whereField("StudentID", isEqualTo: studentID)
//
//        reference.getDocuments() { (querySnapshot, error) in
//            if error != nil {
//                number = querySnapshot!.documents.count
//            } else {
//                number = -1
//            }
//        }
//        return number
//    }
//
//
//    static func retrieveEmailFromStudentID(studentID: String) -> String {
//
//        var email: String = ""
//        let reference = Firestore
//            .firestore()
//            .collection("Users")
//            .whereField("StudentID", isEqualTo: studentID)
//
//
//        reference.getDocuments() { (querySnapshot, error) in
//            if error != nil {
//                email = querySnapshot!.documents[0]["Email"] as! String
//            }
//        }
//        return email
//    }
