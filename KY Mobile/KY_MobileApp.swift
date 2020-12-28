import SwiftUI
import Firebase

@main
struct KY_MobileApp: App {
    
    var currentUserInfo = CurrentUserInfo()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ViewController().environmentObject(currentUserInfo)
        }
    }
}
