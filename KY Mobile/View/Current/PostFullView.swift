import Foundation
import SwiftUI

struct PostFullView: View {

    let thisPost: Post
    
    // Assists in displaying the image selected by an admin creating a new post as that image has yet to be uploaded the Firebase Storage
    // Should be set to UIImage() if it is called from CurrentView
    // Should be set the image to be uploaded if it is called from NewPostView
    let demoCardImage: UIImage

    var body: some View {
        ZStack {
            // Background
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack {
                    Group {
                        // Displays the image selected in the new post sheet
                        if demoCardImage != UIImage() {
                            Image(uiImage: demoCardImage).PostFullImage()
                            
                        } // Displays the image from the image's URL
                        else if thisPost.Cover != "" {
                            PostPageImage(url: thisPost.Cover)
                        }
                    }

                    title
                    shortDesc
                    timeStamp
                    divider
                    fullDesc
                        
                }
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
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
struct PostPageImage: View {
    @ObservedObject var imageLoader = ImageLoaderViewModel()
    let url: String
    let placeholder: String

    init(url: String, placeholder: String = "placeholder") {
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.downloadImage(url: self.url)
    }

    var body: some View {
        if let data = self.imageLoader.downloadedData {
            return Image(uiImage: UIImage(data: data)!).PostFullImage()
        } else {
            return Image("placeholder").PostFullImage()
        }
    }
}

// Modifier for the image in the PostFullView
extension Image {
    func PostFullImage() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(maxHeight: UIScreen.main.bounds.height / 3)
            .cornerRadius(5)
   }
}
