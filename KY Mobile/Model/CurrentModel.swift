//
//  CurrentModel.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 21/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation

struct Event: Identifiable {
    var id = UUID()
    var Title: String
    var FullDesc: String
    var ShortDesc: String
    var StartDate: String
    var EndDate: String
    var StartTime: String
    var EndTime: String
    var Venue: String
    var Cover: String
    var TimeStamp: String
}
