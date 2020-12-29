import Foundation

struct User {
    var UID: String
    var Name: String
    var Image: String
    var Email: String
    var Batch: String
    var StudentID: String
    
    init() {
        self.UID = ""
        self.Name = ""
        self.Image = ""
        self.Email = ""
        self.Batch = ""
        self.StudentID = ""
    }

    // Adding data to FBUser using a retrieved document from Firebase
    init?(UserData: [String: Any]) {
        self.UID = UserData["UID"] as? String ?? ""
        self.Name = UserData["Name"] as? String ?? ""
        self.Image = UserData["Image"] as? String ?? ""
        self.Email = UserData["Email"] as? String ?? ""
        self.Batch = UserData["Batch"] as? String ?? ""
        self.StudentID = UserData["StudentID"] as? String ?? ""
    }
}
