//
//  ProfileView.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 19/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var currentUserInfo: CurrentUserInfo
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                
                
                
                //Text("Signed in as Jin Wei")
                Text("Signed in as \(currentUserInfo.currentUser.Name)")
                    
                    .navigationBarTitle(Text("Profile"))
                    .navigationBarItems(trailing: Button("Sign out") {
                        FBAuthFunctions.logout { (result) in
                        }
                    })
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
