import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class NoticesViewModel: ObservableObject {
    
    @Published var notices: [Notice] = []
    
    init() {
        getAllNotices()
    }
    
    func getAllNotices() {
        let docRef = Firestore.firestore().collection("Notice")
        
        docRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let Title = diff.document.data()["Title"] as? String
                        let Exco = diff.document.data()["Exco"] as? String
                        let Body = diff.document.data()["Body"] as? String
                        let TimeStamp = diff.document.data()["TimeStamp"] as? String
                        
                        self.notices.append(Notice(Title: Title ?? "0",
                                                   Exco: Exco ?? "0",
                                                   Body: Body ?? "0",
                                                   TimeStamp: TimeStamp ?? "0"))
                    }
                }
                
                self.notices.sort {
                    $0.TimeStamp > $1.TimeStamp
                }
            }
        }
    }
}
