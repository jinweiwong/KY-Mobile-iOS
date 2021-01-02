import Foundation
import SwiftUI

struct CurrentView: View {
    @ObservedObject var events = CurrentViewModel()
    
    @State var newEvent: NewEvent = NewEvent()
    @State var isShowingSheet: Bool = false
    
    let cardHeight: CGFloat = 125
    let cardWidth = UIScreen.main.bounds.width - 40
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM"
        return formatter
    }
    
    @State private var errorMessage: String = "Unknown Error"
    @State private var showErrorMessage = false
    
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
                
                .alert(isPresented: self.$showErrorMessage) {
                    Alert(title: Text("Error"),
                          message: Text(self.errorMessage),
                          dismissButton: .default(Text("OK")))
                }
            }.navigationBarHidden(true)
        }
    }
    
    
    var header: some View {
        HStack{
            VStack (alignment: .leading) {
                Text("\(dateFormatter.string(from: Date()))")
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
            NavigationLink(destination: EventFullView(thisEvent: thisEvent,
                                                      demoCardImage: UIImage())) {
                EventCardView(thisEvent: thisEvent,
                              demoCardImage: UIImage())
                    .frame(height: 120)
                    .padding(.leading, 16)
                    .padding(.trailing, 10)
                    .padding(.bottom, 5)
            }
        }
    }  
}


struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
    }
}

