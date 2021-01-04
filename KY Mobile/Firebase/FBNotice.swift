import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBNotice {

    // Uploads new notice
    static func uploadNewNotice(newNotice: NewNotice,
                                boolTimeStamp: Bool,
                                completion: @escaping (Result<Bool, Error>) -> () ) {
        
        // Converts newNotice to type Notice
        var _newNotice = newNotice.convertAllToString()
        
        // Sets the current time to the TimeStamp of the notice
        if !boolTimeStamp {
            _newNotice.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
        }
            
        let reference = Firestore
            .firestore()
            .collection("Notices")
            .document(_newNotice.UUID)
        
        reference.setData(_newNotice.noticeToDict(), merge: true) { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
}
