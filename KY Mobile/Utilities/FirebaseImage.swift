//import SwiftUI
//import Combine
//import FirebaseStorage
//
//final class Loader : ObservableObject {
//    let didChange = PassthroughSubject<Data?, Never>()
//    var data: Data? = nil {
//        didSet { didChange.send(data) }
//    }
//    
//    init(_ url: String){
//        let ref = Storage.storage().reference(forURL: url)
//        
//        ref.getData(maxSize: 1 * 4096 * 4096) { data, error in
//            if let error = error {
//                print("\(error)")
//            }
//            
//            DispatchQueue.main.async {
//                self.data = data
//            }
//        }
//    }
//}
//
//let placeholder = UIImage(named: "placeholder.jpg")!
//
//struct FirebaseImage : View {
//    
//    init(url: String) {
//        self.imageLoader = Loader(url)
//    }
//    
//    @ObservedObject private var imageLoader : Loader
//    
//    var image: UIImage {
//        UIImage(data: imageLoader.data!)!
//    }
//  
//    var body: some View {
//        Image(uiImage: image)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//        
//    }
//}
