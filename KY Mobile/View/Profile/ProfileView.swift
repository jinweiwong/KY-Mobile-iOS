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
