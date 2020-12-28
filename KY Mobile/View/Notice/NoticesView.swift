import Foundation
import SwiftUI

struct NoticesView: View {
    @EnvironmentObject var currentUserInfo: CurrentUserInfo
    @ObservedObject var notices = NoticesViewModel()
    
    @State var isShowingSheet: Bool = false
    @State var newNotice = Notice()
    
    
    //@State var TimePeriodBefore: String = ""
    
    var body: some View {
        //Header
        ZStack{
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                HStack{
                    VStack (alignment: .leading) {
                        
                        Text("Student Council")
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
                .padding(.bottom, 10)
                .padding(.trailing, 30)
                
                //ForEach_start
                
                ForEach(notices.notices, id: \.id) { thisNotice in
                    
                    //                    if TimePeriodBefore != EpochTimePeriod(epochTime: thisNotice.TimeStamp) {
                    //
                    //                        HStack (spacing: 15) {
                    //
                    //                            VStack { Divider()
                    //                                .background(Color("DarkGrey"))
                    //                            }.padding(0)
                    //
                    //                            Text("\(ChangeTimePeriodBefore(epochTime: thisNotice.TimeStamp, TimePeriodBefore: &TimePeriodBefore))")
                    //                                .foregroundColor(Color("DarkGrey"))
                    //
                    //                            VStack { Divider()
                    //                                .background(Color("DarkGrey"))
                    //                            }.padding(0)
                    //
                    //                        }.padding(.horizontal, 25)
                    //                    }
                    
                    ZStack {
                        NoticeCardView(thisNotice: thisNotice)
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                    
                }
            }
        }
        .animation(.easeIn)
        .sheet(isPresented: $isShowingSheet,
                content: {
                    NewNoticeSheet(isPresented: $isShowingSheet,
                                   newNotice: $newNotice)
                })
    }
}

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


struct NoticesView_Previews: PreviewProvider {
    static var previews: some View {
        NoticesView()
    }
}
