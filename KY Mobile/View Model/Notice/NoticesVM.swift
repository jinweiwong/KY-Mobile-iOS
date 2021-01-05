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
                    
                    let notice: Notice = Notice(noticeDict: diff.document.data())!
                    
                    if diff.type == .added {
                        self.notices.append(notice)
                    }
                    else if diff.type == .modified {
                        self.notices = self.notices.filter { $0.UUID != notice.UUID }
                        self.notices.append(notice)
                    }
                    else if diff.type == .removed {
                        self.notices = self.notices.filter { $0.UUID != notice.UUID }
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
