import SwiftUI
import Firebase

@main
struct KY_MobileApp: App {
    
    var currentUser: CurrentUserViewModel
    var posts: PostsViewModel
    
    init() {
        // Connect the app to Firebase when the app is opened
        FirebaseApp.configure()
        self.currentUser = CurrentUserViewModel()
        self.posts = PostsViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            // Allow currentUserInfo to be accessible throughout the entire app
            ViewController()
                .environmentObject(currentUser)
                .environmentObject(posts)
        }
    }
}
