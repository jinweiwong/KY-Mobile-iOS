import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct CurrentView: View {
    @EnvironmentObject var currentUserInfo: CurrentUserInfo
    @ObservedObject var events = CurrentViewModel()
    
    let cardHeight: CGFloat = 125
    let cardWidth = UIScreen.main.bounds.width - 40
    
    let currentDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM"
        return formatter
    }
    
    @State private var errorMessage: String = "Unknown Error"
    @State private var showErrorMessage = false
    
    @State var newEvent: Event = Event()
    @State var isShowingSheet: Bool = false
    
    
    var body: some View {
        //Header
        NavigationView {
            ZStack{
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    header
                    eventFeed
                    
                }.sheet(isPresented: $isShowingSheet,
                        content: {
                            NewEventSheet(isPresented: $isShowingSheet,
                                          newEvent: $newEvent,
                                          errorMessage: $errorMessage,
                                          showErrorMessage: $showErrorMessage)})
            }.navigationBarHidden(true)
        }
    }
    
    
    var header: some View {
        HStack{
            VStack (alignment: .leading) {
                Text("\(dateFormatter.string(from: currentDate))")
                    .foregroundColor(Color("VeryDarkGrey"))
                
                Text("Today")
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .foregroundColor(.black)
            }
            Spacer()
            
            Button(action: {
                isShowingSheet = true
            }) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }.padding(.leading)
        .padding(.top)
        .padding(.trailing)
    }
    
    
    var eventFeed: some View {
        ForEach(events.events, id: \.id) { thisEvent in
            NavigationLink(destination: EventFullView(thisEvent: thisEvent)) {
                EventCardView(thisEvent: thisEvent)
                    .frame(height: 125)
                    .padding(.leading, 16)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
            }
        }
    }  
}


struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
    }
}

