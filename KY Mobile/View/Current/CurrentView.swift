import Foundation
import SwiftUI

struct CurrentView: View {
    @ObservedObject var events = EventsViewModel()
    
    // Variable that stores all the information of the new event to be posted
    @State var newEvent: NewEvent = NewEvent()
    @State var isShowingSheet: Bool = false
    
    // Switches on the "Create New Event" sheet
    @State private var boolAllDay: Bool = false
    @State private var boolStart: Bool = false
    @State private var boolEnd: Bool = false
    @State private var boolTimeStamp: Bool = false
    
    // Measurements of the event card
    let cardHeight: CGFloat = 125
    let cardWidth = UIScreen.main.bounds.width - 40
    
    // Date formatter for the header
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter
    }
    
    @State private var errorMessage: String = "Unknown Error"
    @State private var showErrorMessage = false
   
    var body: some View {
        // Header
        NavigationView {
            ZStack{
                // Background
                Color("VeryLightGrey")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    header
                    
                    // Event feed
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                        eventFeed
                    }
                }
            }.navigationBarHidden(true)
            // New Event Sheet
            .sheet(isPresented: $isShowingSheet,
                   content: {
                    NewEventView(isPresented: $isShowingSheet,
                                 newEvent: $newEvent,
                                 boolAllDay: $boolAllDay,
                                 boolStart: $boolStart,
                                 boolEnd: $boolEnd,
                                 boolTimeStamp: $boolTimeStamp,
                                 errorMessage: $errorMessage,
                                 showErrorMessage: $showErrorMessage)})
            
            .alert(isPresented: self.$showErrorMessage) {
                Alert(title: Text("Error"),
                      message: Text(self.errorMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    var header: some View {
        HStack{
            VStack (alignment: .leading) {
                // Today's date
                Text("\(dateFormatter.string(from: Date()))")
                    .foregroundColor(Color("VeryDarkGrey"))
                
                // "Today"
                Text("Today")
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .foregroundColor(.black)
            }
            Spacer()
            
            // Create new event button
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
        .padding(.bottom, 10)
    }
    
    
    var eventFeed: some View {
        ForEach(events.events, id: \.id) { thisEvent in
            // NavigationLink to the full event page
            NavigationLink(destination: EventFullView(thisEvent: thisEvent,
                                                      demoCardImage: UIImage())) {
                // Event card
                EventCardView(thisEvent: thisEvent,
                              demoCardImage: UIImage())
                    .frame(height: 120)
                    .padding(.horizontal, 5)
            }
        }
    }  
}
