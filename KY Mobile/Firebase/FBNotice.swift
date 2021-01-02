import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBNotice {
    static func uploadNewNotice(newNotice: Notice, completion: @escaping (Result<Bool, Error>) -> () ) {
        var _newNotice = newNotice
        _newNotice.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
        
        let reference = Firestore
            .firestore()
            .collection("Notice")
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
