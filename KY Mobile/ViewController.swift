//
//  ContentView.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 23/05/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ViewController: View {
    @EnvironmentObject var currentUserInfo: CurrentUserInfo
    @State private var currentTab: Int = 0
    
    var body: some View {
        
        Group {

            // Checks if user is signed in or signed out
            if currentUserInfo.isUserAuthenticated == .undefined {
                Text("Loading...")
            }
            else if currentUserInfo.isUserAuthenticated == .signedOut {
                IntroductionView()
            }
            else {
                TabView {
                    HomeView()
                        .tabItem({
                            Image(systemName: "house")
                                .font(.system(size: 20))
                            Text("Home")
                        })
                        .tag(0)

                    CurrentView()
                        .tabItem({
                            Image(systemName: "calendar")
                                .font(.system(size: 20))
                            Text("Current")
                        })
                        .tag(1)

                    NoticesView()
                        .tabItem({
                            Image(systemName: "bell")
                                .font(.system(size: 20))
                            Text("Notices")
                        })
                        .tag(2)

                    ProfileView()
                        .tabItem({
                            Image(systemName: "person")
                                .font(.system(size: 20))
                            Text("Profile")
                        })
                        .tag(3)
                }.onAppear {
                    guard let uid = Auth.auth().currentUser?.uid else {
                        return
                    }
                    FBUtilities.retrieveFBUser(uid: uid) { (result) in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                            // Display some kind of alert
                        case .success(let user):
                            self.currentUserInfo.currentUser = user
                        }
                    }
            }
            }
        }.onAppear {
            self.currentUserInfo.configureFirebaseStateDidChange()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}
