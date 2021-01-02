import Foundation
import SwiftUI

struct HomeView: View {
    
    @ObservedObject var recentPosts = RecentPostsViewModel()
    
    let currentDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM"
        return formatter
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarTitle(Text("Home"))
                    .navigationBarItems(leading: Text("\(dateFormatter.string(from: currentDate))").foregroundColor(Color("DarkGrey")))
                
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "bell")
                                .foregroundColor(Color("NormalBlue"))
                            
                            Text("Notifications")
                                .bold()
                                .modifier(SmallText(textColor: Color("NormalBlue")))
                            
                            Text("| Last 24 hours")
                                .modifier(TinyText(textColor: Color("LightBlue")))
                            Spacer()
                        }.padding(.horizontal)
                        .padding(.top, 10)
                        .padding(.bottom, 6)
                        
                        if recentPosts.recentPosts.count <= 4 {
                            VStack {
                                ForEach(recentPosts.recentPosts, id: \.id) { notification in
                                    
                                    HStack {
                                        Text("• \(notification.Title)")
                                            .modifier(TinyText(textColor: Color("Black")))
                                        
                                        Text("| \(EpochTimeToTimeInterval(epochTime: notification.TimeStamp))")
                                            .modifier(TinyText(textColor: Color("DarkGrey")))
                                        Spacer()
                                    }.padding(.horizontal)
                                    .padding(.top, 0.5)
                                    
                                }
                                
                                Spacer()
                                
                                Text("No older notifications")
                                    .modifier(TinyText(textColor: Color("NormalGrey")))
                                
                                Spacer()
                                
                            }.padding(.bottom, 6)
                        }
                        
                        else {
                            VStack {
                                ScrollView {
                                    ForEach(recentPosts.recentPosts, id: \.id) { notification in
                                        
                                        HStack {
                                            Text("• \(notification.Title)")
                                                .modifier(TinyText(textColor: Color("Black")))
                                            
                                            Text("| \(EpochTimeToTimeInterval(epochTime: notification.TimeStamp))")
                                                .modifier(TinyText(textColor: Color("DarkGrey")))
                                            Spacer()
                                        }.padding(.horizontal)
                                        .padding(.top, 0.5)
                                        
                                    }
                                }
                            }.padding(.bottom, 10)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                    .background(Color("White"))
                    .cornerRadius(15)
                    
                    Spacer()
                }.padding()
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

