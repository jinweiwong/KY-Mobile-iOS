import Foundation
import SwiftUI

struct NewEvent: Identifiable {
    
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
    
    var id = UUID()
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
        self.id = UUID()
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
    
    // Convert newEvent to Event
    // Dates are changed to DD/MM/YYYY
    // Times are changed to HH:MM (24-hour time)
    // TimeStamp is changed to Epoch Time
    func convertAllToString() -> Event {
        return Event(Title: self.Title,
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
