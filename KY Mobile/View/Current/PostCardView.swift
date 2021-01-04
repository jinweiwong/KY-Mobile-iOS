import Foundation
import SwiftUI

struct PostCardView: View {
    
    let thisPost: Post
    
    // Assists in displaying the image selected by an admin creating a new post as that image has yet to be uploaded the Firebase Storage
    // Should be set to UIImage() if it is called from CurrentView
    // Should be set the image to be uploaded if it is called from NewPostView
    let demoCardImage: UIImage
    
    let cardWidth: CGFloat = UIScreen.main.bounds.width - 40
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: self.cardWidth, height: 120)
                .cornerRadius(15)
                .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1),
                        radius: 1 , x: -1, y: 0)
            
            HStack (spacing: 12) {
                
                Group {
                    if demoCardImage != UIImage() {
                        Image(uiImage: demoCardImage).PostCardImage()
                    } else {
                        PostCardImage(url: thisPost.Cover)
                    }
                }
                
                VStack (spacing: 8) {
                    title
                    shortDesc
                    timeStamp
                }.frame(width: self.cardWidth - 120)
            }.cornerRadius(15)
            .foregroundColor(.white)
        }
    }
    
    var title: some View {
        HStack {
            VStack(alignment: .leading){
                
                Text("\(thisPost.Title)")
                    .lineLimit(2)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(Color("Black"))
                
            }
            Spacer()
        }
    }
    
    // MARK: Short Description
    
    var shortDesc: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("\(thisPost.ShortDesc)")
                    .lineLimit(2)
                    .font(.system(size: 12))
                    .foregroundColor(Color("DarkGrey"))
                
            }
            Spacer()
        }
    }
    
    // MARK: Time Stamp
    
    var timeStamp: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("\(EpochTimeToTimeInterval(epochTime: thisPost.TimeStamp))")
                    .font(.system(size: 12, design: .default))
                    .foregroundColor(Color("NormalBlue"))
                
            }
            Spacer()
        }
    }
}

// Fetches the image for the card from a URL
struct PostCardImage: View {
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
            return Image(uiImage: UIImage(data: data)!).PostCardImage()
        } else {
            return Image("placeholder").PostCardImage()
        }
    }
}

// Modifier for the post card image
extension Image {
    func PostCardImage() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(10)
            .padding(.leading, 15)
    }
}
