import Foundation
import SwiftUI
import FirebaseFirestore

class PostsViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    init() {
        getAllPosts()
    }
    
    // Add snapshot listener for all posts
    func getAllPosts() {
        let docRef = Firestore.firestore().collection("Posts")
        
        docRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                
                querySnapshot!.documentChanges.forEach { diff in
                    
                    let post: Post = Post(postDict: diff.document.data())!
                    
                    if diff.type == .added {
                        self.posts.append(post)
                    }
                    else if diff.type == .modified {
                        self.posts = self.posts.filter { $0.UUID != post.UUID }
                        self.posts.append(post)
                    }
                    else if diff.type == .removed {
                        self.posts = self.posts.filter { $0.UUID != post.UUID }
                    }
                }
                
                // Sort posts based on recency
                self.posts.sort {
                    $0.TimeStamp > $1.TimeStamp
                }
            }
        }
    }
}
