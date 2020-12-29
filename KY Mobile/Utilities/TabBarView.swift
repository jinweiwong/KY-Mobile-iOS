import Foundation
import SwiftUI

struct ContentView: View {
    @State private var currentTab = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("VeryDarkGrey"))
            TabBarView(currentTab: $currentTab)
        }
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color("White"))
                HStack {
                    
                    home
                    current
                    notice
                    profile
                    
                }.frame(width: UIScreen.main.bounds.width, height: 60)
                .padding(.top, 4)
                .animation(.spring())
            }.frame(width: UIScreen.main.bounds.width, height: 60)
        }.edgesIgnoringSafeArea(.leading)
        .edgesIgnoringSafeArea(.trailing)
    }
    
    
    var home: some View {
        HStack {
            Image(systemName: "house")
                .TabBarIcon()
                .foregroundColor(currentTab == 0 ? Color("NormalBlue") : Color("DarkGrey"))
            
            Text(self.currentTab == 0 ? "Home" : "")
                .foregroundColor(Color("NormalBlue"))
            
        }.padding(self.currentTab == 0 ? 20 : 15)
        .background(self.currentTab == 0 ? Color("VeryLightBlue") : Color.clear)
        .frame(height: 50)
        .clipShape(Capsule())
        .onTapGesture {
            self.currentTab = 0
        }
    }
    
    
    var current: some View {
        HStack {
            Image(systemName: "calendar")
                .TabBarIcon()
                .foregroundColor(currentTab == 1 ? Color("NormalBlue") : Color("DarkGrey"))
            
            Text(self.currentTab == 1 ? "Current" : "")
                .foregroundColor(Color("NormalBlue"))
            
        }.padding(self.currentTab == 1 ? 20 : 15)
        .background(self.currentTab == 1 ? Color("VeryLightBlue") : Color.clear)
        .frame(height: 50)
        .clipShape(Capsule())
        .onTapGesture {
            self.currentTab = 1
        }
    }
    
    
    var notice: some View {
        HStack {
            Image(systemName: "bell")
                .TabBarIcon()
                .foregroundColor(currentTab == 2 ? Color("NormalBlue") : Color("DarkGrey"))
            
            Text(self.currentTab == 2 ? "Notices" : "")
                .foregroundColor(Color("NormalBlue"))
            
        }.padding(self.currentTab == 2 ? 10 : 15)
        .background(self.currentTab == 2 ? Color("VeryLightBlue") : Color.clear)
        .frame(height: 50)
        .clipShape(Capsule())
        .onTapGesture {
            self.currentTab = 2
        }
    }
    
    
    var profile: some View {
        HStack {
            Image(systemName: "person")
                .TabBarIcon()
                .foregroundColor(currentTab == 3 ? Color("NormalBlue") : Color("DarkGrey"))
            
            Text(self.currentTab == 3 ? "Profile" : "")
                .foregroundColor(Color("NormalBlue"))
                .frame(width: 50)
            
        }.frame(width: self.currentTab == 3 ? 100 : 80)
        .frame(height: 50)
        .background(self.currentTab == 3 ? Color("VeryLightBlue") : Color.clear)
        .clipShape(Capsule())
        .onTapGesture {
            self.currentTab = 3
        }
    }
}


extension Image {
    func TabBarIcon() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 22)
    }
}


struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
