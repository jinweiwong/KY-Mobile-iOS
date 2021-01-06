import Foundation
import SwiftUI

struct PostFullView: View {
    
    @EnvironmentObject var imageArchive: ImageArchive
    
    let thisPost: Post
    
    // Created for Editing Post purposes
    let unEditedPost: NewPost
    @State var editedPost: NewPost = NewPost()
    
    // Assists in displaying the image in the demo full view as that image has yet to be uploaded the Firebase Storage
    // Should be set to UIImage() if it is called from CurrentView
    // Should be set to the image to be uploaded if it is used to demo
    let demoCardImage: UIImage
    
    // Makes sure the cover image is only downloaded from the URL once
    enum editPostConfigurationStatus {
        case pending, configured }
    @State var editPostConfigurationStatus: editPostConfigurationStatus = .pending
    
    enum ViewingType {
        case demo, view }
    var viewingType: ViewingType
    
    // All these boolean values are set momentarily only
    // They will be changed when the "Edit" button is pressed
    @State var boolStart: Bool = false
    @State var boolEnd: Bool = false
    @State var boolAllDay: Bool = false
    @State var boolTimeStamp: Bool = true
    
    @State var isShowingEditPostSheet: Bool = false
    
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    
    init(thisPost: Post, demoCardImage: UIImage? = UIImage(), viewingType: ViewingType) {
        self.thisPost = thisPost
        self.unEditedPost = thisPost.postToNewPost()
        self.demoCardImage = demoCardImage!
        self.viewingType = viewingType
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Group {
                            // Displays the image selected in the new post sheet
                            if demoCardImage != UIImage() {
                                UIImageToImage(uiImage: demoCardImage).PostFullImage()
                                
                            } // Displays the image from the image's URL
                            else if thisPost.Cover != "" {
                                UIImageToImage(uiImage: imageArchive.searchArchive(id: thisPost.UUID, url: thisPost.Cover)).PostFullImage()
                            }
                        }
                        
                        title
                        shortDesc
                        
                        HStack {
                            timeStamp
                            Spacer()
                            buttons
                        }
                        
                        divider
                        fullDesc
                        
                    }.offset(y: -50)
                }.navigationBarHidden(true)
                .sheet(isPresented: $isShowingEditPostSheet,
                       content: {
                        EditPostView(isPresented: $isShowingEditPostSheet,
                                     unEditedPost: unEditedPost,
                                     editedPost: $editedPost,
                                     boolAllDay: $boolAllDay,
                                     boolStart: $boolStart,
                                     boolEnd: $boolEnd,
                                     boolTimeStamp: $boolTimeStamp,
                                     errorMessage: $errorMessage,
                                     showErrorMessage: $showErrorMessage)})
            }.onAppear(perform: {
                editedPost = unEditedPost
            })
        }
    }
    
    
    // MARK: Title
    
    var title: some View {
        HStack {
            Text("\(thisPost.Title)")
                .bold()
                .modifier(LargeText(textColor: Color("Black")))
                .lineLimit(2)
            Spacer()
        }.padding(.horizontal)
        .padding(.vertical, 2)
    }
    
    // MARK: Short Description
    
    var shortDesc: some View {
        HStack {
            Text("\(thisPost.ShortDesc)")
                .modifier(SmallText(textColor: Color("Black")))
            Spacer()
        }.padding(.horizontal)
    }
    
    // MARK: Time Stamp
    
    var timeStamp: some View {
        HStack {
            Text("\(EpochTimeToTimeInterval(epochTime: thisPost.TimeStamp))")
                .font(.body)
                .foregroundColor(Color("NormalBlue"))
            
            Spacer()
        }.padding(.horizontal)
        .padding(.top, 1)
    }
    
    // MARK: Buttons
    
    var buttons: some View {
        HStack {
            Group {
                if viewingType == .view {
                    Button(action: {
                        // Makes sure the cover image is only downloaded from the URL once
                        if (self.editPostConfigurationStatus == .pending) {
                            boolStart = (thisPost.StartDate != "")
                            boolEnd = (thisPost.EndDate != "")
                            boolAllDay = ((thisPost.StartTime == "") && (thisPost.EndTime == ""))
                            editedPost.Cover = imageArchive.searchArchive(id: unEditedPost.UUID, url: unEditedPost.CoverString)
                            self.editPostConfigurationStatus = .configured
                        }
                        isShowingEditPostSheet = true
                    }) {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    }
                }
            }
            
            Button(action: {
                print("Saving post...")
            }) {
                Image(systemName: "bookmark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 28)
            }.padding(.leading, 15)
        }.padding(.trailing, 20)
    }
    
    // MARK: Divider
    
    var divider: some View {
        HStack (spacing: 15) {
            VStack { Divider()
                .background(Color("DarkGrey"))
            }.padding(0)
        }.padding(.horizontal, 20)
    }
    
    // MARK: Full Description
    
    var fullDesc: some View {
        HStack {
            VStack {
                Text("\(thisPost.FullDesc)")
                    .font(.body)
                    .foregroundColor(Color("VeryDarkGrey"))
                    .padding()
            }
            Spacer()
        }
    }
}

// Retrieves the image for PostFullView from a URL
//struct PostPageImage: View {
//    @ObservedObject var imageLoader = ImageLoaderViewModel()
//    let url: String
//    let placeholder: String
//
//    init(url: String, placeholder: String = "placeholder") {
//        self.url = url
//        self.placeholder = placeholder
//        self.imageLoader.downloadImage(url: self.url)
//    }
//
//    var body: some View {
//        if let data = self.imageLoader.downloadedData {
//            return Image(uiImage: UIImage(data: data) ?? UIImage()).PostFullImage()
//        } else {
//            return Image("placeholder").PostFullImage()
//        }
//    }
//}

// Modifier for the image in the PostFullView
extension Image {
    func PostFullImage() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(maxHeight: (UIScreen.main.bounds.height / 3))
            .cornerRadius(5)
            
   }
}
