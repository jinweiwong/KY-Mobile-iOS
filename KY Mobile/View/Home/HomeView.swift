import Foundation
import SwiftUI

struct HomeView: View {
    
    @ObservedObject var recentPosts = RecentPostsViewModel()
    
    // Date formatter for the header
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    header
                    Spacer()
                    notifications
                    Spacer()
                    TabView {
                        pageOneHomeFunctions
                        pageTwoHomeFunctions
                    }.frame(height: 330)
                    .tabViewStyle(PageTabViewStyle())
                }
            }.navigationBarHidden(true)
        }
    }
    
    var header: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("\(dateFormatter.string(from: Date()))")
                    .foregroundColor(Color("VeryDarkGrey"))
                
                Text("Home")
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .foregroundColor(.black)
            }
            Spacer()
        }.padding(.horizontal)
        .padding(.top)
        .padding(.bottom, 10)
    }
    
    var notifications: some View {
        VStack {
            HStack {
                Image(systemName: "bell")
                    .foregroundColor(Color("Black"))
                
                Text("Notifications")
                    .bold()
                    .modifier(SmallText(textColor: Color("Black")))
                
                Text("| Last 24 hours")
                    .modifier(TinyText(textColor: Color("DarkGrey")))
                Spacer()
            }.padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 6)
            
            if recentPosts.recentPosts.count <= 4 {
                VStack {
                    ScrollView {
                        ForEach(recentPosts.recentPosts, id: \.UUID) { notification in
                            
                            HStack {
                                Text("• \(notification.Title)")
                                    .bold()
                                    .modifier(TinyText(textColor: Color("Black")))
                                
                                Text("| \(EpochTimeToTimeInterval(epochTime: notification.TimeStamp))")
                                    .modifier(TinyText(textColor: Color("DarkGrey")))
                                Spacer()
                            }.padding(.horizontal)
                            .padding(.top, 0.5)
                        }
                        Spacer()
                        Text("No older notifications")
                            .padding(.top, 8)
                            .modifier(TinyText(textColor: Color("NormalGrey")))
                    }
                }.padding(.bottom, 6)
            }
            
            else {
                VStack {
                    ScrollView {
                        ForEach(recentPosts.recentPosts, id: \.UUID) { notification in
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
        }.frame(width: UIScreen.main.bounds.width - 40, height: 180)
        .background(Color("White"))
        .cornerRadius(15)
    }
    
    var pageOneHomeFunctions: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                NavigationLink(destination: RentBicycleView()) {
                    VStack {
                        Image("Bicycle").HomeFunctionsImage()
                        Text("Rent Bicycle").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
                
                NavigationLink(destination: StudentResourcesView()) {
                    VStack {
                        Image("Resources").HomeFunctionsImage()
                        Text("Student Resources").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
                
                NavigationLink(destination: PeerTutoringView()) {
                    VStack {
                        Image("Tutoring").HomeFunctionsImage()
                        Text("Peer Tutoring").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                
                NavigationLink(destination: StudentResourcesView()) {
                    VStack {
                        Image("Student Welfare").HomeFunctionsImage()
                        Text("Your Welfare").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
                
                NavigationLink(destination: DHMenuView()) {
                    VStack {
                        Image("Menu").HomeFunctionsImage()
                        Text("Dining Hall Menu").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
                
                NavigationLink(destination: OperatingHoursView()) {
                    VStack {
                        Image("Operating Hours").HomeFunctionsImage()
                        Text("Operating Hours").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
            }
            Spacer()
            
        }.frame(height: 300)
    }
    
    var pageTwoHomeFunctions: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                NavigationLink(destination: TimetableView()) {
                    VStack {
                        Image("placeholder").HomeFunctionsImage()
                        Text("Timetable").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
                
                NavigationLink(destination: MessageSCView()) {
                    VStack {
                        Image("placeholder").HomeFunctionsImage()
                        Text("Message the SC").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
                
                NavigationLink(destination: LibraryArchiveView()) {
                    VStack {
                        Image("placeholder").HomeFunctionsImage()
                        Text("Library Archive").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                
                NavigationLink(destination: QRLeavingPassView()) {
                    VStack {
                        Image("placeholder").HomeFunctionsImage()
                        Text("QR Code Leaving Pass").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }
                
                Spacer()
                
                NavigationLink(destination: Text("")) {
                    VStack {
                        Image("").HomeFunctionsImage()
                        Text("").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }.disabled(true)
                
                Spacer()
                
                NavigationLink(destination: Text("")) {
                    VStack {
                        Image("").HomeFunctionsImage()
                        Text("").modifier(HomeFunctionsText()).foregroundColor(Color.black)
                        Spacer()
                    }.frame(height: 130)
                }.disabled(true)
                    
                Spacer()
            }
            Spacer()

        }.frame(height: 300)
    }
}

// Image modifier for each student function
extension Image {
    func HomeFunctionsImage() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
    }
}

// Text modifier for each student function name
struct HomeFunctionsText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .frame(width: 90, height: 40, alignment: .top)
            .lineLimit(2)
    }
}


