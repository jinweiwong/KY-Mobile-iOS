//
//  NoticesElements.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 22/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import SwiftUI
import SwiftUI
import FirebaseStorage

struct NoticeCardView: View {
    
    let thisNotice: Notice
    let cardWidth: CGFloat = UIScreen.main.bounds.width - 80
    @State var displayFullCard: Bool = false
    
    var body: some View {
        VStack (spacing: 8) {
            HStack {
                VStack(alignment: .leading){
                    
                    Text("\(thisNotice.Title)")
                        .lineLimit(2)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(Color("Black"))
                    
                }
                Spacer()
            }
            
            HStack (spacing: 6) {
                VStack (alignment: .leading) {
                    Image("\(thisNotice.Exco)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                
                if thisNotice.Exco == "" {
                    VStack (alignment: .leading) {
                        Text("")
                            .lineLimit(1)
                            .font(.system(size: 12))
                            .foregroundColor(Color("Black"))
                    }
                }
                else if thisNotice.Exco == "General" {
                    VStack (alignment: .leading) {
                        Text("General")
                            .lineLimit(1)
                            .font(.system(size: 12))
                            .foregroundColor(Color("Black"))
                    }
                }
                else {
                    VStack (alignment: .leading) {
                        Text("\(thisNotice.Exco) Exco")
                            .lineLimit(1)
                            .font(.system(size: 12))
                            .foregroundColor(Color("Black"))
                    }
                }
                Spacer()
            }
            
            HStack {
                VStack (alignment: .leading) {
                    Text("\(EpochTimeToTimeInterval(epochTime: thisNotice.TimeStamp))")
                        .font(.system(size: 12, design: .default))
                        .foregroundColor(Color("NormalBlue"))
                    
                }
                Spacer()
            }
            
            HStack {
                VStack { Divider()
                    .background(Color("DarkGrey"))
                }.padding(0)
                Spacer()
            }.padding(.trailing, UIScreen.main.bounds.width * 5/8)
            
            HStack {
                VStack(alignment: .leading){
                    
                    Text(
"""
\(thisNotice.Body)
""")
                        .lineLimit(displayFullCard ? nil : 10)
                        .font(.system(size: 12, design: .default))
                        .foregroundColor(Color("Black"))
                    
                }
                Spacer()
            }
            
            if displayFullCard {
                HStack {
                    VStack {
                        Text("Published on \(EpochTimeToDayDateTime(epochTime: thisNotice.TimeStamp))")
                            .font(.system(size: 10))
                            .foregroundColor(Color("DarkGrey"))
                    }
                    Spacer()
                }.padding(.top, 10)
            }
            
            if displayFullCard == false {
                HStack {
                    VStack {
                        Button(action: {
                            displayFullCard = true
                        }) {
                            
                            Text("Show more...")
                                .font(.system(size: 10))
                            
                        }
                    }
                    Spacer()
                }
            }
            
        }.frame(width: self.cardWidth)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color("White"))
        .cornerRadius(10)
        .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                , radius: 1 , x: -1, y: 1)
    }
}


func EpochTimeToDayDateTime(epochTime: String) -> String {
    let date = Date(timeIntervalSince1970: Double((Double(epochTime)! / 1000)))
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM YYYY 'at' h:mm a"
    
    return dateFormatter.string(from: date)
}


func EpochTimeToTimeInterval(epochTime: String) -> String {
    
    let pastDate = Date(timeIntervalSince1970: Double((Double(epochTime)! / 1000)))
    let currentDate = Date()
    let dateFormatterYear = DateFormatter()
    let dateFormatterMonth = DateFormatter()
    let dateFormatterDay = DateFormatter()
    
    dateFormatterYear.dateFormat = "d MMM YY"
    dateFormatterMonth.dateFormat = "d MMM"
    dateFormatterDay.dateFormat = "EEEE"
    
    let dateDifference = Calendar.current.dateComponents(
        [Calendar.Component.year,
         Calendar.Component.month,
         Calendar.Component.day,
         Calendar.Component.hour,
         Calendar.Component.minute],
        from: pastDate, to: currentDate)
    
    if dateDifference.year! > 0 {
        return "\(dateFormatterYear.string(from: pastDate))"
    }
    
    else if dateDifference.month! > 0 {
        return "\(dateFormatterMonth.string(from: pastDate))"
    }
    
    else if dateDifference.day! > 0 {
        if dateDifference.day! == 1 {
            return "Yesterday"
        }
        else if dateDifference.day! < 7 {
            return "\(dateFormatterDay.string(from: pastDate))"
        }
        
        else if dateDifference.day! / 7 == 1 {
            return "Last \(dateFormatterDay.string(from: pastDate))"
        }
        
        else {
            return "\(dateDifference.day! / 7) weeks"
        }
    }
    
    else if dateDifference.hour! > 0 {
        return "\(dateDifference.hour!) hr"
    }
    
    else if dateDifference.minute! > 0 {
        return "\(dateDifference.minute!) min"
    }
    
    else {
        return "Just now"
    }
}

struct NoticesElements_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("VeryLightGrey")
            
            NoticeCardView(thisNotice: Notice(Title: "Important Announcement #1", Exco: "Academic Exco", Body: """
Student Council Notice
Hello everyone. First of all, thank you for communicating your concerns with us, either through form or personally contacting us. We have approached the SLT regarding your situation, and they were fully aware of your unstable situation during this time. Hence, these are the following plans the college has for batch 22.5 as a means of helping you cope with your academic studies;

1. Extra classes
- In line with the polls on the vote for having extra classes next semester(with 75% ‘yes’ to 25% ‘no’), the college is planning on conducting extra classes for batch 22.5 as a compensation for the lack of time to cover the syllabus before. The extra classes should help you guys to strengthen your academic knowledge.
- Instead of the usual classes ending at 4.15pm, you will have another extra block for that afternoon-on Mondays, Tuesdays and Thursdays. Classes would end at 5pm.
- On Fridays, you’ll have classes from 2.50pm - 5pm after the Friday prayer times
- These classes will commence as of  the start of next semester(21st July), regardless of whether the MCO is extended or not.
- Currently, the main reason for having these classes is for you to cover and understand the syllabus well. But right now, we don’t how long these classes would take place, so we will update you on that later.

2. Improvements in T&L
- One of the issues that came up with the T&L process was the lack of communication between the teachers and the HODs, which was why improvements to your learning process was hindered. But the matter has been looked into, so we hope you guys will have at least a decent online learning experience.
- This week, your teachers will be going through personal tuition from the IT dept pertaining to more effective online teaching methods.

3. August Exams
- The timetable for August exams will look similar to hiw normal exams are conducted.
- Exams will be held in large numbers of classrooms. Everyone will be spaced out into different classrooms, though you would still have a simultaneous start to your exams.
""", TimeStamp: "1597666032353"))
        }.edgesIgnoringSafeArea(.all)
    }
}
