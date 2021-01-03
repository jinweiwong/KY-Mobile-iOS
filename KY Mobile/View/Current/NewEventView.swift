import Foundation
import SwiftUI

struct NewEventView: View {
    @Binding var isPresented: Bool
    @Binding var newEvent: NewEvent
    
    // Below 4 are toggles for the Start and End of the event and TimeStamp
    @Binding var boolAllDay: Bool
    @Binding var boolStart: Bool
    @Binding var boolEnd: Bool
    @Binding var boolTimeStamp: Bool
    
    // Selecting image
    @State private var isShowingImagePicker: Bool = false
    
    // Showing Demo page
    @State private var showDemoPage: Bool = false
    
    @Binding var errorMessage: String
    @Binding var showErrorMessage: Bool
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    // Title
                    TextField("Title of Event", text: $newEvent.Title)
                      
                    // Short Description
                    TextField("Short Description", text: $newEvent.ShortDesc)
                    
                    // Venue
                    TextField("Venue (if applicable)", text: $newEvent.Venue)
                }
                
                // Body text
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
                    // Start of Event
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
                    
                    // End of Event
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
                    
                    // All-Day
                    Group {
                        if (boolStart || boolEnd) {
                            Toggle(isOn: $boolAllDay) {
                                Text("All-Day")
                            }
                        }
                    }
                }
                
                // Time Stamp
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
                
                // Event Image
                Section(header: Text("Image")) {
                    
                    // Cancel Image
                    if newEvent.Cover != UIImage() {
                        Button(action: {
                            newEvent.Cover = UIImage()
                        }) {
                            Text("Cancel Image")
                        }
                    } // Choose Image
                    else {
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
                        // Display selected image
                        if newEvent.Cover != UIImage() {
                            Image(uiImage: newEvent.Cover)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                
                Section {
                    // Demo full page for new event
                    NavigationLink(destination: EventFullView(thisEvent:
                                                                newEvent.convertAllToString(),
                                                              demoCardImage: newEvent.Cover),
                                   isActive: $showDemoPage) {
                        // Demo card for new event
                        EventCardView(thisEvent: newEvent.convertAllToString(),
                                      demoCardImage: newEvent.Cover)
                            .offset(x: -14, y: 0)
                    }
                }
            }// Sheet header
            .navigationBarTitle("New Event", displayMode: .inline)
            .navigationBarItems(
                
                // Sheet cancel button
                leading: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 22, height: 22)
                },
                
                // Upload new event button
                trailing: Button(action: {
                    // Set the current TimeStamp if no TimeStamp was specified
                    if !boolTimeStamp {
                        newEvent.TimeStamp = Date()
                    }
                    
                    // If an image was selected for the new event
                    if newEvent.Cover != UIImage() {
                        // Upload the image
                        FBStorage.uploadImage(chosenImage: newEvent.Cover,
                                              location: "Events",
                                              identifier: "\(Int(newEvent.TimeStamp.timeIntervalSince1970*1000))",
                                              name: newEvent.Title) { (result) in
                            switch result {
                            // If uploading the image to Storage was not successful
                            case .failure (let error):
                                self.errorMessage = error.localizedDescription
                                self.showErrorMessage = true
                                
                                // Upload the event regardless (without the image)
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
                                    // Resets all variables
                                    newEvent = NewEvent()
                                    boolAllDay = false
                                    boolStart = false
                                    boolEnd = false
                                    boolTimeStamp = false
                                }
                                
                            // Successfully uploaded the image to Storage
                            case .success (let url):
                                // Saves the URL to newEvent.CoverString
                                self.newEvent.CoverString = url.absoluteString
                                
                                // Uploads the event along with the URL
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
                                    // Resets all variables
                                    newEvent = NewEvent()
                                    boolAllDay = false
                                    boolStart = false
                                    boolEnd = false
                                    boolTimeStamp = false
                                }
                            }
                        }
                    } // If no image was selected for the new event
                    else {
                        // Upload the event
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
                            // Resets all variables
                            newEvent = NewEvent()
                            boolAllDay = false
                            boolStart = false
                            boolEnd = false
                            boolTimeStamp = false
                        }
                    }
                    // Stop displaying sheet
                    isPresented = false
                }) {
                    Text("Upload")
                })
        }
    }
}
