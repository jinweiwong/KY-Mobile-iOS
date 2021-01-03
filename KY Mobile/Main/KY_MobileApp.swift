import SwiftUI
import Firebase

@main
struct KY_MobileApp: App {
    
    var currentUserInfo = CurrentUserInfo()
    
    init() {
        // Connect the app to Firebase when the app is opened
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            // Allow currentUserInfo to be accessible throughout the entire app
            ViewController().environmentObject(currentUserInfo)
        }
    }
}
