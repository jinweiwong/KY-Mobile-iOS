//
//  CurrentViewNew.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 20/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

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
    
    @State var expandedEvent = Event()
    @State var isShowingPageView = false
    
    @State var newEvent = Event()
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        //Header
        ZStack{
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
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
                
                
                
                // ForEach_start
                
                ForEach(events.events, id: \.id) { thisEvent in
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: self.cardWidth, height: self.cardHeight)
                            .cornerRadius(15)
                            .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                                    , radius: 2 , x: -1, y: 1)
                        
                        Button(action: {
                            expandedEvent = thisEvent
                            isShowingPageView = true
                        }) {
                            CurrentCardView(thisEvent: thisEvent)
                        }
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        
                    }
                    .frame(height:self.cardHeight)
                    .padding(.leading, 16)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                }
            }.sheet(isPresented: $isShowingSheet,
                    content: {
                        NewEventSheet(isPresented: $isShowingSheet,
                                      newEvent: $newEvent)
                    })
            
            if self.isShowingPageView {
                CurrentPageView(thisEvent: expandedEvent, isShowingPageView: $isShowingPageView)
            }
        }.animation(.easeIn)
    }
}


struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
    }
}

