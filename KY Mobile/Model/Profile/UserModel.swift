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
    init?(userDict: [String: Any]) {
        self.UID = userDict["UID"] as? String ?? ""
        self.Name = userDict["Name"] as? String ?? ""
        self.Image = userDict["Image"] as? String ?? ""
        self.Email = userDict["Email"] as? String ?? ""
        self.Batch = userDict["Batch"] as? String ?? ""
        self.StudentID = userDict["StudentID"] as? String ?? ""
    }
    
    // Check if two Users are the same
    // Used to check if any changes are made to the user's details
    func equalTo(_ user: User) -> Bool {
        return (self.UID == user.UID &&
                    self.Name == user.Name &&
                    self.Image == user.Image &&
                    self.Email == user.Email &&
                    self.Batch == user.Batch &&
                    self.StudentID == user.StudentID)
    }
    
    func userToDict() -> [String: Any] {
        return ["UID": self.UID,
                "Name": self.Name,
                "Image": self.Image,
                "Email": self.Email,
                "Batch": self.Batch,
                "StudentID": self.StudentID]
    }
}
