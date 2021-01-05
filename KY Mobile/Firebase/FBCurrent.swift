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
                               boolTimeStamp: Bool,
                               completion: @escaping (Result<Bool, Error>) -> () ) {
        
        // Converts newPost to type Post
        var _newPost = newPost.convertAllToString()
        
        // Set the current TimeStamp if no TimeStamp was specified
        if !boolTimeStamp {
            _newPost.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
        }
        
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
        
        let reference = Firestore
            .firestore()
            .collection("Posts")
            .document(_newPost.UUID)
        
        reference.setData(_newPost.postToDict(), merge: true) { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
    
    
    // Edit Post
    // Takes in boolean variables to see if the post has a Start and End time.
    static func makeEditsToPost(editPost: NewPost,
                                boolAllDay: Bool,
                                boolStart: Bool,
                                boolEnd: Bool,
                                boolTimeStamp: Bool,
                                completion: @escaping (Result<Bool, Error>) -> () ) {
        
        // Converts newPost to type Post
        var _editPost = editPost.convertAllToString()
        
        // Set the current TimeStamp if no TimeStamp was specified
        if !boolTimeStamp {
            _editPost.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
        }
        
        if boolAllDay {
            _editPost.StartTime = ""
            _editPost.EndTime = ""
        }
        
        if !boolStart {
            _editPost.StartDate = ""
            _editPost.StartTime = ""
        }
        
        if !boolEnd {
            _editPost.EndDate = ""
            _editPost.EndTime = ""
        }
        
        let reference = Firestore
            .firestore()
            .collection("Posts")
            .document(_editPost.UUID)
        
        reference.setData(_editPost.postToDict(), merge: true) { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
    
    
    // Deletes Post
    // Takes in boolean variables to see if the post has a Start and End time.
    static func deletePost(identifier: String,
                                completion: @escaping (Result<Bool, Error>) -> () ) {
        
        let reference = Firestore
            .firestore()
            .collection("Posts")
            .document(identifier)
        
        reference.delete() { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
}
