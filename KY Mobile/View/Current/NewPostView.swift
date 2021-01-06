import Foundation
import SwiftUI

struct NewPostView: View {
    @EnvironmentObject var imageArchive: ImageArchive
    
    @Binding var isPresented: Bool
    @Binding var newPost: NewPost
    
    // Below 4 are toggles for the Start and End of the post and TimeStamp
    @Binding var boolAllDay: Bool
    @Binding var boolStart: Bool
    @Binding var boolEnd: Bool
    @Binding var boolTimeStamp: Bool
    
    @State private var isShowingImagePicker: Bool = false
    @State private var showDemoPage: Bool = false
    
    @Binding var errorMessage: String
    @Binding var showErrorMessage: Bool
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    // Title
                    TextField("Title of Post", text: $newPost.Title)
                      
                    // Short Description
                    TextField("Short Description", text: $newPost.ShortDesc)
                    
                    // Venue
                    TextField("Venue (if applicable)", text: $newPost.Venue)
                }
                
                // Body text
                Section(header: Text("Body")) {
                    VStack {
                        TextEditor(text: $newPost.FullDesc)
                        
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
                    // Start of Post
                    VStack {
                        Toggle(isOn: $boolStart) {
                            Text("Start")
                        }
                        Group {
                            if (boolStart && boolAllDay) {
                                DatePicker(selection: $newPost.Start, displayedComponents: .date) {}
                            } else if (boolStart && !boolAllDay) {
                                DatePicker(selection: $newPost.Start) {}
                            }
                        }
                    }
                    
                    // End of Post
                    VStack {
                        Toggle(isOn: $boolEnd) {
                            Text("End")
                        }
                        Group {
                            if (boolEnd && boolAllDay) {
                                DatePicker(selection: $newPost.End, displayedComponents: .date) {}
                            } else if (boolEnd && !boolAllDay) {
                                DatePicker(selection: $newPost.End) {}
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
                                    DatePicker(selection: $newPost.TimeStamp) {}
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                // Post Image
                Section(header: Text("Image")) {
                    
                    // Cancel Image
                    if newPost.Cover != UIImage() {
                        Button(action: {
                            newPost.Cover = UIImage()
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
                                            selectedImage: $newPost.Cover)
                        })
                    }
                    
                    Group {
                        // Display selected image
                        if newPost.Cover != UIImage() {
                            Image(uiImage: newPost.Cover)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                
                Section {
                    // Demo full page for new post
                    NavigationLink(destination: PostFullView(thisPost: newPost.convertAllToString(),
                                                             demoCardImage: newPost.Cover,
                                                             viewingType: .demo),
                                   isActive: $showDemoPage) {
                        // Demo card for new post
                        PostCardView(thisPost: newPost.convertAllToString(),
                                     demoCardImage: newPost.Cover,
                                     viewingType: .demo)
                            .offset(x: -14, y: 0)
                    }
                }
            }// Sheet header
            .navigationBarTitle("New Post", displayMode: .inline)
            .navigationBarItems(
                
                // Sheet cancel button
                leading: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 22, height: 22)
                },
                
                // Upload new post button
                trailing: Button(action: {
                    
                    // If an image was selected for the new post
                    if newPost.Cover != UIImage() {
                        // Upload the image
                        FBStorage.uploadImage(chosenImage: newPost.Cover,
                                              location: "Posts",
                                              identifier: newPost.UUID) { (result) in
                            switch result {
                            // If uploading the image to Storage was not successful
                            case .failure (let error):
                                self.errorMessage = error.localizedDescription
                                self.showErrorMessage = true
                                
                                // Upload the post regardless (without the image)
                                FBCurrent.uploadNewPost(newPost: newPost,
                                                         boolAllDay: boolAllDay,
                                                         boolStart: boolStart,
                                                         boolEnd: boolEnd,
                                                         boolTimeStamp: boolTimeStamp) { (result) in
                                    switch result {
                                    case .failure (let error):
                                        errorMessage = error.localizedDescription
                                        showErrorMessage = true
                                    case .success(_):
                                        break
                                    }
                                    // Resets all variables
                                    newPost = NewPost()
                                    boolAllDay = false
                                    boolStart = false
                                    boolEnd = false
                                    boolTimeStamp = false
                                }
                                
                            // Successfully uploaded the image to Storage
                            case .success (let url):
                                
                                // Saves the image to imageArchive
                                imageArchive.modifyImageArchive(id: newPost.UUID, uiImage: newPost.Cover, .add)
                                
                                // Saves the URL to newPost.CoverString
                                self.newPost.CoverString = url.absoluteString
                                
                                // Uploads the post along with the URL
                                FBCurrent.uploadNewPost(newPost: newPost,
                                                         boolAllDay: boolAllDay,
                                                         boolStart: boolStart,
                                                         boolEnd: boolEnd,
                                                         boolTimeStamp: boolTimeStamp) { (result) in
                                    switch result {
                                    case .failure (let error):
                                        errorMessage = error.localizedDescription
                                        showErrorMessage = true
                                    case .success(_):
                                        break
                                    }
                                    // Resets all variables
                                    newPost = NewPost()
                                    boolAllDay = false
                                    boolStart = false
                                    boolEnd = false
                                    boolTimeStamp = false
                                }
                            }
                        }
                    } // If no image was selected for the new post
                    else {
                        // Upload the post
                        FBCurrent.uploadNewPost(newPost: newPost,
                                                 boolAllDay: boolAllDay,
                                                 boolStart: boolStart,
                                                 boolEnd: boolEnd,
                                                 boolTimeStamp: boolTimeStamp) { (result) in
                            switch result {
                            case .failure (let error):
                                errorMessage = error.localizedDescription
                                showErrorMessage = true
                            case .success(_):
                                break
                            }
                            // Resets all variables
                            newPost = NewPost()
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
