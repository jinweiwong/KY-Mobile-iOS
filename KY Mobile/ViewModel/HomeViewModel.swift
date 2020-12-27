//
//  HomeViewModel.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 23/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class RecentPostsViewModel: ObservableObject {
    @Published var recentPosts: [RecentPost] = []
    
    init() {
        getAllRecentPosts()
    }
    
    func getAllRecentPosts() {
        let eventsRef = Firestore.firestore().collection("Events")
        let noticesRef = Firestore.firestore().collection("Notice")
        
        eventsRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting recent events: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let Title = diff.document.data()["Title"] as? String
                        let TimeStamp = diff.document.data()["timestamp"] as? String
                        
                        if TimeStamp != nil {
                            if Int(TimeStamp!)! > Int(Int(Date().timeIntervalSince1970 * 1000) - 86400000) {
                            self.recentPosts.append(RecentPost(Title: Title ?? "", TimeStamp: TimeStamp ?? ""))
                            }
                        }
                    }
                }
            }
        }
        
        noticesRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting recent notices: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let Title = diff.document.data()["Title"] as? String
                        let TimeStamp = diff.document.data()["TimeStamp"] as? String
                        
                        if TimeStamp != nil {
                            if Int(TimeStamp!)! > Int(Int(Date().timeIntervalSince1970 * 1000) - 86400000) {
                            self.recentPosts.append(RecentPost(Title: Title ?? "", TimeStamp: TimeStamp ?? ""))
                            }
                        }
                    }
                }
            }
            self.recentPosts.sort {
                $0.TimeStamp > $1.TimeStamp
            }
            print(self.recentPosts)
        }
    }
}
