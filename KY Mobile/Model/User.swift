//
//  FBUser.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 24/05/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation

struct User {
    let UID: String
    let Name: String
    let Image: String
    let Email: String
    let Batch: String
    let StudentID: String
    
    // Adding information to FBUser
    init(UID: String, Name: String, Image: String, Email: String, Batch: String, StudentID: String) {
        self.UID = UID
        self.Name = Name
        self.Image = Image
        self.Email = Email
        self.Batch = Batch
        self.StudentID = StudentID
    }
    
    // Adding information to FBUser using a retrieved document
    init?(UserData: [String: Any]) {
    self.init(UID: UserData["UID"] as? String ?? "",
              Name: UserData["Name"] as? String ?? "",
              Image: UserData["Image"] as? String ?? "",
              Email: UserData["Email"] as? String ?? "",
              Batch: UserData["Batch"] as? String ?? "",
              StudentID: UserData["StudentID"] as? String ?? "")
    }
}



