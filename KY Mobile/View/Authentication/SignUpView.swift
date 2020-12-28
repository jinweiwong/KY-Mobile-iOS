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
    
    @Binding var newUser: NewUser
    
    @State private var passwordShow: Bool = false
    @State private var confirmPasswordShow: Bool = false
    
    @State private var errorMessage: String = "Unknown Error"
    @State private var showErrorMessage = false
    
    @State private var showingSignInView: Bool = false
    @State private var isShowingImagePicker: Bool = false
    @State private var profilePicture: UIImage = UIImage()
    
    var body: some View {
        ZStack {
            
            //Background
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack (spacing: 30) {
                    Spacer()
                    header
                    profilePicturePicker
                    textfields
                    buttons
                
                        .alert(isPresented: self.$showErrorMessage) {
                        Alert(title: Text("Error creating account"),
                              message: Text(self.errorMessage),
                              dismissButton: .default(Text("OK")))
                    }
                }
            //.modifier(Keyboard())
            }
        }.navigationBarTitle("Sign Up", displayMode: .inline)
    }
    
    var header: some View {
        Text("Sign up to continue")
            .modifier(MediumText(textColor: Color("VeryDarkGrey")))
            .frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
    }
    
    var profilePicturePicker: some View {
        Button(action: {
            isShowingImagePicker = true
        }) {
            Image(uiImage: profilePicture)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle()
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(Color("Black"))
            )
        }.buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $isShowingImagePicker, content: {
            ImagePickerView(isPresented: self.$isShowingImagePicker,
                            selectedImage: self.$profilePicture)
        })
    }
    
    var textfields: some View {
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
                    TextField("Enter your full name", text: $newUser.name)
                        .autocapitalization(.words)
                        .frame(width: 300, height: 30)
                    
                    Divider()
                        .frame(width: 300, height: 2)
                        .background(newUser.isNameEmpty() ? Color("VeryLightGrey") : Color("Green"))
                    
                }
                
                //Student ID
                VStack (spacing: 0) {
                    TextField("Enter your Student ID", text: $newUser.studentID)
                        .frame(width: 300, height: 30)
                        .autocapitalization(.none)
                        .keyboardType(.numbersAndPunctuation)
                    
                    Divider()
                        .frame(width: 300, height: 2)
                        .background(newUser.isStudentIDValid() ? Color("Green") : Color("VeryLightGrey"))
                }
                
                //Batch
                VStack (spacing: 0) {
                    TextField("Enter your batch", text: $newUser.batch)
                        .frame(width: 300, height: 30)
                        .autocapitalization(.none)
                        .keyboardType(.numbersAndPunctuation)
                    
                    Divider()
                        .frame(width: 300, height: 2)
                        .background(newUser.isBatchValid() ? Color("Green") : Color("VeryLightGrey"))
                }
                
                //Email
                VStack (spacing: 0) {
                    TextField("Enter your email", text: $newUser.email)
                        .frame(width: 300, height: 30)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    Divider()
                        .frame(width: 300, height: 2)
                        .background(newUser.isEmailValid() ? Color("Green") : Color("VeryLightGrey"))
                }
                
                //Password
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        if passwordShow {
                            TextField("Enter your password", text: $newUser.password)
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
                            SecureField("Enter your password", text: $newUser.password)
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
                        .background(newUser.isPasswordValid() ? Color("Green") : Color("VeryLightGrey"))
                }
                
                //Confirm password
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        if confirmPasswordShow {
                            TextField("Confirm your password", text: $newUser.confirmPassword)
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
                            SecureField("Confirm your password", text: $newUser.confirmPassword)
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
                        .background(newUser.passwordMatch() && newUser.isPasswordValid() ? Color("Green") : Color("VeryLightGrey"))
                }
            }
        }
    }
    
    var buttons: some View {
        VStack (spacing: 10) {
            //Create account
            Button(action: {
                if profilePicture != UIImage() {
                    FBService.uploadImage(chosenImage: profilePicture, location: "Users_ProfilePic/") { (result) in
                        switch result {
                        case .failure (let error):
                            self.errorMessage = error.localizedDescription
                            self.showErrorMessage = true
                        
                        case .success (let url):
                            do {
                                try self.newUser.image = String(contentsOf: url)
                            } catch {}
                        }
                    }
                }
                    
                FBAuthFunctions.createUser(user: newUser) { (result) in
                                            switch result {
                                            case .failure (let error):
                                                self.errorMessage = error.localizedDescription
                                                self.showErrorMessage = true
                                                
                                            case .success(_):
                                                break
                                            }}
            }) {
                Text("Create Account")
            }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
            
            
            NavigationLink(destination: SignInView(newUser: $newUser), isActive: self.$showingSignInView)
            {
                //Already have an account
                Button(action: {
                    print("Already have an account?")
                    self.showingSignInView = true
                }) {
                    Text("Already have an account?")
                        .modifier(TinyText(textColor: Color("NormalBlue")))
                }
            }
        }
    }
}

