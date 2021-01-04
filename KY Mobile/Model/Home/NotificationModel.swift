import Foundation

struct NotificationModel {
    var UUID: String
    var Title: String
    var TimeStamp: String // Epoch Time
    
    init() {
        self.UUID = ""
        self.Title = ""
        self.TimeStamp = ""
    }
    
    init(UUID: String, Title: String, TimeStamp: String) {
        self.UUID = UUID
        self.Title = Title
        self.TimeStamp = TimeStamp
    }
}
