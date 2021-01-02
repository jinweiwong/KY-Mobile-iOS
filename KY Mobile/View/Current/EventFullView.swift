import Foundation
import SwiftUI

struct EventFullView: View {

    let thisEvent: Event
    let demoCardImage: UIImage

    var body: some View {
        ZStack {
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack {
                    Group {
                        if demoCardImage != UIImage() {
                            Image(uiImage: demoCardImage).EventFullImage()
                        } else if thisEvent.Cover != "" {
                            EventPageImage(url: thisEvent.Cover)
                        }
                    }

                    title
                    shortDesc
                    timeStamp
                    divider
                    fullDesc
                        //.padding(.bottom, 50)
                }
            }//.offset(y: -50)
        }//.padding(.bottom)
        .edgesIgnoringSafeArea(.horizontal)
    }

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

    var shortDesc: some View {
        HStack {
            Text("\(thisEvent.ShortDesc)")
                .modifier(SmallText(textColor: Color("Black")))
            Spacer()
        }.padding(.horizontal)
    }

    var timeStamp: some View {
        HStack {
            Text("\(EpochTimeToTimeInterval(epochTime: thisEvent.TimeStamp))")
                .font(.body)
                .foregroundColor(Color("NormalBlue"))

            Spacer()
        }.padding(.horizontal)
        .padding(.top, 1)
    }

    var divider: some View {
        HStack (spacing: 15) {
            VStack { Divider()
                .background(Color("DarkGrey"))
            }.padding(0)
        }.padding(.horizontal, 20)
    }

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


extension Image {
    func EventFullImage() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(maxHeight: UIScreen.main.bounds.height / 3)
            .cornerRadius(5)
   }
}
