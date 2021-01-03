import Foundation
import SwiftUI

struct SignInView: View {

    @Binding var newUser: NewUser
    
    @State private var showingForgotPasswordView: Bool = false
    
    @State private var errorMessage: String = "Unknown Error"
    @State private var showErrorMessage = false
    
    var body: some View {
        ZStack {
            
            //Background
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (alignment: .leading, spacing: 50) {
                    
                    Spacer()
                    header
                    textfields
                    buttons
                    Spacer()
                        
                        .alert(isPresented: $showErrorMessage) {
                            Alert(title: Text("Login Error"),
                                  message: Text(errorMessage),
                                  dismissButton: .default(Text("OK")))
                        }
                }
            }
        }
        .navigationBarTitle("Sign In", displayMode: .inline)
    }
    
    var header: some View {
        // Header
        VStack (alignment: .leading) {
            Text("Welcome back")
                .modifier(Title(textColor: Color("Black")))
            
            Text("Sign in to continue")
                .modifier(MediumText(textColor: Color("VeryDarkGrey")))
        }.frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
    }
    
    var textfields: some View {
        HStack (spacing: 15) {
            // Icons
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
            
            // Textfields
            VStack (spacing: 30) {
                // Email
                VStack (spacing: 0) {
                    TextField("Enter your email", text: $newUser.Email)
                        .frame(width: 300, height: 30)
                    
                    Divider()
                        .frame(width: 300, height: 2)
                }
                
                // Password
                VStack (spacing: 0) {
                    SecureField("Enter your password", text: $newUser.Password)
                        .frame(width: 300, height: 30)
                    
                    Divider()
                        .frame(width: 300, height: 2)
                }
            }
        }
    }
    
    var buttons: some View {
        VStack (spacing: 10) {
            // Log in Button
            Button(action: {
                FBAuthFunctions.authenticate(email: newUser.Email,
                                             password: newUser.Password) { (result) in
                    switch result {
                    
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                        showErrorMessage = true
                        
                    case .success(_):
                        break
                    }}
            }) {
                Text("Log In")
            }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
            
            // Forgot password Button
            NavigationLink(destination: ForgotPasswordView(newUser: $newUser), isActive: self.$showingForgotPasswordView) {
                Button(action: {
                    print("Forgot your password?")
                    self.showingForgotPasswordView = true
                }) {
                    Text("Forgot your password?")
                        .modifier(TinyText(textColor: Color("NormalBlue")))
                }
            }
        }
    }
}
