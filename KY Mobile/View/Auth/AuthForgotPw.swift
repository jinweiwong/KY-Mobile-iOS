import Foundation
import SwiftUI

struct ForgotPasswordView: View {
    
    enum sentUsing {
        case pending
        case email
        //case studentID
    }
    
    @Binding var newUser: NewUser
    
    @State private var resetPasswordUsing: sentUsing = .pending
    @State private var errorMessage: String = "Unknown Error"
    @State private var showErrorMessage: Bool = false
    @State private var emailAddress: String = ""

    var body: some View {
        ZStack {
            
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack (spacing: 50) {
                    Spacer()
                    //header
                    resetUsingEmail
                    //divider
                    //resetUsingStudentID
                    Spacer()
                    
                }.alert(isPresented: $showErrorMessage) {
                    Alert(title: Text("Error"),
                          message: Text(errorMessage),
                          dismissButton: .default(Text("OK")))
                }
            }
        }.navigationBarTitle("Reset Password", displayMode: .inline)
    }
    
    
//    var header: some View {
//        Text("Sign up to continue")
//            .modifier(MediumText(textColor: Color("VeryDarkGrey")))
//            .frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
//    }
    
    
    var resetUsingEmail: some View {
        VStack (alignment: .leading, spacing: 30) {
            
            // Textfield
            VStack (alignment: .leading, spacing: 8) {
                Text("Forgot your password?")
                    .modifier(MediumText(textColor: Color("VeryDarkGrey")))
            }.frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
            
            HStack (spacing: 15) {
                VStack (spacing: 46) {
                    Image(systemName: "envelope")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 15)
                }.frame(width: 20, alignment: .trailing)
                
                VStack (spacing: 30) {
                    VStack (spacing: 0) {
                        TextField("Enter your email", text: $newUser.email)
                            .frame(width: 300, height: 30)
                            .autocapitalization(.none)
                        
                        Divider()
                            .frame(width: 300, height: 2)
                    }
                }
            }
            
            // Button
            VStack (alignment: .leading, spacing: 15) {
                VStack (spacing: 10) {
                    Button(action: {
                    
                        FBAuthFunctions.resetPassword(email: newUser.email) { (result) in
                            switch result {
                            
                            case .failure(let error):
                                errorMessage = error.localizedDescription
                                showErrorMessage = true
                                
                            case .success(_):
                                resetPasswordUsing = .email
                                emailAddress = newUser.email
                            }}
                    }) {
                        Text("Send Email")
                    }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
                }
                
                Group {
                    if resetPasswordUsing == .email {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("Green"))
                            
                            Text("An email has been sent to \(emailAddress)")
                                .modifier(TinyText(textColor: Color("Green")))
                        }
                    }
                }
            }
        }
    }
}
    
    
//    var divider: some View {
//        //Divider
//        HStack (spacing: 15) {
//            VStack { Divider()
//                .background(Color("DarkGrey"))
//            }.padding(0)
//
//            Text("or")
//                .foregroundColor(Color("DarkGrey"))
//
//            VStack { Divider()
//                .background(Color("DarkGrey"))
//            }.padding(0)
//        }
//    }
//
//
//    var resetUsingStudentID: some View {
//        VStack (alignment: .leading, spacing: 30) {
//            HStack (spacing: 15) {
//                VStack (spacing: 46) {
//                    Image(systemName: "grid")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: 15)
//                }.frame(width: 20, alignment: .trailing)
//
//                VStack (spacing: 30) {
//                    VStack (spacing: 0) {
//                        TextField("Enter your Student ID", text: $newUser.studentID)
//                            .frame(width: 300, height: 30)
//
//                        Divider()
//                            .frame(width: 300, height: 2)
//                    }
//                }
//            }
//
//            VStack (alignment: .leading, spacing: 15) {
//                VStack (spacing: 10) {
//                    Button(action: {
//                        emailAddress = FBService.retrieveEmailFromStudentID(studentID: newUser.studentID)
//
//                        if emailAddress == "" {
//                            errorMessage = "No email associated with Student ID \(newUser.studentID)"
//                            showErrorMessage = true
//                        } else {
//                            FBAuthFunctions.resetPassword(email: emailAddress) { (result) in
//                                switch result {
//
//                                case .failure(let error):
//                                    errorMessage = error.localizedDescription
//                                    showErrorMessage = true
//
//                                case .success(_):
//                                    resetPasswordUsing = .studentID
//                                }}
//                        }
//                    }) {
//                        Text("Send Email")
//                    }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
//                }
//
//                Group {
//                    if resetPasswordUsing == .studentID {
//                        HStack {
//                            Image(systemName: "checkmark.circle.fill")
//                                .foregroundColor(Color("Green"))
//
//                            Text("An email has been sent to \(emailAddress)")
//                                .modifier(TinyText(textColor: Color("Green")))
//                        }
//                    }
//                }
//            }
//        }
//    }
