//
//  SignUpView.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 16/08/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    
    @State private var textFieldInfo = FBTextFieldFunctions()
    
    @State private var passwordShow: Bool = false
    @State private var confirmPasswordShow: Bool = false
    
    @State private var errorSignUp: String = ""
    @State private var showAlertSignUp = false
    
    @State private var showingSignInView: Bool = false
    
    var body: some View {
        ZStack {
            
            //Background
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30) {
                
                //Heading
                Text("Sign up to continue")
                    .modifier(MediumText(textColor: Color("VeryDarkGrey")))
                    .frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
                
                
                //Profile picture selector
                Button(action: {
                    print("Button Pressed")
                }) {
                    Image("WeBareBears")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(lineWidth: 0.5)
                            .foregroundColor(Color("Black"))
                    )
                }.buttonStyle(PlainButtonStyle())
                
                HStack (spacing: 15) {
                    //Icons
                    VStack (spacing: 42) {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15)
                        
                        Image(systemName: "grid")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15)
                        
                        Image(systemName: "person.3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15)
                        
                        Image(systemName: "envelope")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15)
                        
                        Image(systemName: "lock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                        
                        Image(systemName: "lock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 18)
                    }.frame(width: 40, alignment: .trailing)
                    
                    
                    //Textfields
                    VStack (spacing: 25) {
                        
                        //Name
                        VStack (spacing: 0) {
                            TextField("Enter your full name", text: $textFieldInfo.name)
                                .autocapitalization(.words)
                                .frame(width: 300, height: 30)
                            
                            Divider()
                                .frame(width: 300, height: 2)
                                .background(textFieldInfo.isEmpty(_field: textFieldInfo.name) ? Color("VeryLightGrey") : Color("Green"))
                            
                        }
                        
                        //Student ID
                        VStack (spacing: 0) {
                            TextField("Enter your Student ID", text: $textFieldInfo.studentID)
                                .frame(width: 300, height: 30)
                                .autocapitalization(.none)
                                .keyboardType(.numbersAndPunctuation)
                            
                            Divider()
                                .frame(width: 300, height: 2)
                                .background(textFieldInfo.isStudentIDValid(_studentID: textFieldInfo.studentID) ? Color("Green") : Color("VeryLightGrey"))
                        }
                        
                        //Batch
                        VStack (spacing: 0) {
                            TextField("Enter your batch", text: $textFieldInfo.batch)
                                .frame(width: 300, height: 30)
                                .autocapitalization(.none)
                                .keyboardType(.numbersAndPunctuation)
                            
                            Divider()
                                .frame(width: 300, height: 2)
                                .background(textFieldInfo.isBatchValid(_batch: textFieldInfo.batch) ? Color("Green") : Color("VeryLightGrey"))
                        }
                        
                        //Email
                        VStack (spacing: 0) {
                            TextField("Enter your email", text: $textFieldInfo.email)
                                .frame(width: 300, height: 30)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                            
                            Divider()
                                .frame(width: 300, height: 2)
                                .background(textFieldInfo.isEmailValid(_email: textFieldInfo.email) ? Color("Green") : Color("VeryLightGrey"))
                        }
                        
                        //Password
                        VStack (alignment: .leading, spacing: 0) {
                            HStack {
                                if passwordShow {
                                    TextField("Enter your password", text: $textFieldInfo.password)
                                        .frame(width: 270, height: 30)
                                    
                                    Button(action: {
                                        self.passwordShow.toggle()
                                    }) {
                                        Image(systemName: "eye.slash.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color("DarkGrey"))
                                            .frame(height: 12)
                                    }
                                }
                                    
                                else {
                                    SecureField("Enter your password", text: $textFieldInfo.password)
                                        .frame(width: 270, height: 30)
                                    
                                    Button(action: {
                                        self.passwordShow.toggle()
                                    }) {
                                        Image(systemName: "eye.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color("DarkGrey"))
                                            .frame(height: 12)
                                    }
                                }
                            }
                            
                            Divider()
                                .frame(width: 300, height: 2)
                                .background(textFieldInfo.isPasswordValid(_password: textFieldInfo.password) ? Color("Green") : Color("VeryLightGrey"))
                        }
                        
                        //Confirm password
                        VStack (alignment: .leading, spacing: 0) {
                            HStack {
                                if confirmPasswordShow {
                                    TextField("Confirm your password", text: $textFieldInfo.confirmPassword)
                                        .frame(width: 270, height: 30)
                                    
                                    Button(action: {
                                        self.confirmPasswordShow.toggle()
                                    }) {
                                        Image(systemName: "eye.slash.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color("DarkGrey"))
                                            .frame(height: 12)
                                    }
                                }
                                    
                                else {
                                    SecureField("Confirm your password", text: $textFieldInfo.confirmPassword)
                                        .frame(width: 270, height: 30)
                                    
                                    Button(action: {
                                        self.confirmPasswordShow.toggle()
                                    }) {
                                        Image(systemName: "eye.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color("DarkGrey"))
                                            .frame(height: 12)
                                    }
                                }
                            }
                            
                            Divider()
                                .frame(width: 300, height: 2)
                                .background(textFieldInfo.passwordMatch(_confirmPW: textFieldInfo.confirmPassword) &&
                                    textFieldInfo.isPasswordValid(_password: textFieldInfo.confirmPassword) ? Color("Green") : Color("VeryLightGrey"))
                        }
                    }
                }
                
                //Buttons
                VStack (spacing: 10) {
                    //Create account
                    Button(action: {
                        FBAuthFunctions.createUser(name: self.textFieldInfo.name,
                                                   studentID: self.textFieldInfo.studentID,
                                                   batch: self.textFieldInfo.batch,
                                                   email: self.textFieldInfo.email,
                                                   password: self.textFieldInfo.password,
                                                   image: self.textFieldInfo.image
                                                   ) { (result) in
                                                    switch result {
                                                    case .failure (let error):
                                                        self.errorSignUp = error.localizedDescription
                                                        self.showAlertSignUp = true
                                                        
                                                    case .success(_):
                                                        break
                                                    }}
                    }) {
                        Text("Create Account")
                    }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
                    
                    
                    NavigationLink(destination: SignInView(), isActive: self.$showingSignInView) {
                        //Already have an account
                        Button(action: {
                            print("Already have an account?")
                            self.showingSignInView = true
                        }) {
                            Text("Already have an account?")
                                .modifier(TinyText(textColor: Color("NormalBlue")))
                        }
                    }
                }.alert(isPresented: self.$showAlertSignUp) {
                    Alert(title: Text("Error creating account"),
                          message: Text(self.errorSignUp),
                          dismissButton: .default(Text("OK")))
                }
            }.modifier(Keyboard())
        }.navigationBarTitle("Sign Up", displayMode: .inline)
    }
}


struct Keyboard: ViewModifier {
    
    @State var offset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, offset)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                    
                    let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    
                    let height = value.height
                    self.offset = height + 20
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                    
                    self.offset = 0
                }
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
        }
    }
}
