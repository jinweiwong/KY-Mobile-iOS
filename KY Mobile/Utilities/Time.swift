import Foundation
import SwiftUI

// DayTimeString --> DayDateTime
func DateTimeStringToDayDateTime(date: String, time: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.dateFormat = "dd/MM/yyyy'/'HH:mm"
    
    let dateString = date + "/" + time
    let dateFromString = dateFormatter.date(from: dateString)
    dateFormatter.dateFormat = "dd MMM YYYY',' EEEE',' h:mm a"
    
    if dateFromString == nil {
        return "-"
    }
    else {
        return dateFormatter.string(from: dateFromString!)
    }
    
}

// EpochTime --> DayDateTime
func EpochTimeToDayDateTime(epochTime: String) -> String {
    let date = Date(timeIntervalSince1970: Double((Double(epochTime)! / 1000)))
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM YYYY 'at' h:mm a"
    
    return dateFormatter.string(from: date)
}

// EpochTime --> TimeInterval
func EpochTimeToTimeInterval(epochTime: String) -> String {
    
    let pastDate = Date(timeIntervalSince1970: Double((Double(epochTime)! / 1000)))
    let currentDate = Date()
    let dateFormatterYear = DateFormatter()
    let dateFormatterMonth = DateFormatter()
    let dateFormatterDay = DateFormatter()
    
    dateFormatterYear.dateFormat = "d MMM YY"
    dateFormatterMonth.dateFormat = "d MMM"
    dateFormatterDay.dateFormat = "EEEE"
    
    let dateDifference = Calendar.current.dateComponents(
        [Calendar.Component.year,
         Calendar.Component.month,
         Calendar.Component.day,
         Calendar.Component.hour,
         Calendar.Component.minute],
        from: pastDate, to: currentDate)
    
    if dateDifference.year! > 0 {
        return "\(dateFormatterYear.string(from: pastDate))"
    }
    
    else if dateDifference.month! > 0 {
        return "\(dateFormatterMonth.string(from: pastDate))"
    }
    
    else if dateDifference.day! > 0 {
        if dateDifference.day! == 1 {
            return "Yesterday"
        }
        else if dateDifference.day! < 7 {
            return "\(dateFormatterDay.string(from: pastDate))"
        }
        
        else if dateDifference.day! / 7 == 1 {
            return "Last \(dateFormatterDay.string(from: pastDate))"
        }
        
        else {
            return "\(dateDifference.day! / 7) weeks"
        }
    }
    
    else if dateDifference.hour! > 0 {
        return "\(dateDifference.hour!) hr"
    }
    
    else if dateDifference.minute! > 0 {
        return "\(dateDifference.minute!) min"
    }
    
    else {
        return "Just now"
    }
}

// date: DD/MM/YYYY
// time: HH:MM
// Used mainly for posts
func DateTimeToDate(date: String?, time: String?) -> Date {
    let dateFormatter = DateFormatter()
    
    if date == "" {
        return Date()
    } else if time == "" {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: date!)!
    } else {
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateTime = "\(date!) \(time!)"
        return dateFormatter.date(from: dateTime)!
    }
}
