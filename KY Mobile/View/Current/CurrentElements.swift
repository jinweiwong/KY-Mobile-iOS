//
//  CurrentPageView.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 21/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseStorage

struct CurrentCardView: View {
    
    let thisEvent: Event
    let cardWidth: CGFloat = UIScreen.main.bounds.width - 40
    
    var body: some View {
        HStack (spacing: 12) {
            
            Image("3")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(10)
                .padding(.leading, 15)
                .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                        , radius: 1 , x: -1, y: 1)
            
            VStack (spacing: 8) {
                HStack {
                    VStack(alignment: .leading){
                        
                        Text("\(thisEvent.Title)")
                            .lineLimit(2)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(Color("Black"))
                        
                    }
                    Spacer()
                }
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("\(thisEvent.ShortDesc)")
                            .lineLimit(2)
                            .font(.system(size: 12))
                            .foregroundColor(Color("DarkGrey"))
                        
                    }
                    Spacer()
                }
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("\(EpochTimeToTimeInterval(epochTime: thisEvent.TimeStamp))")
                            .font(.system(size: 12, design: .default))
                            .foregroundColor(Color("NormalBlue"))
                        
                    }
                    Spacer()
                }
            }.frame(width: self.cardWidth - 120)
        }
    }
}

struct CurrentCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color("VeryLightGrey")
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 125)
                    .cornerRadius(15)
                    .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                            , radius: 2 , x: -1, y: 1)
                
                CurrentCardView(thisEvent: Event(Title: "Blast off! Rocketship Games",
                                                 FullDesc: "At auctor urna nunc id cursus metus aliquam. Id donec ultrices tincidunt arcu non sodales neque sodales ut. Purus ut faucibus pulvinar elementum. Adipiscing elit ut aliquam purus. Arcu vitae elementum curabitur vitae nunc sed velit dignissim. Diam ut venenatis tellus in metus vulputate eu scelerisque. Aliquam malesuada bibendum arcu vitae. Non curabitur gravida arcu ac tortor dignissim convallis. Morbi tristique senectus et netus et malesuada. Quisque sagittis purus sit amet volutpat consequat mauris nunc congue. Eu non Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Etiam tempor orci eu lobortis elementum nibh. Cras sed felis eget velit aliquet sagittis. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Pretium fusce id velit ut tortor pretium viverra suspendisse potenti. Mi quis hendrerit dolor magna eget est lorem. Gravida dictum fusce ut placerat orci nulla pellentesque. Mauris sit amet massa vitae tortor condimentum lacinia quis vel. Aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Eget dolor morbi non arcu risus. Placerat duis ultricies lacus sed turpis tincidunt. Aliquet sagittis id consectetur purus. Orci phasellus egestas tellus rutrum tellus pellentesque eu. Morbi tristique senectus et netus. Elementum facilisis leo vel fringilla est ullamcorper eget. Pellentesque elit eget gravida cum sociis. Ultricies tristique nulla aliquet enim tortor at. Risus viverra adipiscing at in. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Etiam tempor orci eu lobortis elementum nibh. Cras sed felis eget velit aliquet sagittis. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Pretium fusce id velit ut tortor pretium viverra suspendisse potenti. Mi quis hendrerit dolor magna eget est lorem. Gravida dictum fusce ut placerat orci nulla pellentesque. Mauris sit amet massa vitae tortor condimentum lacinia quis vel. Aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Eget dolor morbi non arcu risus. Placerat duis ultricies lacus sed turpis tincidunt. Aliquet sagittis id consectetur purus. Orci phasellus egestas tellus rutrum tellus pellentesque eu. Morbi tristique senectus et netus. Elementum facilisis leo vel fringilla est ullamcorper eget. Pellentesque elit eget gravida cum sociis. Ultricies tristique nulla aliquet enim tortor at. Risus viverra adipiscing at in.",
                                                 ShortDesc: "ROGER THAT",
                                                 StartDate: "15/02/2020",
                                                 EndDate: "17/02/2020",
                                                 StartTime: "22:00",
                                                 EndTime: "14:00",
                                                 Venue: "Hall",
                                                 Cover: "4",
                                                 TimeStamp: "3 days"))
                    .cornerRadius(15)
                    .foregroundColor(.white)
            }
        }
    }
}

struct CurrentPageView: View {
    
    let thisEvent: Event
    @Binding var isShowingPageView: Bool
    
