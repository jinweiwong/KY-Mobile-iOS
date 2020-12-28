import Foundation

struct NotificationModel: Identifiable {
    var id = UUID()
    var Title: String
    var TimeStamp: String // Epoch Time
    
    init() {
        self.Title = ""
        self.TimeStamp = ""
    }
    
    init(Title: String, TimeStamp: String) {
        self.Title = Title
        self.TimeStamp = TimeStamp
    }
}
