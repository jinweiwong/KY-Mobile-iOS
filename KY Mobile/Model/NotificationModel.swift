//
//  RecentPostModel.swift
//  KY Mobile
//
//  Created by Wong Jin Wei on 27/12/2020.
//

import Foundation

struct NotificationModel: Identifiable {
    var id = UUID()
    var Title: String
    var TimeStamp: String // Epoch Time
    
    init() {
        self.Title = ""
        self.TimeStamp = ""
    }
    
    init(Title: String, TimeStamp: String) {
        self.Title = Title
        self.TimeStamp = TimeStamp
    }
}
