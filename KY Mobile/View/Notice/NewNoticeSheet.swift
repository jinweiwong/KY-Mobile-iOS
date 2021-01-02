import Foundation
import SwiftUI

struct NewNoticeSheet: View {
    @Binding var isPresented: Bool
    @Binding var newNotice: Notice
    
    @Binding var errorMessage: String
    @Binding var showErrorMessage: Bool
    
    let excos: [String] = ["General", "Academic", "Food", "Religious", "Special Task", "Sports", "Welfare"]
    @State var selectedExcoDigit: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title of Notice", text: $newNotice.Title)
                    
                    Picker(selection: $selectedExcoDigit, label: Text("Exco")) {
                        ForEach(0 ..< excos.count) {
                            Text(excos[$0])
                        }.onChange(of: selectedExcoDigit, perform: { (value) in
                                    newNotice.Exco = excos[value] })
                    }.pickerStyle(DefaultPickerStyle())
                    
                }
                
                Section (header: Text("Message")) {
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
                    NoticeCardView(thisNotice: newNotice.noticeWithRandomTimeStamp())
                        .offset(x: -12, y: 0)
                }.onAppear(perform: {
                    newNotice.Exco = "General"
                })
                
            }.navigationBarTitle("New Notice", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 22, height: 22)
                },
                trailing: Button(action: {
                    FBNotice.uploadNewNotice(newNotice: newNotice) { (result) in
                        switch result {
                        case .failure (let error):
                            errorMessage = error.localizedDescription
                            showErrorMessage = true
                        case .success(_):
                            break
                        }}
                    
                    isPresented = false
                    newNotice = Notice()
                    
                }) {
                    Text("Upload")
                })
        }
    }
}
