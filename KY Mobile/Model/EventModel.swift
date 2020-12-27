//
//  EventModel.swift
//  KY Mobile
//
//  Created by Wong Jin Wei on 27/12/2020.
//

import Foundation

struct Event: Identifiable {
    var id = UUID()
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
}
