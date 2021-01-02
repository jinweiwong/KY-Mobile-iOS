import Foundation
import SwiftUI

struct NewEventSheet: View {
    @Binding var isPresented: Bool
    @Binding var newEvent: NewEvent
    
    @Binding var errorMessage: String
    @Binding var showErrorMessage: Bool
    
    @State private var boolAllDay: Bool = false
    @State private var boolStart: Bool = false
    @State private var boolEnd: Bool = false
    @State private var boolTimeStamp: Bool = false
    
    @State private var isShowingImagePicker: Bool = false
    @State private var showDemoPage: Bool = false
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    TextField("Title of Event", text: $newEvent.Title)
                      
                    TextField("Short Description", text: $newEvent.ShortDesc)
                    
                    TextField("Venue (if applicable)", text: $newEvent.Venue)
                }
                
                Section(header: Text("Body")) {
                    VStack {
                        TextEditor(text: $newEvent.FullDesc)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                UIApplication.shared.dismissKeyboard()
                            }) {
                                Image(systemName: "keyboard.chevron.compact.down")
                            }
                        }
                    }
                    
                }
                
                Section {
                    VStack {
                        Toggle(isOn: $boolStart) {
                            Text("Start")
                        }
                        Group {
                            if (boolStart && boolAllDay) {
                                DatePicker(selection: $newEvent.Start, displayedComponents: .date) {}
                            } else if (boolStart && !boolAllDay) {
                                DatePicker(selection: $newEvent.Start) {}
                            }
                        }
                    }
                    
                    VStack {
                        Toggle(isOn: $boolEnd) {
                            Text("End")
                        }
                        Group {
                            if (boolEnd && boolAllDay) {
                                DatePicker(selection: $newEvent.End, displayedComponents: .date) {}
                            } else if (boolEnd && !boolAllDay) {
                                DatePicker(selection: $newEvent.End) {}
                            }
                        }
                    }
                    
                    Group {
                        if (boolStart || boolEnd) {
                            Toggle(isOn: $boolAllDay) {
                                Text("All-Day")
                            }
                        }
                    }
                }
                
                Section {
                    VStack {
                        Toggle(isOn: $boolTimeStamp) {
                            Text("Time Stamp")
                        }
                        HStack {
                            Group {
                                if boolTimeStamp {
                                    DatePicker(selection: $newEvent.TimeStamp) {}
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                Section(header: Text("Image")) {
                    
                    if newEvent.Cover != UIImage() {
                        Button(action: {
                            newEvent.Cover = UIImage()
                        }) {
                            Text("Cancel Image")
                        }
                    } else {
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            Text("Choose Image...")
                            
                        }.sheet(isPresented: $isShowingImagePicker, content: {
                            ImagePickerView(isPresented: self.$isShowingImagePicker,
                                            selectedImage: $newEvent.Cover)
                        })
                    }
                    
                    Group {
                        if newEvent.Cover != UIImage() {
                            Image(uiImage: newEvent.Cover)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: EventFullView(thisEvent:
                                                                newEvent.convertAllToString(),
                                                              demoCardImage: newEvent.Cover),
                                   isActive: $showDemoPage) {
                        EventCardView(thisEvent: newEvent.convertAllToString(),
                                      demoCardImage: newEvent.Cover)
                            .offset(x: -14, y: 0)
                    }
                }
            }
            
            .navigationBarTitle("New Event", displayMode: .inline)
            .navigationBarItems(
                
                leading: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 22, height: 22)
                },
                
                trailing: Button(action: {
                    
                    if !boolTimeStamp {
                        newEvent.TimeStamp = Date()
                    }
                    
                    if newEvent.Cover != UIImage() {
                        FBStorage.uploadImage(chosenImage: newEvent.Cover,
                                              location: "Events",
                                              identifier: "\(Int(newEvent.TimeStamp.timeIntervalSince1970*1000))",
                                              name: newEvent.Title) { (result) in
                            switch result {
                            
                            case .failure (let error):
                                self.errorMessage = error.localizedDescription
                                self.showErrorMessage = true
                                
                                FBCurrent.uploadNewEvent(newEvent: newEvent,
                                                         boolAllDay: boolAllDay,
                                                         boolStart: boolStart,
                                                         boolEnd: boolEnd) { (result) in
                                    switch result {
                                    case .failure (let error):
                                        errorMessage = error.localizedDescription
                                        showErrorMessage = true
                                    case .success(_):
                                        break
                                    }
                                    newEvent = NewEvent()
                                }
                                
                            case .success (let url):
                                self.newEvent.CoverString = url.absoluteString
                                
                                FBCurrent.uploadNewEvent(newEvent: newEvent,
                                                         boolAllDay: boolAllDay,
                                                         boolStart: boolStart,
                                                         boolEnd: boolEnd) { (result) in
                                    switch result {
                                    case .failure (let error):
                                        errorMessage = error.localizedDescription
                                        showErrorMessage = true
                                    case .success(_):
                                        break
                                    }
                                    newEvent = NewEvent()
                                }
                            }
                        }
                    } else {
                        FBCurrent.uploadNewEvent(newEvent: newEvent,
                                                 boolAllDay: boolAllDay,
                                                 boolStart: boolStart,
                                                 boolEnd: boolEnd) { (result) in
                            switch result {
                            case .failure (let error):
                                errorMessage = error.localizedDescription
                                showErrorMessage = true
                            case .success(_):
                                break
                            }
                            newEvent = NewEvent()
                        }
                    }
                    isPresented = false
                }) {
                    Text("Upload")
                })
        }
    }
}
