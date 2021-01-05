import Foundation
import SwiftUI

struct NewPost {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var UUID: String
    var Title: String
    var FullDesc: String
    var ShortDesc: String
    var Start: Date
    var End: Date
    var Venue: String
    var Cover: UIImage
    var CoverString: String // URL to Firebase Storage
    var TimeStamp: Date
    
    init() {
        self.UUID = Foundation.UUID().uuidString
        self.Title = ""
        self.FullDesc = ""
        self.ShortDesc = ""
        self.Start = Date()
        self.End = Date()
        self.Venue = ""
        self.Cover = UIImage()
        self.CoverString = ""
        self.TimeStamp = Date()
    }
    
    init(UUID: String, Title: String, FullDesc: String, ShortDesc: String, Start: Date, End: Date, Venue: String, Cover: UIImage, CoverString: String, TimeStamp: Date) {
        self.UUID = UUID
        self.Title = Title
        self.FullDesc = FullDesc
        self.ShortDesc = ShortDesc
        self.Start = Start
        self.End = End
        self.Venue = Venue
        self.Cover = Cover
        self.CoverString = CoverString
        self.TimeStamp = TimeStamp
    }
    
    
    
    // Convert newPost to Post
    // Dates are changed to DD/MM/YYYY
    // Times are changed to HH:MM (24-hour time)
    // TimeStamp is changed to Epoch Time
    func convertAllToString() -> Post {
        return Post(UUID: self.UUID,
                    Title: self.Title,
                    FullDesc: self.FullDesc,
                    ShortDesc: self.ShortDesc,
                    StartDate: dateFormatter.string(from: self.Start),
                    EndDate: dateFormatter.string(from: self.End),
                    StartTime: timeFormatter.string(from: self.Start),
                    EndTime: timeFormatter.string(from: self.End),
                    Venue: self.Venue,
                    Cover: self.CoverString,
                    TimeStamp: "\(Int(self.TimeStamp.timeIntervalSince1970 * 1000))")
    }
}
