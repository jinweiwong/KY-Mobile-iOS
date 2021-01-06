import Foundation
import SwiftUI

struct EditPostView: View {
    @EnvironmentObject var imageArchive: ImageArchive
    
    @Binding var isPresented: Bool
    
    var unEditedPost: NewPost
    @Binding var editedPost: NewPost
    
    // Below 4 are toggles for the Start and End of the post and TimeStamp
    @Binding var boolAllDay: Bool
    @Binding var boolStart: Bool
    @Binding var boolEnd: Bool
    @Binding var boolTimeStamp: Bool
    
    @State private var isShowingImagePicker: Bool = false
    @State private var showDemoPage: Bool = false
    @State private var showDeletePostConfirmation: Bool = false
    
    @Binding var errorMessage: String
    @Binding var showErrorMessage: Bool
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    // Title
                    TextField("Title of Post", text: $editedPost.Title)
                    
                    // Short Description
                    TextField("Short Description", text: $editedPost.ShortDesc)
                    
                    // Venue
                    TextField("Venue (if applicable)", text: $editedPost.Venue)
                }
                
                // Body text
                Section(header: Text("Body")) {
                    VStack {
                        TextEditor(text: $editedPost.FullDesc)
                        
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
                                DatePicker(selection: $editedPost.Start, displayedComponents: .date) {}
                            } else if (boolStart && !boolAllDay) {
                                DatePicker(selection: $editedPost.Start) {}
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
                                DatePicker(selection: $editedPost.End, displayedComponents: .date) {}
                            } else if (boolEnd && !boolAllDay) {
                                DatePicker(selection: $editedPost.End) {}
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
                                    DatePicker(selection: $editedPost.TimeStamp) {}
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                // Post Image
                Section(header: Text("Image")) {
                    
                    // Cancel Image
                    if editedPost.Cover != UIImage() {
                        Button(action: {
                            editedPost.Cover = UIImage()
                            editedPost.CoverString = ""
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
                                            selectedImage: $editedPost.Cover)
                        })
                    }
                    
                    Group {
                        // Display selected image
                        if editedPost.Cover != UIImage() {
                            Image(uiImage: editedPost.Cover)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                
                Section {
                    // Demo full page for new post
                    NavigationLink(destination: PostFullView(thisPost: editedPost.convertAllToString(),
                                                             demoCardImage: editedPost.Cover,
                                                             viewingType: .demo),
                                   isActive: $showDemoPage) {
                        // Demo card for new post
                        PostCardView(thisPost: editedPost.convertAllToString(),
                                     demoCardImage: editedPost.Cover,
                                     viewingType: .demo)
                            .offset(x: -14, y: 0)
                    }
                }
                
                Section {
                    Button(action: {
                        showDeletePostConfirmation = true
                    }) {
                        Text("Delete Post")
                            .foregroundColor(Color.red)
                    }.alert(isPresented: self.$showDeletePostConfirmation) {
                        Alert(title: Text("Delete Post"),
                              message: Text("Delete\n \(unEditedPost.Title)?"),
                              primaryButton: .destructive(Text("OK")) {
                                
                                FBCurrent.deletePost(identifier: unEditedPost.UUID) { (result) in
                                    switch result {
                                    case .failure(let error):
                                        self.errorMessage = error.localizedDescription
                                        self.showErrorMessage = true
                                        
                                    case .success(_):
                                        break
                                    }}
                                
                                // Delete Image from Storage
                                if unEditedPost.CoverString != "" {
                                    FBStorage.deleteImage(location: "Posts",
                                                          identifier: unEditedPost.UUID) { (result) in
                                        switch result {
                                        case .failure(let error):
                                            self.errorMessage = error.localizedDescription
                                            self.showErrorMessage = true
                                            
                                        case .success(_):
                                            imageArchive.modifyImageArchive(id: unEditedPost.UUID, .remove)
                                        }}}
                                
                                isPresented = false
                              }, secondaryButton: .cancel())
                    }
                }
                
            } // Sheet header
            .navigationBarTitle("Edit Post", displayMode: .inline)
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
                    if editedPost.Cover != UIImage() {
                        // Upload the image
                        FBStorage.uploadImage(chosenImage: editedPost.Cover,
                                              location: "Posts",
                                              identifier: editedPost.UUID) { (result) in
                            switch result {
                            // If uploading the image to Storage was not successful
                            case .failure (let error):
                                self.errorMessage = error.localizedDescription
                                self.showErrorMessage = true
                                
                                // Upload the post regardless (without the image)
                                FBCurrent.uploadNewPost(newPost: editedPost,
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
                                    editedPost = NewPost()
                                    boolAllDay = false
                                    boolStart = false
                                    boolEnd = false
                                    boolTimeStamp = false
                                }
                                
                            // Successfully uploaded the image to Storage
                            case .success (let url):
                                
                                // Saves the image to the imageArchive
                                imageArchive.modifyImageArchive(id: unEditedPost.UUID, uiImage: editedPost.Cover, .add)
                                
                                // Saves the URL to newPost.CoverString
                                self.editedPost.CoverString = url.absoluteString
                                
                                // Uploads the post along with the URL
                                FBCurrent.uploadNewPost(newPost: editedPost,
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
                                    editedPost = NewPost()
                                    boolAllDay = false
                                    boolStart = false
                                    boolEnd = false
                                    boolTimeStamp = false
                                }
                            }
                        }
                    } // If no image was selected for the new post
                    else {
                        // If there was an image previously, delete it from Storage
                        if unEditedPost.CoverString != "" {
                            FBStorage.deleteImage(location: "Posts",
                                                  identifier: editedPost.UUID) { (result) in
                                switch result {
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                    self.showErrorMessage = true
                                    
                                case .success(_):
                                    // Remove the image from imageArchive
                                    imageArchive.modifyImageArchive(id: unEditedPost.UUID, .remove)
                                    editedPost.CoverString = ""
                                }}
                        }
                        
                        // Upload the post
                        FBCurrent.uploadNewPost(newPost: editedPost,
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
                            editedPost = NewPost()
                            boolAllDay = false
                            boolStart = false
                            boolEnd = false
                            boolTimeStamp = false
                        }
                    }
                    // Stop displaying sheet
                    isPresented = false
                }) {
                    Text("Confirm")
                })
        }
    }
}

    
