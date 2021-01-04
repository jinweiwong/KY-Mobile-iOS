import Foundation
import SwiftUI

struct NewNoticeView: View {
    @Binding var isPresented: Bool
    @Binding var newNotice: NewNotice 
    
    @Binding var boolTimeStamp: Bool
    
    @Binding var errorMessage: String
    @Binding var showErrorMessage: Bool
    
    // Variables to help with the Exco Picker
    let excos: [String] = ["General", "Academic", "Food", "Religious", "Special Task", "Sports", "Welfare"]
    @State var selectedExcoDigit: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Title
                    TextField("Title of Notice", text: $newNotice.Title)
                    
                    // Exco Picker
                    Picker(selection: $selectedExcoDigit, label: Text("Exco")) {
                        ForEach(0 ..< excos.count) {
                            Text(excos[$0])
                        }.onChange(of: selectedExcoDigit, perform: { (value) in
                                    newNotice.Exco = excos[value] })
                    }.pickerStyle(DefaultPickerStyle())
                    
                }
                
                Section (header: Text("Message")) {
                    // Body Text Editor
                    VStack {
                        TextEditor(text: $newNotice.Body)
                        
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
                        Toggle(isOn: $boolTimeStamp) {
                            Text("Time Stamp")
                        }
                        HStack {
                            Group {
                                if boolTimeStamp {
                                    DatePicker(selection: $newNotice.TimeStamp) {}
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                Section {
                    // Demo Notice Card
                    NoticeCardView(thisNotice: newNotice.convertAllToString())
                        .offset(x: -12, y: 0)
                } // Sets the default Exco to General
                .onAppear(perform: {
                    newNotice.Exco = "General"
                })
                
            }.navigationBarTitle("New Notice", displayMode: .inline)
            .navigationBarItems(
                // Cancel Sheet Button
                leading: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 22, height: 22)
                },
                // Upload new notice Button
                trailing: Button(action: {
                    FBNotice.uploadNewNotice(newNotice: newNotice, boolTimeStamp: boolTimeStamp) { (result) in
                        switch result {
                        case .failure (let error):
                            errorMessage = error.localizedDescription
                            showErrorMessage = true
                        case .success(_):
                            break
                        }}
                    // Closes the sheet and resets variables
                    isPresented = false
                    boolTimeStamp = false
                    newNotice = NewNotice()
                }) {
                    Text("Upload")
                })
        }
    }
}
