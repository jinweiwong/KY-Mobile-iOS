import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBNotice {

    // Uploads new notice
    static func uploadNewNotice(newNotice: Notice, completion: @escaping (Result<Bool, Error>) -> () ) {
        var _newNotice = newNotice
        
        // Sets the current time to the TimeStamp of the notice
        _newNotice.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
        
        // Document name is (TimeStamp)_(Title)
        let reference = Firestore
            .firestore()
            .collection("Notices")
            .document("\(_newNotice.TimeStamp)_\(_newNotice.Title.replacingOccurrences(of: " ", with: ""))")
        
        reference.setData(_newNotice.noticeToDict(), merge: true) { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
}
