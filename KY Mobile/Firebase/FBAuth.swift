import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class FBAuthFunctions {
    
    static func createUser(user: NewUser,
                           completionHandler: @escaping (Result <String, Error>) -> Void ){
        
        // Creating a new user in the authentication
        Auth.auth().createUser(withEmail: user.Email, password: user.Password) { (authResult, error) in
            if error != nil {
                completionHandler(.failure(error!))
            }
            
            guard let newUser = authResult?.user else {
                completionHandler(.failure(error!))
                return
            }
            
            // Creating a new user in the database
            // Document name is (UID)_(Name)
            let data: [String:Any] = ["UID" : newUser.uid,
                                      "Name" : user.Name,
                                      "StudentID" : user.StudentID,
                                      "Batch" : user.Batch,
                                      "Email" : user.Email,
                                      "Image" : user.Image]
            
            FBProfile.editUserDetails(uid: newUser.uid,
                                      info: data) { (result) in
                switch result {
                case .failure (let error):
                    print("\(error.localizedDescription)")
                    
                case .success:
                    print("Successfully merged new user into Firestore")
                }
            }
            completionHandler(.success(newUser.uid))
            return
            
        }
    }
    
    
    // Authenticate user's email and password
    static func authenticate(email: String,
                             password: String,
                             completionHandler: @escaping (Result <Bool, Error>) -> () ){
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                completionHandler(.failure(error!))
            } else {
                completionHandler(.success(true))
            }
        }
    }
    
    
    // Sends an email to the user's email inbox to reset their password
    static func resetPassword(email: String,
                              resetCompletion: @escaping (Result <Bool, Error>) -> Void ){
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error != nil {
                resetCompletion(.failure(error!))
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
