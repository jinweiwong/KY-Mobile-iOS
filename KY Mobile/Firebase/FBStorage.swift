import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBStorage {
    
    static func uploadImage(chosenImage: UIImage,
                            location: String,
                            identifier: String,
                            name: String,
                            completionHandler: @escaping (Result<URL, Error>) -> () ){
        
        let storageRef = Storage.storage().reference()
            .child(location)
            .child("\(identifier)_\(name.replacingOccurrences(of: " ", with: ""))")
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
    
    
    static func deleteImage(location: String,
                            identifier: String,
                            name: String,
                            completionHandler: @escaping (Result<Bool, Error>) -> () ){
        let storageRef = Storage.storage().reference()
            .child(location)
            .child("\(identifier)_\(name.replacingOccurrences(of: " ", with: ""))")
        
        storageRef.delete { error in
            if error != nil {
                completionHandler(.failure(error!))
                return
            }
            completionHandler(.success(true))
            return
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
