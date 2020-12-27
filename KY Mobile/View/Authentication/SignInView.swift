//
//  SignInView.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 31/08/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI

struct SignInView: View {

    @State private var textFieldInfo = FBTextFieldFunctions()
    
    @State private var Email = ""
    @State private var Password = ""
    
    @State private var showingForgotPasswordView: Bool = false
    
    @State private var errorSignIn: EmailAuthError?
    @State private var showAlertSignIn = false
    
    var body: some View {
        ZStack {
            
            //Background
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading, spacing: 50) {
                
                //Heading
                VStack (alignment: .leading) {
                    Text("Welcome back")
                        .modifier(Title(textColor: Color("Black")))
                    
                    Text("Sign in to continue")
                        .modifier(MediumText(textColor: Color("VeryDarkGrey")))
                }.frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
                
                HStack (spacing: 15) {
                    //Icons
                    VStack (spacing: 46) {
                        Image(systemName: "envelope")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15)
                        
                        Image(systemName: "lock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                    }.frame(width: 20, alignment: .trailing)
                    
                    //Textfields
                    VStack (spacing: 30) {
                        //Email
                        VStack (spacing: 0) {
                            TextField("Enter your email", text: $Email)
                                .frame(width: 300, height: 30)
                            
                            Divider()
                                .frame(width: 300, height: 2)
                        }
                        
                        //Password
                        VStack (spacing: 0) {
                            SecureField("Enter your password", text: $Password)
                                .frame(width: 300, height: 30)
                            
                            Divider()
                                .frame(width: 300, height: 2)
                        }
                    }
                }
                
                //Buttons
                VStack (spacing: 10) {
                    //Log in
                    Button(action: {
                        FBAuthFunctions.authenticate(email: self.textFieldInfo.email,
                                                     password: self.textFieldInfo.password) { (result) in
                                                        switch result {
                                                            
                                                        case .failure(let error):
                                                            self.errorSignIn = error
                                                            self.showAlertSignIn = true
                                                            
                                                        case .success(_):
                                                            break
                                                            
                                                        }
                        }
                    }) {
                        Text("Log In")
                    }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
                    
                    //Forgot password
                    NavigationLink(destination: ForgotPasswordView(), isActive: self.$showingForgotPasswordView) {
                        Button(action: {
                            print("Forgot your password?")
                            self.showingForgotPasswordView = true
                        }) {
                            Text("Forgot your password?")
                                .modifier(TinyText(textColor: Color("NormalBlue")))
                        }
                    }
                }.alert(isPresented: self.$showAlertSignIn) {
                    Alert(title: Text("Login Error"),
                          message: Text(self.errorSignIn?.localizedDescription ?? "Unknown Error"),
                          dismissButton: .default(Text("OK")) {
                            if self.errorSignIn == .incorrectPassword {
                                self.textFieldInfo.password = ""
                            }
                            else {
                                self.textFieldInfo.email = ""
                                self.textFieldInfo.password = ""
                            }
                        })
                }
            }
        }.navigationBarTitle("Sign In", displayMode: .inline)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView()
        }
    }
}
