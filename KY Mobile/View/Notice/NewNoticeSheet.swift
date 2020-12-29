import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct NewNoticeSheet: View {
    @Binding var isPresented: Bool
    @Binding var newNotice: Notice
    
    @Binding var errorMessage: String
    @Binding var showErrorMessage: Bool
    
    let excos: [String] = ["General", "Academic", "Food", "Religious", "Special Task", "Sports", "Welfare"]
    @State var selectedExcoDigit: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                title
                exco
                message
                demo
                    .padding(.bottom)
                
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
                    FBService.uploadNewNotice(newNotice: newNotice) { (result) in
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
                        TextField("Title of Event", text: $newNotice.Title)
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
    
    
    var exco: some View {
        VStack {
//            HStack {
//                VStack {
//                    Text("Exco")
//                        .modifier(MediumText(textColor: Color("Black")))
//                }
//                Spacer()
//            }
            
            HStack {
                VStack {
                    Picker(selection: $selectedExcoDigit, label: Text("Heading")) {
                        ForEach(0 ..< excos.count) {
                            Text(self.excos[$0])
                        }.onChange(of: selectedExcoDigit, perform: { (value) in
                                    newNotice.Exco = excos[value] })
                    }.pickerStyle(WheelPickerStyle())
                }
                Spacer()
            }
        }.padding(.horizontal)
    }
    
    
    var message: some View {
        VStack {
            HStack {
                VStack {
                    Text("Message")
                        .modifier(MediumText(textColor: Color("Black")))
                }
                Spacer()
            }
            HStack {
                VStack {
                    if #available(iOS 14.0, *) {
                        TextEditor(text: $newNotice.Body)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
                            .cornerRadius(10)
                            .border(Color("LightGrey"), width: 1)
                    }
                }
                Spacer()
            }
        }.padding(.horizontal)
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
            
            ZStack {
                
                //Color("VeryLightGrey")
                NoticeCardView(thisNotice: newNotice.noticeWithRandomTimeStamp())
                
            }.padding(.horizontal)
        }
    }
}
