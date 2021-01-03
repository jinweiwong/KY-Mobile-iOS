import Foundation
import SwiftUI

struct EventFullView: View {

    let thisEvent: Event
    
    // Assists in displaying the image selected by an admin creating a new event as that image has yet to be uploaded the Firebase Storage
    // Should be set to UIImage() if it is called from CurrentView
    // Should be set the image to be uploaded if it is called from NewEventView
    let demoCardImage: UIImage

    var body: some View {
        ZStack {
            // Background
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack {
                    Group {
                        // Displays the image selected in the new event sheet
                        if demoCardImage != UIImage() {
                            Image(uiImage: demoCardImage).EventFullImage()
                            
                        } // Displays the image from the image's URL
                        else if thisEvent.Cover != "" {
                            EventPageImage(url: thisEvent.Cover)
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
            Text("\(thisEvent.Title)")
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
            Text("\(thisEvent.ShortDesc)")
                .modifier(SmallText(textColor: Color("Black")))
            Spacer()
        }.padding(.horizontal)
    }

    // MARK: Time Stamp
    
    var timeStamp: some View {
        HStack {
            Text("\(EpochTimeToTimeInterval(epochTime: thisEvent.TimeStamp))")
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
                Text("\(thisEvent.FullDesc)")
                    .font(.body)
                    .foregroundColor(Color("VeryDarkGrey"))
                    .padding()
            }
            Spacer()
        }
    }
}

// Retrieves the image for EventFullView from a URL
struct EventPageImage: View {
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
            return Image(uiImage: UIImage(data: data)!).EventFullImage()
        } else {
            return Image("placeholder").EventFullImage()
        }
    }
}

// Modifier for the image in the EventFullView
extension Image {
    func EventFullImage() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(maxHeight: UIScreen.main.bounds.height / 3)
            .cornerRadius(5)
   }
}