    var body: some View {
        ZStack {
            Color("VeryLightGrey")
            
            ScrollView {
                VStack {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: UIScreen.main.bounds.height / 3)
                        .cornerRadius(0)
                    
                    
                    HStack {
                        Text("\(thisEvent.Title)")
                            .bold()
                            .modifier(LargeText(textColor: Color("Black")))
                            .lineLimit(2)
                        Spacer()
                    }.padding(.horizontal)
                    .padding(.vertical, 2)
                    
                    
                    HStack {
                        Text("\(thisEvent.ShortDesc)")
                            .modifier(MediumText(textColor: Color("Black")))
                        Spacer()
                    }.padding(.horizontal)
                    .padding(.vertical, 1)
                    
                    
                    HStack {
                        VStack {
                            Text("Start: \(DateTimeStringToDayDateTime(date: thisEvent.StartDate, time: thisEvent.StartTime))")
                                .lineLimit(1)
                                .font(.system(size: 14))
                                .foregroundColor(Color("VeryDarkGrey"))
                        }
                        Spacer()
                    }.padding(.horizontal)
                    .padding(.vertical, 1)
                    
                    
                    HStack {
                        VStack {
                            Text("End:   \(DateTimeStringToDayDateTime(date: thisEvent.EndDate, time: thisEvent.EndTime))")
                                .lineLimit(1)
                                .font(.system(size: 14))
                                .foregroundColor(Color("VeryDarkGrey"))
                        }
                        Spacer()
                    }.padding(.horizontal)
                    .padding(.top, -5)
                    .padding(.bottom, 1)
                    
                    
                    HStack {
                        Text("\(EpochTimeToTimeInterval(epochTime: thisEvent.TimeStamp))")
                            .font(.body)
                            .foregroundColor(Color("NormalBlue"))
                        
                        Spacer()
                    }.padding(.horizontal)
                    .padding(.vertical, 1)
                    
                    
                    HStack (spacing: 15) {
                        VStack { Divider()
                            .background(Color("DarkGrey"))
                        }.padding(0)
                    }.padding(.horizontal, 20)
                    
                    HStack {
                        VStack {
                            Text("\(thisEvent.FullDesc)")
                                .font(.body)
                                .foregroundColor(Color("VeryDarkGrey"))
                                .padding()
                        }
                        Spacer()
                    }
                }
            }
            
            Button(action: {
                self.isShowingPageView = false
            }){
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.init(white: 0.9))
                    .font(.system(size: 25)).padding()
                    .animation(
                        Animation.easeInOut(duration: 0.3)
                    )
            }.offset(x: (UIScreen.main.bounds.width/2) - 40, y: (-1 * UIScreen.main.bounds.height/2) + 50)
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CurrentPageView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPageView(thisEvent: Event(Title: "Blast off! Rocketship Games",
                                         FullDesc: "At auctor urna nunc id cursus metus aliquam. Id donec ultrices tincidunt arcu non sodales neque sodales ut. Purus ut faucibus pulvinar elementum. Adipiscing elit ut aliquam purus. Arcu vitae elementum curabitur vitae nunc sed velit dignissim. Diam ut venenatis tellus in metus vulputate eu scelerisque. Aliquam malesuada bibendum arcu vitae. Non curabitur gravida arcu ac tortor dignissim convallis. Morbi tristique senectus et netus et malesuada. Quisque sagittis purus sit amet volutpat consequat mauris nunc congue. Eu non Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Etiam tempor orci eu lobortis elementum nibh. Cras sed felis eget velit aliquet sagittis. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Pretium fusce id velit ut tortor pretium viverra suspendisse potenti. Mi quis hendrerit dolor magna eget est lorem. Gravida dictum fusce ut placerat orci nulla pellentesque. Mauris sit amet massa vitae tortor condimentum lacinia quis vel. Aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Eget dolor morbi non arcu risus. Placerat duis ultricies lacus sed turpis tincidunt. Aliquet sagittis id consectetur purus. Orci phasellus egestas tellus rutrum tellus pellentesque eu. Morbi tristique senectus et netus. Elementum facilisis leo vel fringilla est ullamcorper eget. Pellentesque elit eget gravida cum sociis. Ultricies tristique nulla aliquet enim tortor at. Risus viverra adipiscing at in. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Etiam tempor orci eu lobortis elementum nibh. Cras sed felis eget velit aliquet sagittis. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Pretium fusce id velit ut tortor pretium viverra suspendisse potenti. Mi quis hendrerit dolor magna eget est lorem. Gravida dictum fusce ut placerat orci nulla pellentesque. Mauris sit amet massa vitae tortor condimentum lacinia quis vel. Aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Eget dolor morbi non arcu risus. Placerat duis ultricies lacus sed turpis tincidunt. Aliquet sagittis id consectetur purus. Orci phasellus egestas tellus rutrum tellus pellentesque eu. Morbi tristique senectus et netus. Elementum facilisis leo vel fringilla est ullamcorper eget. Pellentesque elit eget gravida cum sociis. Ultricies tristique nulla aliquet enim tortor at. Risus viverra adipiscing at in.",
                                         ShortDesc: "ROGER THAT",
                                         StartDate: "15/02/2020",
                                         EndDate: "17/02/2020",
                                         StartTime: "22:00",
                                         EndTime: "14:00",
                                         Venue: "Hall",
                                         Cover: "4",
                                         TimeStamp: "1597666032353"),
                        isShowingPageView: Binding.constant(true))
    }
}


//[localPlayer generateIdentityVerificationSignatureWithCompletionHandler:^(
//                 NSURL *publicKeyURL, NSData *signature, NSData *salt, uint64_t timestamp,
//                 NSError *error) {
//  if (error) {
//    if (completion) {
//      completion(nil, error);
//    }
//  } else {
//    if (completion) {
//      /**
//       @c `localPlayer.alias` is actually the displayname needed, instead of
//       `localPlayer.displayname`. For more information, check
//       https://developer.apple.com/documentation/gamekit/gkplayer
//       **/
//      NSString *displayName = localPlayer.alias;
//// iOS 13 deprecation
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//      FIRGameCenterAuthCredential *credential =
//          [[FIRGameCenterAuthCredential alloc] initWithPlayerID:localPlayer.playerID
//                                                   publicKeyURL:publicKeyURL
//                                                      signature:signature
//                                                           salt:salt
//                                                      timestamp:timestamp
//                                                    displayName:displayName];
//#pragma clang diagnostic pop
//      completion(credential, nil);
//    }
//  }
//}];
//}
