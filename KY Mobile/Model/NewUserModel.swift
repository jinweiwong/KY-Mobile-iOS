//
//  TextfieldCheck.swift
//  KY Mobile
//
//  Created by Wong Jin Wei on 27/12/2020.
//

import Foundation

struct NewUser {
    var name: String
    var studentID: String
    var batch: String
    var email: String
    var image: String
    var password: String
    var confirmPassword: String
    
    init() {
        self.name = ""
        self.studentID = ""
        self.batch = ""
        self.email = ""
        self.image = ""
        self.password = ""
        self.confirmPassword = ""
    }
    
    
    func isNameEmpty() -> Bool {
        // Leading, trailing whitespaces and newlines are ignored
        return name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    func isStudentIDValid() -> Bool {
        return studentID.count == 4
    }
    
    
    func isBatchValid() -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        let allowedBatches = [currentYear - 1999, currentYear - 1998, currentYear - 1997]
        
        let splitedUpBatch = batch.split(separator: ".")
        
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
        return emailTest.evaluate(with: email)
    }
    
    
    func isPasswordValid()  -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    
    func passwordMatch() -> Bool {
        return confirmPassword == password
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
}
