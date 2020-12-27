//
//  Date.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 22/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI

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
