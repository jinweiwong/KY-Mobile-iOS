import Foundation

struct Post {
    var UUID: String
    var Title: String
    var FullDesc: String
    var ShortDesc: String
    var StartDate: String  // DD/MM/YYYY (12/02/2020)
    var EndDate: String
    var StartTime: String  // 24-hour time (19:54)
    var EndTime: String
    var Venue: String
    var Cover: String  // URL to Firebase Storage
    var TimeStamp: String  // Epoch Time
    
    init() {
        self.UUID = Foundation.UUID().uuidString
        self.Title = ""
        self.FullDesc = ""
        self.ShortDesc = ""
        self.StartDate = ""
        self.EndDate = ""
        self.StartTime = ""
        self.EndTime = ""
        self.Venue = ""
        self.Cover = "placeholder"
        self.TimeStamp = ""
    }
    
    init(UUID: String, Title: String, FullDesc: String, ShortDesc: String, StartDate: String, EndDate: String, StartTime: String, EndTime: String, Venue: String, Cover: String, TimeStamp: String) {
        self.UUID = UUID
        self.Title = Title
        self.FullDesc = FullDesc
        self.ShortDesc = ShortDesc
        self.StartDate = StartDate
        self.EndDate = EndDate
        self.StartTime = StartTime
        self.EndTime = EndTime
        self.Venue = Venue
        self.Cover = Cover
        self.TimeStamp = TimeStamp
    }
    
    func postToDict() -> [String: Any] {
        return ["UUID": self.UUID,
                "Title": self.Title,
                "FullDesc": self.FullDesc,
                "ShortDesc": self.ShortDesc,
                "StartDate": self.StartDate,
                "EndDate": self.EndDate,
                "StartTime": self.StartTime,
                "EndTime": self.EndTime,
                "Venue": self.Venue,
                "Cover": self.Cover,
                "TimeStamp": self.TimeStamp]
    }
}
