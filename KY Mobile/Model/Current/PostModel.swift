import Foundation
import SwiftUI

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
    
    init?(postDict: [String: Any]) {
        self.UUID = postDict["UUID"] as? String ?? ""
        self.Title = postDict["Title"] as? String ?? ""
        self.FullDesc = postDict["FullDesc"] as? String ?? ""
        self.ShortDesc = postDict["ShortDesc"] as? String ?? ""
        self.StartDate = postDict["StartDate"] as? String ?? ""
        self.EndDate = postDict["EndDate"] as? String ?? ""
        self.StartTime = postDict["StartTime"] as? String ?? ""
        self.EndTime = postDict["EndTime"] as? String ?? ""
        self.Venue = postDict["Venue"] as? String ?? ""
        self.Cover = postDict["Cover"] as? String ?? ""
        self.TimeStamp = postDict["TimeStamp"] as? String ?? ""
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
    
    func postToNewPost() -> NewPost {
        return NewPost(UUID: self.UUID,
                       Title: self.Title,
                       FullDesc: self.FullDesc,
                       ShortDesc: self.ShortDesc,
                       Start: DateTimeToDate(date: self.StartDate, time: self.StartTime),
                       End: DateTimeToDate(date: self.EndDate, time: self.EndTime),
                       Venue: self.Venue,
                       Cover: UIImage(),
                       CoverString: self.Cover,
                       TimeStamp: Date(timeIntervalSince1970: Double((Double(self.TimeStamp)! / 1000))))
    }
}

