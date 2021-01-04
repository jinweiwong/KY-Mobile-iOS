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
                    if diff.type == .added {
                        let Title = diff.document.data()["Title"] as? String
                        let FullDesc = diff.document.data()["FullDesc"] as? String
                        let ShortDesc = diff.document.data()["ShortDesc"] as? String
                        let StartDate = diff.document.data()["StartDate"] as? String
                        let EndDate = diff.document.data()["EndDate"] as? String
                        let StartTime = diff.document.data()["StartTime"] as? String
                        let EndTime = diff.document.data()["EndTime"] as? String
                        let Venue = diff.document.data()["Venue"] as? String
                        let Cover = diff.document.data()["Cover"] as? String
                        let TimeStamp = diff.document.data()["TimeStamp"] as? String
                        
                        self.posts.append(Post(Title: Title ?? "0",
                                                 FullDesc: FullDesc ?? "0",
                                                 ShortDesc: ShortDesc ?? "0",
                                                 StartDate: StartDate ?? "0",
                                                 EndDate: EndDate ?? "0",
                                                 StartTime: StartTime ?? "0",
                                                 EndTime: EndTime ?? "0",
                                                 Venue: Venue ?? "0",
                                                 Cover: Cover ?? "0",
                                                 TimeStamp: TimeStamp ?? "0"))
                        
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
