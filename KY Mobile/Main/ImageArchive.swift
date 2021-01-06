import Foundation
import SwiftUI

class ImageArchive: ObservableObject {
    @Published var archive: [String: UIImage]
    
    enum ArchiveModification {
        case add, replace, remove
    }
    
    init() {
        self.archive = ["": UIImage()]
    }
    
    func uiImageFromURL(id: String, url: String) -> UIImage {
        if let uiImage = self.archive[id] {
            return uiImage
        } else {
            do {
                guard let url = URL(string: url) else {
                    self.archive[id] = UIImage()
                    return UIImage()
                }
                
                print("Downloading for \(id)...")
                let data: Data = try Data(contentsOf: url)
                
                guard let uiImage = UIImage(data: data) else {
                    self.archive[id] = UIImage()
                    return UIImage()
                }
                
                self.archive[id] = uiImage
                return uiImage
                
            } catch {
                self.archive[id] = UIImage()
                return UIImage()
            }
        }
    }
    
    func modifyImageArchive(id: String, uiImage: UIImage? = UIImage(), _ modification: ArchiveModification) -> () {
        switch modification {
        case .add:
            self.archive[id] = uiImage
            
        case .replace:
            self.archive[id] = uiImage
            
        case .remove:
            self.archive[id] = UIImage()
        }
        
        print(self.archive)
    }
}


//struct imageFromURL: View {
//    
//    @ObservedObject var downloadedImages: DownloadedImages
//    let id: String
//    let url: String
//    
//    var body: some View {
//        Image(uiImage: downloadedImages.uiImageFromURL(id: id, url: url))
//    }
//}
