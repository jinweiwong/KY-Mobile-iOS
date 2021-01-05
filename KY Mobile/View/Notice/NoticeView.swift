import Foundation
import SwiftUI

struct NoticeView: View {
    @ObservedObject var notices = NoticesViewModel()
    @State var newNotice: NewNotice = NewNotice()
    
    @State var isShowingSheet: Bool = false
    @State var boolTimeStamp: Bool = false
    
    // Date formatter for the header
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter
    }
    
    @State private var errorMessage: String = "Unknown Error"
    @State private var showErrorMessage = false
    
//    @State var TimePeriodBefore: String = ""
    
    var body: some View {
        ZStack{
            // Background
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                header
                
                // Notice feed
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                    noticeFeed
                }
            }
        }
        // New post sheet
        .sheet(isPresented: $isShowingSheet,
               content: { NewNoticeView(isPresented: $isShowingSheet,
                                         newNotice: $newNotice,
                                         boolTimeStamp: $boolTimeStamp,
                                         errorMessage: $errorMessage,
                                         showErrorMessage: $showErrorMessage) })
        
        .alert(isPresented: self.$showErrorMessage) {
            Alert(title: Text("Error"),
                  message: Text(self.errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: Header
    
    var header: some View {
        HStack{
            VStack (alignment: .leading) {
                // Today's date
                Text("\(dateFormatter.string(from: Date()))")
                    .foregroundColor(Color("VeryDarkGrey"))
                
                // "Today"
                Text("Student Council")
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .foregroundColor(.black)
            }
            Spacer()
            
            // Create new post button
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
    
    // MARK: Notice Feed
    
    var noticeFeed: some View {
        ForEach(notices.notices, id: \.UUID) { thisNotice in
        
            NoticeCardView(thisNotice: thisNotice)
        }
    }
}





//            if TimePeriodBefore != EpochTimePeriod(epochTime: thisNotice.TimeStamp) {
//
//                HStack (spacing: 15) {
//
//                    VStack { Divider()
//                        .background(Color("DarkGrey"))
//                    }.padding(0)
//
//                    Text("\(ChangeTimePeriodBefore(epochTime: thisNotice.TimeStamp, TimePeriodBefore: &TimePeriodBefore))")
//                        .foregroundColor(Color("DarkGrey"))
//
//                    VStack { Divider()
//                        .background(Color("DarkGrey"))
//                    }.padding(0)
//
//                }.padding(.horizontal, 25)
//            }




//func ChangeTimePeriodBefore(epochTime: String, TimePeriodBefore: inout String) -> String {
//    TimePeriodBefore = EpochTimePeriod(epochTime: epochTime)
//    return EpochTimePeriod(epochTime: epochTime)
//}
//
//func EpochTimePeriod(epochTime: String) -> String {
//    let pastDate = Date(timeIntervalSince1970: Double((Double(epochTime)! / 1000)))
//    let currentDate = Date()
//
//    let dateDifference = Calendar.current.dateComponents(
//        [Calendar.Component.year,
//         Calendar.Component.month,
//         Calendar.Component.day],
//        from: pastDate, to: currentDate)
//
//    if dateDifference.year! > 0 {
//        if dateDifference.year! > 1 {
//            return "\(Calendar.Component.year) years ago"
//        }
//
//        else {
//            return "Last year"
//        }
//    }
//
//    else if dateDifference.month! > 0 {
//        if dateDifference.month! > 1 {
//            return "This year"
//        }
//
//        else {
//            return "Last month"
//        }
//    }
//
//    else if dateDifference.day! > 0 {
//        if dateDifference.day! == 1 {
//            return "Yesterday"
//        }
//        else if dateDifference.day! < 7 {
//            return "This week"
//        }
//
//        else if dateDifference.day! / 7 == 1 {
//            return "Last week"
//        }
//
//        else {
//            return "This month"
//        }
//    }
//
//    else {
//        return "Today"
//    }
//}
