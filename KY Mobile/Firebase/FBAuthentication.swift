//
//  UserViewModel.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 23/05/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import CryptoKit
import AuthenticationServices

// FBUser view model which contains functions that help in user authentiation
struct FBTextFieldFunctions {
    var name: String = ""
    var studentID: String = ""
    var batch: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var image: String = ""
    
    // Validation checks
    
    // Checks if the input in a textfield is empty.
    // Leading, trailing whitespaces and newlines are ignored
    func isEmpty(_field: String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    // Checks if user's password and confirmed password is the same
    func passwordMatch(_confirmPW: String) -> Bool {
        return _confirmPW == password
    }
    
    
    // Checks if user has entered their full name and whether the passwords match
    var isSignInComplete: Bool {
        if isEmpty(_field: name) ||
            !isEmailValid(_email: email) ||
            !passwordMatch(_confirmPW: confirmPassword) {
            return false
        }
        return true
    }
    
    
    // Checks if user has entered their email and their password
    var isLogInComplete: Bool {
        if !isEmailValid(_email: email) ||
            !isPasswordValid(_password: password) {
            return false
        }
        return true
    }
    
    func isStudentIDValid(_studentID: String) -> Bool {
        return _studentID.count == 4
    }
    
    // Checks if batch entered is valid
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
    
    // Checks if email entered is valid
    func isEmailValid(_email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    
    // Checks if password entered is valid
    func isPasswordValid(_password: String)  -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
}


enum FBAuthFunctions {
    
    // Creates a new user
    static func createUser(name: String,
                           studentID: String,
                           batch: String,
                           email: String,
                           password: String,
                           image: String,
                           completionHandler: @escaping (Result <Bool, Error>) -> Void ){
        
        // Creating a new user in the authentication
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let newAccount = authResult?.user else {
                completionHandler(.failure(error!))
                return
            }
            
            // Creating a new user in the database
            let data: [String:Any] = ["UID" : newAccount.uid,
                                      "Name" : name,
                                      "StudentID" : studentID,
                                      "Batch" : batch,
                                      "Email" : email,
                                      "Image" : image
                                      ]
            
            FBUtilities.mergeFBUser(uid: newAccount.uid, info: data) { (result) in
                completionHandler(result)
            }
            
            completionHandler(.success(true))
        }
    }
    
    // Authenticate user's email and password
    static func authenticate(email: String,
                             password: String,
                             completionHandler: @escaping (Result <Bool, EmailAuthError>) -> () ){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
    
            if let error = error {
                
                let newError = error as NSError
                var authError: EmailAuthError
                
                switch newError.code {
                case 17008:
                    authError = .invalidEmail
                case 17009:
                    authError = .incorrectPassword
                case 17011:
                    authError = .accoundDoesNotExist
                default:
                    authError = .unknownError
                }
                completionHandler(.failure(authError))
                
            } else {
                completionHandler(.success(true))
            }
        }
    }
    
    // Sends an email to the user's email inbox to reset their password
    static func resetPassword(email: String,
                              resetCompletion: @escaping (Result <Bool, Error>) -> Void ){
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        })
    }
    
    // Logs out of the user's account
    static func logout(completion: @escaping (Result <Bool, Error>) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
}

