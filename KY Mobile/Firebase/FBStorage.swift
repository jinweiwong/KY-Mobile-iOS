import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBStorage {
    
    // Uploads an image to Storage and returns the URL
    // Location refers to the Collection name in Storage
    // Identifier refers to either the UID of a user or the TimeStamp of something
    // Name refers to either the name of a user or the Title of something
    static func uploadImage(chosenImage: UIImage,
                            location: String,
                            identifier: String,
                            completionHandler: @escaping (Result<URL, Error>) -> () ){
        
        let storageRef = Storage.storage().reference()
            .child(location)
            .child(identifier)
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
    
    // Deletes an image from Storage
    // Location refers to the Collection name in Storage
    // Identifier refers to either the UID of a user or the TimeStamp of something
    // Name refers to either the name of a user or the Title of something
    static func deleteImage(location: String,
                            identifier: String,
                            completionHandler: @escaping (Result<Bool, Error>) -> () ){
        let storageRef = Storage.storage().reference()
            .child(location)
            .child(identifier)
        
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
