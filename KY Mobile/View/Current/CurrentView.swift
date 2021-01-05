import Foundation
import SwiftUI

struct CurrentView: View {
    @ObservedObject var posts = PostsViewModel()
    
    // Variable that stores all the information of the new post to be posted
    @State var newPost: NewPost = NewPost()
    @State var isShowingNewPostSheet: Bool = false
    
    // Switches on the "Create New Post" sheet
    @State private var boolAllDay: Bool = false
    @State private var boolStart: Bool = false
    @State private var boolEnd: Bool = false
    @State private var boolTimeStamp: Bool = false
    
    // Measurements of the post card
    let cardHeight: CGFloat = 125
    let cardWidth = UIScreen.main.bounds.width - 40
    
    // Date formatter for the header
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter
    }
    
    @State private var errorMessage: String = "Unknown Error"
    @State private var showErrorMessage = false
   
    var body: some View {
        // Header
        NavigationView {
            ZStack{
                // Background
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    header
                    postFeed
                }
            }.navigationBarHidden(true)
            .alert(isPresented: self.$showErrorMessage) {
                Alert(title: Text("Error"),
                      message: Text(self.errorMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    var header: some View {
        HStack{
            VStack (alignment: .leading) {
                // Today's date
                Text("\(dateFormatter.string(from: Date()))")
                    .foregroundColor(Color("VeryDarkGrey"))
                
                // "Today"
                Text("Today")
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .foregroundColor(.black)
            }
            Spacer()
            
            // Create new post button
            Button(action: {
                isShowingNewPostSheet = true
            }) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 24, height: 24)
            }// New Post Sheet
            .sheet(isPresented: $isShowingNewPostSheet,
                   content: {
                    NewPostView(isPresented: $isShowingNewPostSheet,
                                 newPost: $newPost,
                                 boolAllDay: $boolAllDay,
                                 boolStart: $boolStart,
                                 boolEnd: $boolEnd,
                                 boolTimeStamp: $boolTimeStamp,
                                 errorMessage: $errorMessage,
                                 showErrorMessage: $showErrorMessage)})
        }.padding(.leading)
        .padding(.top)
        .padding(.trailing)
        .padding(.bottom, 10)
    }
    
    
    var postFeed: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
            ForEach(posts.posts, id: \.UUID) { thisPost in
                // NavigationLink to the full post page
                NavigationLink(destination:
                                PostFullView(thisPost: thisPost,
                                             unEditedPost: thisPost.postToNewPost(),
                                             demoCardImage: UIImage(),
                                             viewingType: .view)) {
                    // Post card
                    PostCardView(thisPost: thisPost,
                                 demoCardImage: UIImage())
                        .frame(height: 120)
                        .padding(.horizontal, 5)
                }
            }
        }
    }
}
