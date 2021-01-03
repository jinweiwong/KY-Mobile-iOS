import Foundation
import SwiftUI

struct IntroductionView: View {
    
    @State var newUser = NewUser()
    
    @State private var showingSignUpView: Bool = false
    @State private var showingSignInView: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                
                // Introduction Page
                VStack {
                    Spacer()
                    header
                    Spacer()
                    description
                    Spacer()
                    Spacer()
                    buttons
                    Spacer()
                    
                }
            }.navigationBarTitle("Intro", displayMode: .inline)
                .navigationBarHidden(true)
        }
    }
    
    var header: some View {
        Group {
            Image("Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(20)
            
            Text("Welcome to")
                .foregroundColor(Color("DarkGrey"))
                .font(.headline)
                .fontWeight(.regular)
            
            Text("KY Mobile")
                .font(.largeTitle)
        }
    }
    
    var description: some View {
        Text("""
    KY Mobile is your pocket companion for all things KYUEM.  An easy-to-use app that's lite on your pocket that puts information on your fingertips, featuring essential information and tools.

    Student features allow access to essential campus life related information on the fly, including access to student resources, reserving bicycles, find a tutor,  and improved welfare!

    KYUEM Sdn. Bhd. Developers
    """)
            .multilineTextAlignment(.center)
            .font(.system(size: 14))
            .foregroundColor(Color("DarkGrey"))
            .frame(width: UIScreen.main.bounds.size.width * (7/8))
    }
    
    var buttons: some View {
        Group {
            // Sign up page
            NavigationLink(destination: SignUpView(newUser: $newUser), isActive: self.$showingSignUpView) {
                Button("Sign Up") {
                    self.showingSignUpView = true
                }
                .frame(width: UIScreen.main.bounds.size.width * (7/8), height: 50)
                .foregroundColor(Color("White"))
                .background(Color("NormalBlue"))
                .cornerRadius(10)
                .frame(height: 50)
            }
            
            NavigationLink(destination: SignInView(newUser: $newUser), isActive: self.$showingSignInView) {
                // Log in page
                Button("Log In") {
                    self.showingSignInView = true
                }
                .frame(width: UIScreen.main.bounds.size.width * (7/8), height: 50)
                .foregroundColor(Color("White"))
                .background(Color("LightGrey"))
                .cornerRadius(10)
                .frame(height: 60)
            }
        }
    }
}
