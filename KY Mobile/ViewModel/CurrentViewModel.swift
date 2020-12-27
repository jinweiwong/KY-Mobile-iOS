//
//  CurrentViewModel.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 21/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class CurrentViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    
    init() {
        getAllEvents()
    }
    
    func getAllEvents() {
        let docRef = Firestore.firestore().collection("Events")
        
        docRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                querySnapshot!.documentChanges.forEach { diff in
                    if diff.type == .added {
                        let Title = diff.document.data()["Title"] as? String
                        let FullDesc = diff.document.data()["ShortDesc"] as? String
                        let ShortDesc = diff.document.data()["ShortDesc"] as? String
                        let StartDate = diff.document.data()["StartDate"] as? String
                        let EndDate = diff.document.data()["EndDate"] as? String
                        let StartTime = diff.document.data()["StartTime"] as? String
                        let EndTime = diff.document.data()["EndTime"] as? String
                        let Venue = diff.document.data()["Venue"] as? String
                        let Cover = diff.document.data()["Cover"] as? String
                        let TimeStamp = diff.document.data()["timestamp"] as? String
                        
                        self.events.append(Event(Title: Title ?? "0",
                                                 FullDesc: FullDesc ?? "0",
                                                 ShortDesc: ShortDesc ?? "0",
                                                 StartDate: StartDate ?? "0",
                                                 EndDate: EndDate ?? "0",
                                                 StartTime: StartTime ?? "0",
                                                 EndTime: EndTime ?? "0",
                                                 Venue: Venue ?? "0",
                                                 Cover: Cover ?? "0",
                                                 TimeStamp: TimeStamp ?? "0"))
                        
                    }
                }
                
                self.events.sort {
                    $0.TimeStamp > $1.TimeStamp
                }
            }
        }
    }
}


//class StorageImage {
//    var currentImage: UIImage? = nil
//    
//    init(url: String) {
//        RetrieveImage(url: url)
//        print(url)
//    }
//
//    func RetrieveImage(url: String) {
//        let ref = Storage.storage().reference(forURL: url)
//        
//        ref.getData(maxSize: 1 * 16384 * 16384) {data, error in
//            if let error = error {
//                print("\(error)")
//            }
//            else {
//                print("successful")
//                self.currentImage = UIImage(data: data!)!
//            }
//        }
//    }
//}

//    func RetrieveImage(url: String) -> UIImage {
//        let ref = Storage.storage().reference(forURL: url)
//        var _data: Data? = nil
//
//        print("can")
//        ref.getData(maxSize: 1 * 4096 * 4096) {data, error in
//            if let error = error {
//                print("\(error)")
//                print("There was an error")
//                return
//            }
//            else {
//                print("successful")
//                _data = data!
//            }
//        }
//        print("can")
//        return UIImage(data: _data!)!
//    }

//func downloadImages(url: String) -> String {
//
//    let reference = Storage.storage().reference(forURL: url)
//    reference.getData(maxSize: (1 * 4096 * 4096)) { (data, error) in
//
//        if let error = error{
//            print(error)
//        }
//        
//        else {
//            if let _data  = data {
//                return UIImage(data: _data)
//            }
//        }
//    }
//}

//struct StorageImage: View {
//
//    let url: String = "https://firebasestorage.googleapis.com/v0/b/ky-mobile.appspot.com/o/Events%2FEventCovers_1590212840278?alt=media&token=277d4096-eae7-41c3-9082-a73894d1b6fa"
//    var img: UIImage?
//    var error: Error
//
//    init() {
//        downloadImages(url: url,
//                       success: { (img) in
//                        self.img = img
//                       }) { (error) in
//            self.error = error
//        }
//    }
//
//    func downloadImages(url: String,
//                        success: @escaping (_ image: UIImage) -> (),
//                        failure: @escaping (_ error: Error) -> () ){
//
//        let reference = Storage.storage().reference(forURL: url)
//        reference.getData(maxSize: (1 * 4096 * 4096)) { (data, error) in
//            if let _error = error{
//                print(_error)
//                failure(_error)
//
//            } else {
//                if let _data  = data {
//                    let myImage:UIImage! = UIImage(data: _data)
//                    success(myImage)
//                }
//            }
//        }
//    }
//
//    var body: some View {
//        Image(uiImage: self.img!)
//    }
//}




