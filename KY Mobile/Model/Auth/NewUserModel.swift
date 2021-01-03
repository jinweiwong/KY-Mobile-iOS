import Foundation

struct NewUser {
    var Name: String
    var StudentID: String
    var Batch: String
    var Email: String
    var Image: String
    var Password: String
    var ConfirmPassword: String
    
    init() {
        self.Name = ""
        self.StudentID = ""
        self.Batch = ""
        self.Email = ""
        self.Image = ""
        self.Password = ""
        self.ConfirmPassword = ""
    }
    
    
    func isNameEmpty() -> Bool {
        // Leading, trailing whitespaces and newlines are ignored
        return Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    func isStudentIDValid() -> Bool {
        return StudentID.count == 4
    }
    
    
    func isBatchValid() -> Bool {
        // Only allows batches from currentYear+1 to year+3
        // eg. in 2020 it will allow 21.0 to 23.5
        // eg. in 2021 it will allow 22.0 to 24.5
        let currentYear = Calendar.current.component(.year, from: Date())
        let allowedBatches = [currentYear - 1999, currentYear - 1998, currentYear - 1997]
        
        let splitedUpBatch = Batch.split(separator: ".")
        
        if splitedUpBatch.count == 2 {
            if allowedBatches.contains((splitedUpBatch[0] as NSString).integerValue) {
                if [0, 5].contains((splitedUpBatch[1] as NSString).integerValue) {
                    return true
                }
            }
        }
        return false
    }
    
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: Email)
    }
    
    
    func isPasswordValid()  -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: Password)
    }
    
    
    func passwordMatch() -> Bool {
        return ConfirmPassword == Password
    }
    
    
    // Checks Name, StudentID, Batch, Email, MatchingPasswords.
    var isSignInComplete: Bool {
        if isNameEmpty() || !isStudentIDValid() || !isBatchValid() || !isEmailValid() || !passwordMatch() {
            return false
        }
        return true
    }
    
    
    // Checks Email and Password
    var isLogInComplete: Bool {
        if !isEmailValid() || !isPasswordValid() {
            return false
        }
        return true
    }
    
    
    func newUserToDict(userUID: String) -> [String: Any] {
        return ["UID": userUID,
                "Name": self.Name,
                "Image": self.Image,
                "Email": self.Email,
                "Batch": self.Batch,
                "StudentID": self.StudentID]
    }
}
