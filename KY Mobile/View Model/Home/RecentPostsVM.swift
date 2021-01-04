import Foundation
import SwiftUI
import FirebaseFirestore

class RecentPostsViewModel: ObservableObject {
    @Published var recentPosts: [NotificationModel] = []
    
    init() {
        getAllRecentPosts()
    }
    
    func getAllRecentPosts() {
        let postsRef = Firestore.firestore().collection("Posts")
        let noticesRef = Firestore.firestore().collection("Notices")
        
        // Add snapshot listener for recent posts
        postsRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting recent posts: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let UUID = diff.document.data()["UUID"] as? String
                        let Title = diff.document.data()["Title"] as? String
                        let TimeStamp = diff.document.data()["TimeStamp"] as? String
                        
                        if TimeStamp != nil {
                            if Int(TimeStamp!)! > Int(Int(Date().timeIntervalSince1970 * 1000) - 86400000) {
                                self.recentPosts.append(NotificationModel(UUID: UUID ?? "",
                                                                          Title: Title ?? "",
                                                                          TimeStamp: TimeStamp ?? ""))
                            }
                        }
                    }
                }
            }
        }
        
        // Add snapshot listener for recent notices
        noticesRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting recent notices: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let UUID = diff.document.data()["UUID"] as? String
                        let Title = diff.document.data()["Title"] as? String
                        let TimeStamp = diff.document.data()["TimeStamp"] as? String
                        
                        if TimeStamp != nil {
                            if Int(TimeStamp!)! > Int(Int(Date().timeIntervalSince1970 * 1000) - 86400000) {
                                self.recentPosts.append(NotificationModel(UUID: UUID ?? "",
                                                                          Title: Title ?? "",
                                                                          TimeStamp: TimeStamp ?? ""))
                            }
                        }
                    }
                }
            }
            
            // Sort posts based on recency
            self.recentPosts.sort {
                $0.TimeStamp > $1.TimeStamp
            }
        }
    }
}
