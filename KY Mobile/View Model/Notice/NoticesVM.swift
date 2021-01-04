import Foundation
import SwiftUI
import FirebaseFirestore

class NoticesViewModel: ObservableObject {
    
    @Published var notices: [Notice] = []
    
    init() {
        getAllNotices()
    }
    
    // Add snapshot listener for all notices
    func getAllNotices() {
        let docRef = Firestore.firestore().collection("Notices")
        
        docRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let UUID = diff.document.data()["UUID"] as? String
                        let Title = diff.document.data()["Title"] as? String
                        let Exco = diff.document.data()["Exco"] as? String
                        let Body = diff.document.data()["Body"] as? String
                        let TimeStamp = diff.document.data()["TimeStamp"] as? String
                        
                        self.notices.append(Notice(UUID: UUID ?? "0",
                                                   Title: Title ?? "0",
                                                   Exco: Exco ?? "0",
                                                   Body: Body ?? "0",
                                                   TimeStamp: TimeStamp ?? "0"))
                    }
                }
                
                // Sort notices based on recency
                self.notices.sort {
                    $0.TimeStamp > $1.TimeStamp
                }
            }
        }
    }
}
