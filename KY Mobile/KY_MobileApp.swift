//
//  KY_MobileApp.swift
//  KY Mobile
//
//  Created by Wong Jin Wei on 27/12/2020.
//

import SwiftUI
import Firebase

@main
struct KY_MobileApp: App {
    
    var currentUserInfo = CurrentUserInfo()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ViewController().environmentObject(currentUserInfo)
        }
    }
}
