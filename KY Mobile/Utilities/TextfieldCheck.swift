//
//  TextfieldCheck.swift
//  KY Mobile
//
//  Created by Wong Jin Wei on 27/12/2020.
//

import Foundation

struct FBTextFieldFunctions {
    var name: String = ""
    var studentID: String = ""
    var batch: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var image: String = ""
    
    
    func isEmpty(_field: String) -> Bool {
        // Leading, trailing whitespaces and newlines are ignored
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    func isStudentIDValid(_studentID: String) -> Bool {
        return _studentID.count == 4
    }
    
    
    func isBatchValid(_batch: String) -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        let allowedBatches = [currentYear - 1999, currentYear - 1998, currentYear - 1997]
        
        let splitedUpBatch = _batch.split(separator: ".")
        
        if splitedUpBatch.count == 2 {
            if allowedBatches.contains((splitedUpBatch[0] as NSString).integerValue) {
                if [0, 5].contains((splitedUpBatch[1] as NSString).integerValue) {
                    return true
                }
            }
        }
        return false
    }
    
    
    func isEmailValid(_email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    
    func isPasswordValid(_password: String)  -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    
    func passwordMatch(_confirmPW: String) -> Bool {
        return _confirmPW == password
    }
    
    
    // Checks Name, StudentID, Batch, Email, MatchingPasswords.
    var isSignInComplete: Bool {
        if isEmpty(_field: name) ||
            !isStudentIDValid(_studentID: studentID) ||
            !isBatchValid(_batch: batch) ||
            !isEmailValid(_email: email) ||
            !passwordMatch(_confirmPW: confirmPassword) {
            return false
        }
        return true
    }
    
    
    // Checks Email and Password
    var isLogInComplete: Bool {
        if !isEmailValid(_email: email) ||
            !isPasswordValid(_password: password) {
            return false
        }
        return true
    }
    
    
    
}
