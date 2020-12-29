import Foundation
import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var currentUser = CurrentUserInfo()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ProfileCardView(user: currentUser.currentUser)
                    form
                }

            }.navigationBarTitle(Text("Profile"))
        }
    }
    
    var form: some View {
        Form {
            
            Section() {
                NavigationLink(destination: Text("Feedback")) {
                    Label {
                        Text("Feedback")
                    } icon: {
                        Image(systemName: "message.circle")
                            .renderingMode(.original)
                    }
                }
            }
            
            Section() {
                NavigationLink(destination: Text("Change Password")) {
                    Label {
                        Text("Change Password")
                    } icon: {
                        Image(systemName: "lock")
                            .renderingMode(.original)
                    }
                }
                
                HStack {
                    Button("Logout") {
                        FBAuthFunctions.logout { (result) in
                        }}
                }
            }
        }
    }
}

struct ProfileCardView: View {

    let user: User
    let cardWidth: CGFloat = UIScreen.main.bounds.width - 40

    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: self.cardWidth, height: 125)
                .cornerRadius(15)
                .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                        , radius: 2 , x: -1, y: 1)

            HStack (spacing: 12) {
                UserCardImage(url: user.Image)
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

                Text("\(user.Name)")
                    .lineLimit(2)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(Color("Black"))

            }
            Spacer()
        }
    }

    var shortDesc: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(user.Email)
                    .lineLimit(2)
                    .font(.system(size: 12))
                    .foregroundColor(Color("DarkGrey"))

            }
            Spacer()
        }
    }

    var timeStamp: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(user.StudentID)
                    .font(.system(size: 12, design: .default))
                    .foregroundColor(Color("NormalBlue"))

            }
            Spacer()
        }
    }
}


struct UserCardImage: View {
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
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(10)
                .padding(.leading, 15)
                .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                        , radius: 1 , x: -1, y: 1)
        } else {
            return Image("placeholder")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(10)
                .padding(.leading, 15)
                .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                        , radius: 1 , x: -1, y: 1)
        }
    }
}
