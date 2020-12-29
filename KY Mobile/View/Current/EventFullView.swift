import Foundation
import SwiftUI
import FirebaseStorage

struct EventFullView: View {
    
    let thisEvent: Event
    
    var body: some View {
        ZStack {
            Color("VeryLightGrey")
            
            ScrollView {
                VStack {
                    EventPageImage(url: thisEvent.Cover)
                    title
                    shortDesc
                    start
                    end
                    timeStamp
                    divider
                    fullDesc
                }.padding(.bottom, 100)
            }
        }.padding(.bottom)
        .edgesIgnoringSafeArea(.all)
        
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
                .modifier(MediumText(textColor: Color("Black")))
            Spacer()
        }.padding(.horizontal)
        .padding(.vertical, 1)
    }
    
    var start: some View {
        HStack {
            VStack {
                Text("Start: \(DateTimeStringToDayDateTime(date: thisEvent.StartDate, time: thisEvent.StartTime))")
                    .lineLimit(1)
                    .font(.system(size: 14))
                    .foregroundColor(Color("VeryDarkGrey"))
            }
            Spacer()
        }.padding(.horizontal)
        .padding(.vertical, 1)
    }
    
    var end: some View {
        HStack {
            VStack {
                Text("End:   \(DateTimeStringToDayDateTime(date: thisEvent.EndDate, time: thisEvent.EndTime))")
                    .lineLimit(1)
                    .font(.system(size: 14))
                    .foregroundColor(Color("VeryDarkGrey"))
            }
            Spacer()
        }.padding(.horizontal)
        .padding(.top, -5)
        .padding(.bottom, 1)
    }
    
    var timeStamp: some View {
        HStack {
            Text("\(EpochTimeToTimeInterval(epochTime: thisEvent.TimeStamp))")
                .font(.body)
                .foregroundColor(Color("NormalBlue"))
            
            Spacer()
        }.padding(.horizontal)
        .padding(.vertical, 1)
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
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: UIScreen.main.bounds.height / 3)
                .cornerRadius(0)
        } else {
            return Image("placeholder")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: UIScreen.main.bounds.height / 3)
                .cornerRadius(0)
        }
    }
}
