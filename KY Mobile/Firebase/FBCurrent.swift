import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBCurrent {
    
    // Upload new post
    // Takes in boolean variables to see if the post has a Start and End time.
    static func uploadNewPost(newPost: NewPost,
                               boolAllDay: Bool,
                               boolStart: Bool,
                               boolEnd: Bool,
                               completion: @escaping (Result<Bool, Error>) -> () ) {
        
        var _newPost = newPost.convertAllToString()
        
        if boolAllDay {
            _newPost.StartTime = ""
            _newPost.EndTime = ""
        }
        
        if !boolStart {
            _newPost.StartDate = ""
            _newPost.StartTime = ""
        }
        
        if !boolEnd {
            _newPost.EndDate = ""
            _newPost.EndTime = ""
        }
        
        // Document name is (TimeStamp)_(Title)
        let reference = Firestore
            .firestore()
            .collection("Posts")
            .document("\(_newPost.TimeStamp)_\(_newPost.Title.replacingOccurrences(of: " ", with: ""))")
        
        reference.setData(_newPost.postToDict(), merge: true) { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            print("PostToDict: \(_newPost.postToDict())")
            completion(.success(true))
        }
    }
}
