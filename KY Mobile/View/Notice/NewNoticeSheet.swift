import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct NewNoticeSheet: View {
    @Binding var isPresented: Bool
    @Binding var newNotice: Notice
    
    let excos = ["General", "Academic", "Food", "Religious", "Special Task", "Sports", "Welfare"]
    @State var selectedExco = 0
    
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
                }.padding()
                
                // Message
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
                }.padding()
                
                // Exco
                VStack {
                    HStack {
                        VStack {
                            Text("Exco")
                                .modifier(MediumText(textColor: Color("Black")))
                        }
                        Spacer()
                    }
                    HStack {
                        VStack {
                            Picker(selection: $selectedExco, label: Text("Heading")) {
                                ForEach(0 ..< excos.count) {
                                    Text(self.excos[$0])
                                }
                            }.pickerStyle(WheelPickerStyle())
                        }
                        Spacer()
                    }
                }.padding()
                
                // Demo
                HStack {
                    VStack {
                        Text("Demo")
                            .modifier(MediumText(textColor: Color("Black")))
                    }
                    
                    Button(action: {
                        newNotice.Exco = excos[selectedExco]
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                    }
                    
                    Spacer()
                }.padding(.horizontal)
                .padding(.top)
                
                ZStack {
                    Color("VeryLightGrey")
                    
                    NoticeCardView(thisNotice: Notice(Title: newNotice.Title, Exco: "\(newNotice.Exco)", Body: newNotice.Body, TimeStamp: "1597666032353"))
                }.padding()
                
                
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
                    newNotice.TimeStamp = "\(Int(Date().timeIntervalSince1970 * 1000))"
                    uploadNewNotice(newNotice: newNotice) { (result) in
                        switch result {
                        case .failure (let error):
                            print(error)
                        case .success(_):
                            break
                        }}
                    
                    isPresented = false
                    newNotice = Notice(Title: "", Exco: "", Body: "", TimeStamp: "")
                    
                }) {
                    Text("Upload")
                })
        }
    }
}

func ConvNoticeToDict(notice: Notice) -> [String: Any] {
    let list: [String: Any] = ["Title": notice.Title,
                               "Exco": notice.Exco,
                               "Body": notice.Body,
                               "TimeStamp": notice.TimeStamp]
    return list
}


func uploadNewNotice(newNotice: Notice, completion: @escaping (Result<Bool, Error>) -> () ) {
    let reference = Firestore
        .firestore()
        .collection("Notice")
        .document(newNotice.TimeStamp)
    
    reference.setData(ConvNoticeToDict(notice: newNotice), merge: true) { (err) in
        if let err = err {
            completion(.failure(err))
            return
        }
        completion(.success(true))
    }
}
