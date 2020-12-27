//
//  UserLoginState.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 23/05/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseAuth

class CurrentUserInfo: ObservableObject {
    enum FBAuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAuthenticated: FBAuthState = .undefined
    @Published var currentUser: User = .init(UID: "", Name: "", Image: "", Email: "", Batch: "", StudentID: "")
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let _ = user else {
                self.isUserAuthenticated = .signedOut
                return
            }
            
            self.isUserAuthenticated = .signedIn
            
        })
    }
}

