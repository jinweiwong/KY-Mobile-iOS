//
//  NewEventSheet.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 23/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct NewEventSheet: View {
    @Binding var isPresented: Bool
    @Binding var newEvent: Event
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // Title
                VStack {
                    HStack {
                        VStack {
                            Text("Title")
                                .modifier(MediumText(textColor: Color("Black")))
                        }
                        Spacer()
                    }
                    HStack {
                        VStack {
                            HStack {
                                TextField("Title of Event", text: $newEvent.Title)
                                    .frame(width: UIScreen.main.bounds.width * 7/8, height: 30)
                                    .autocapitalization(.none)
                                
                                Spacer()
                            }
                            
                            Divider()
                                .frame(width: UIScreen.main.bounds.width * 7/8, height: 2)
                        }
                        Spacer()
                    }
                }.padding()
                
                // Short Description
                VStack {
                    HStack {
                        VStack {
                            Text("Short Description")
                                .modifier(MediumText(textColor: Color("Black")))
                        }
                        Spacer()
                    }
                    HStack {
                        VStack {
                            HStack {
                                TextField("Short Description", text: $newEvent.ShortDesc)
                                    .frame(width: UIScreen.main.bounds.width * 7/8, height: 30)
                                    .autocapitalization(.none)
                                
                                Spacer()
                            }
                            
                            Divider()
                                .frame(width: UIScreen.main.bounds.width * 7/8, height: 2)
                        }
                        Spacer()
                    }
                }.padding()
                
                // Full Description
                VStack {
                    HStack {
                        VStack {
                            Text("Full Description")
                                .modifier(MediumText(textColor: Color("Black")))
                        }
                        Spacer()
                    }
                    HStack {
                        VStack {
                            if #available(iOS 14.0, *) {
                                TextEditor(text: $newEvent.FullDesc)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
                                    .cornerRadius(10)
                                    .border(Color("LightGrey"), width: 1)
                            }
                        }
                        Spacer()
                    }
                }.padding()
                
                // Venue
                VStack {
                    HStack {
                        VStack {
                            Text("Venue")
                                .modifier(MediumText(textColor: Color("Black")))
                        }
                        Spacer()
                    }
                    HStack {
                        VStack {
                            HStack {
                                TextField("Venue", text: $newEvent.Venue)
                                    .frame(width: UIScreen.main.bounds.width * 7/8, height: 30)
                                    .autocapitalization(.none)
                                
                                Spacer()
                            }
                            
                            Divider()
                                .frame(width: UIScreen.main.bounds.width * 7/8, height: 2)
                        }
                        Spacer()
                    }
                }.padding()
                
                // Date
                VStack {
                    HStack {
                        VStack {
                            Text("Date")
                                .modifier(MediumText(textColor: Color("Black")))
                        }
                        Spacer()
                    }
                    HStack {
                        TextField("DD/MM/YYYY", text: $newEvent.StartDate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: UIScreen.main.bounds.width * 3/8, height: 30)
                            .autocapitalization(.none)
                        
                        Text("to")
                        
                        TextField("DD/MM/YYYY", text: $newEvent.EndDate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: UIScreen.main.bounds.width * 3/8, height: 30)
                            .autocapitalization(.none)
                        
                        Spacer()
                    }
                }.padding()
                
                // Time
                VStack {
                    HStack {
                        VStack {
                            Text("Time")
                                .modifier(MediumText(textColor: Color("Black")))
                        }
                        Spacer()
                    }
                    HStack {
                        TextField("HH:MM", text: $newEvent.StartTime)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: UIScreen.main.bounds.width * 2/8, height: 30)
                            .autocapitalization(.none)
                        
                        Text("to")
                        
                        TextField("HH:MM", text: $newEvent.EndTime)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: UIScreen.main.bounds.width * 2/8, height: 30)
                            .autocapitalization(.none)
                        
                        Spacer()
                    }
                }.padding()
                
                // Demo
                HStack {
                    VStack {
                        Text("Demo")
                            .modifier(MediumText(textColor: Color("Black")))
                    }
                    Spacer()
                }.padding(.horizontal)
                .padding(.top)
                
                // Demo Card
                ZStack {
                    Color("VeryLightGrey")
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 125)
                            .cornerRadius(15)
                            .shadow(color: .init(red: 0.1, green: 0.1, blue: 0.1)
                                    , radius: 2 , x: -1, y: 1)
                        
                        CurrentCardView(thisEvent: Event(Title: newEvent.Title,
                                                         FullDesc: newEvent.FullDesc,
                                                         ShortDesc: newEvent.ShortDesc,
                                                         StartDate: newEvent.StartDate,
                                                         EndDate: newEvent.EndDate,
                                                         StartTime: newEvent.StartTime,
                                                         EndTime: newEvent.EndTime,
                                                         Venue: newEvent.Venue,
                                                         Cover: newEvent.Cover,
                                                         TimeStamp: "1597666032353"))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                    }
                }.frame(width: UIScreen.main.bounds.width, height: 200)
                
                // Demo Page
                VStack {
                    HStack {
                        NavigationLink(destination:CurrentPageView(thisEvent:
                                                                    Event(Title: newEvent.Title,
                                                                          FullDesc: newEvent.FullDesc,
                                                                          ShortDesc: newEvent.ShortDesc,
                                                                          StartDate: newEvent.StartDate,
                                                                          EndDate: newEvent.EndDate,
                                                                          StartTime: newEvent.StartTime,
                                                                          EndTime: newEvent.EndTime,
                                                                          Venue: newEvent.Venue,
                                                                          Cover: newEvent.Cover,
                                                                          TimeStamp: "1597666032353"),
                                                                   isShowingPageView: Binding.constant(true))) {
                            Text("See Detailed Page")
                                .padding()
                        }
                    }
                }
            }.navigationBarTitle("New Event", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 22, height: 22)
                },
                trailing: Button(action: {
                    newEvent.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
                    uploadNewEvent(newEvent: newEvent) { (result) in
                        switch result {
                        case .failure (let error):
                            print(error)
                        case .success(_):
                            break
                        }}
                    
                    isPresented = false
                    newEvent = Event(Title: "", FullDesc: "", ShortDesc: "", StartDate: "", EndDate: "", StartTime: "", EndTime: "", Venue: "", Cover: "", TimeStamp: "")
                    
                }) {
                    Text("Upload")
                })
        }
    }
}

func ConvEventToDict(event: Event) -> [String: Any] {
    let list: [String: Any] = ["Title": event.Title,
                               "FullDesc": event.FullDesc,
                               "ShortDesc": event.ShortDesc,
                               "StartDate": event.StartDate,
                               "EndDate": event.EndDate,
                               "StartTime": event.StartTime,
                               "EndTime": event.EndTime,
                               "Venue": event.Venue,
                               "Cover": event.Cover,
                               "timestamp": event.TimeStamp]
    return list
}


func uploadNewEvent(newEvent: Event, completion: @escaping (Result<Bool, Error>) -> () ) {
    let reference = Firestore
        .firestore()
        .collection("Events")
        .document(newEvent.TimeStamp)
    
    reference.setData(ConvEventToDict(event: newEvent), merge: true) { (err) in
        if let err = err {
            completion(.failure(err))
            return
        }
        completion(.success(true))
    }
}

struct NewEventSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewEventSheet(isPresented: Binding.constant(true), newEvent: Binding.constant(Event(Title: "", FullDesc: "", ShortDesc: "", StartDate: "", EndDate: "", StartTime: "", EndTime: "", Venue: "", Cover: "", TimeStamp: "")))
    }
}
