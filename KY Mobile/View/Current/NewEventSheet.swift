import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct NewEventSheet: View {
    @Binding var isPresented: Bool
    @Binding var newEvent: Event
    
    @Binding var errorMessage: String
    @Binding var showErrorMessage: Bool
    
    @State private var showDemoPage: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                title
                shortDesc
                fullDesc
                venue
                date
                time
                demo
                    .padding(.bottom)
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
                    FBService.uploadNewEvent(newEvent: newEvent) { (result) in
                        switch result {
                        case .failure (let error):
                            errorMessage = error.localizedDescription
                            showErrorMessage = true
                        case .success(_):
                            break
                        }}
                    isPresented = false
                    newEvent = Event()
                }) {
                    Text("Upload")
                })
        }
    }
    
    var title: some View {
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
        }.padding(.horizontal)
        .padding(.top)
    }
    
    var shortDesc: some View {
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
        }.padding(.horizontal)
        .padding(.top)
    }
    
    var fullDesc: some View {
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
        }.padding(.horizontal)
        .padding(.top)
    }
    
    var venue: some View {
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
        }.padding(.horizontal)
        .padding(.top)
    }
    
    var date: some View {
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
        }.padding(.horizontal)
        .padding(.top)
    }
    
    var time: some View {
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
        }.padding(.horizontal)
        .padding(.top)
    }
    
    var demo: some View {
        Group {
            HStack {
                VStack {
                    Text("Demo")
                        .modifier(MediumText(textColor: Color("Black")))
                }
                Spacer()
            }.padding(.horizontal)
            .padding(.top)
            
            // Demo Card
            NavigationLink(destination: EventFullView(thisEvent:
                                                        newEvent.eventWithRandomTimeStamp()),
                           isActive: $showDemoPage) {
                EventCardView(thisEvent: newEvent.eventWithRandomTimeStamp())
            }.padding(.horizontal)
        }
    }
}