//struct SignUpView: View {
//
//    @Binding var newUser: NewUser
//
//    @State private var passwordShow: Bool = false
//    @State private var confirmPasswordShow: Bool = false
//
//    @State private var errorSignUp: String = ""
//    @State private var showAlertSignUp = false
//
//    @State private var showingSignInView: Bool = false
//    @State private var isShowingImagePicker: Bool = false
//    @State private var profilePictureSelected: UIImage = UIImage()
//
//    var body: some View {
//        ZStack {
//
//            //Background
//            Color("VeryLightGrey")
//                .edgesIgnoringSafeArea(.all)
//
//            ScrollView {
//                VStack (spacing: 30) {
//                    Spacer()
//                    header
//                    profilePicture
//                    textfields
//                    buttons
//
//                        .alert(isPresented: self.$showAlertSignUp) {
//                        Alert(title: Text("Error creating account"),
//                              message: Text(self.errorSignUp),
//                              dismissButton: .default(Text("OK")))
//                    }
//                }
//            //.modifier(Keyboard())
//            }
//        }.navigationBarTitle("Sign Up", displayMode: .inline)
//    }
//
//    var header: some View {
//        Text("Sign up to continue")
//            .modifier(MediumText(textColor: Color("VeryDarkGrey")))
//            .frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
//    }
//
//    var profilePicture: some View {
//        Button(action: {
//            isShowingImagePicker = true
//        }) {
//            Image(uiImage: profilePictureSelected)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 120, height: 120)
//                .clipShape(Circle())
//                .overlay(Circle()
//                    .stroke(lineWidth: 0.5)
//                    .foregroundColor(Color("Black"))
//            )
//        }.buttonStyle(PlainButtonStyle())
//        .sheet(isPresented: $isShowingImagePicker, content: {
//            ImagePickerView(isPresented: self.$isShowingImagePicker,
//                            selectedImage: self.$profilePictureSelected)
//        })
//    }
//
//    var textfields: some View {
//        HStack (spacing: 15) {
//            //Icons
//            VStack (spacing: 42) {
//                Image(systemName: "person")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 15)
//
//                Image(systemName: "grid")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 15)
//
//                Image(systemName: "person.3")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 15)
//
//                Image(systemName: "envelope")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 15)
//
//                Image(systemName: "lock")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 18)
//
//                Image(systemName: "lock.fill")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 18)
//            }.frame(width: 40, alignment: .trailing)
//
//
//            //Textfields
//            VStack (spacing: 25) {
//
//                //Name
//                VStack (spacing: 0) {
//                    TextField("Enter your full name", text: $newUser.name)
//                        .autocapitalization(.words)
//                        .frame(width: 300, height: 30)
//
//                    Divider()
//                        .frame(width: 300, height: 2)
//                        .background(newUser.isNameEmpty() ? Color("VeryLightGrey") : Color("Green"))
//
//                }
//
//                //Student ID
//                VStack (spacing: 0) {
//                    TextField("Enter your Student ID", text: $newUser.studentID)
//                        .frame(width: 300, height: 30)
//                        .autocapitalization(.none)
//                        .keyboardType(.numbersAndPunctuation)
//
//                    Divider()
//                        .frame(width: 300, height: 2)
//                        .background(newUser.isStudentIDValid() ? Color("Green") : Color("VeryLightGrey"))
//                }
//
//                //Batch
//                VStack (spacing: 0) {
//                    TextField("Enter your batch", text: $newUser.batch)
//                        .frame(width: 300, height: 30)
//                        .autocapitalization(.none)
//                        .keyboardType(.numbersAndPunctuation)
//
//                    Divider()
//                        .frame(width: 300, height: 2)
//                        .background(newUser.isBatchValid() ? Color("Green") : Color("VeryLightGrey"))
//                }
//
//                //Email
//                VStack (spacing: 0) {
//                    TextField("Enter your email", text: $newUser.email)
//                        .frame(width: 300, height: 30)
//                        .autocapitalization(.none)
//                        .keyboardType(.emailAddress)
//
//                    Divider()
//                        .frame(width: 300, height: 2)
//                        .background(newUser.isEmailValid() ? Color("Green") : Color("VeryLightGrey"))
//                }
//
//                //Password
//                VStack (alignment: .leading, spacing: 0) {
//                    HStack {
//                        if passwordShow {
//                            TextField("Enter your password", text: $newUser.password)
//                                .frame(width: 270, height: 30)
//
//                            Button(action: {
//                                self.passwordShow.toggle()
//                            }) {
//                                Image(systemName: "eye.slash.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .foregroundColor(Color("DarkGrey"))
//                                    .frame(height: 12)
//                            }
//                        }
//
//                        else {
//                            SecureField("Enter your password", text: $newUser.password)
//                                .frame(width: 270, height: 30)
//
//                            Button(action: {
//                                self.passwordShow.toggle()
//                            }) {
//                                Image(systemName: "eye.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .foregroundColor(Color("DarkGrey"))
//                                    .frame(height: 12)
//                            }
//                        }
//                    }
//
//                    Divider()
//                        .frame(width: 300, height: 2)
//                        .background(newUser.isPasswordValid() ? Color("Green") : Color("VeryLightGrey"))
//                }
//
//                //Confirm password
//                VStack (alignment: .leading, spacing: 0) {
//                    HStack {
//                        if confirmPasswordShow {
//                            TextField("Confirm your password", text: $newUser.confirmPassword)
//                                .frame(width: 270, height: 30)
//
//                            Button(action: {
//                                self.confirmPasswordShow.toggle()
//                            }) {
//                                Image(systemName: "eye.slash.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .foregroundColor(Color("DarkGrey"))
//                                    .frame(height: 12)
//                            }
//                        }
//
//                        else {
//                            SecureField("Confirm your password", text: $newUser.confirmPassword)
//                                .frame(width: 270, height: 30)
//
//                            Button(action: {
//                                self.confirmPasswordShow.toggle()
//                            }) {
//                                Image(systemName: "eye.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .foregroundColor(Color("DarkGrey"))
//                                    .frame(height: 12)
//                            }
//                        }
//                    }
//
//                    Divider()
//                        .frame(width: 300, height: 2)
//                        .background(newUser.passwordMatch() && newUser.isPasswordValid() ? Color("Green") : Color("VeryLightGrey"))
//                }
//            }
//        }
//    }
//
//    var buttons: some View {
//        VStack (spacing: 10) {
//            //Create account
//            Button(action: {
//                if profilePictureSelected != UIImage() {
//                    FBService.uploadImage(chosenImage: profilePictureSelected, location: "Users_ProfilePic/") { (result) in
//                        switch result {
//                        case .failure (let error):
//                            self.errorSignUp = error.localizedDescription
//                            self.showAlertSignUp = true
//
//                        case .success (let url):
//                            do {
//                                try self.newUser.image = String(contentsOf: url)
//                            } catch {}
//                        }
//                    }
//                }
//
//                FBAuthFunctions.createUser(user: newUser) { (result) in
//                                            switch result {
//                                            case .failure (let error):
//                                                self.errorSignUp = error.localizedDescription
//                                                self.showAlertSignUp = true
//
//                                            case .success(_):
//                                                break
//                                            }}
//            }) {
//                Text("Create Account")
//            }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
//
//
//            NavigationLink(destination: SignInView(newUser: $newUser), isActive: self.$showingSignInView)
//            {
//                //Already have an account
//                Button(action: {
//                    print("Already have an account?")
//                    self.showingSignInView = true
//                }) {
//                    Text("Already have an account?")
//                        .modifier(TinyText(textColor: Color("NormalBlue")))
//                }
//            }
//        }
//    }
//}


//struct Keyboard: ViewModifier {
//
//    @State var offset: CGFloat = 0
//
//    func body(content: Content) -> some View {
//        content
//            .padding(.bottom, offset)
//            .animation(.spring())
//            .onAppear {
//                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
//
//                    let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//
//                    let height = value.height
//                    self.offset = height + 20
//                }
//
//                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
//
//                    self.offset = 0
//                }
//        }
//    }
//}


//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SignUpView(newUser: Binding.constant(newUser()))
//        }
//    }
//}
