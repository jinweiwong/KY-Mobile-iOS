import Foundation
import SwiftUI

struct NewNotice {
    
    var UUID: String
    var Title: String
    var Exco: String  // eg. Academic, Welfare, General
    var Body: String
    var TimeStamp: Date  // Epoch Time
    
    init() {
        self.UUID = Foundation.UUID().uuidString
        self.Title = ""
        self.Exco = ""
        self.Body = ""
        self.TimeStamp = Date()
        
    }
    
    // Convert newPost to Post
    // Dates are changed to DD/MM/YYYY
    // Times are changed to HH:MM (24-hour time)
    // TimeStamp is changed to Epoch Time
    func convertAllToString() -> Notice {
        return Notice(UUID: self.UUID,
                      Title: self.Title,
                      Exco: self.Exco,
                      Body: self.Body,
                      TimeStamp: "\(Int(self.TimeStamp.timeIntervalSince1970 * 1000))")
    }
}
