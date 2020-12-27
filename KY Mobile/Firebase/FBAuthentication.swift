//
//  FBAuthentication.swift
//  KY Mobile
//
//  Created by Wong Jin Wei on 27/12/2020.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import CryptoKit
import AuthenticationServices


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
