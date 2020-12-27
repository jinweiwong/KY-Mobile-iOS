//
//  NoticesModel.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 22/09/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation

struct Notice: Identifiable {
    var id = UUID()
    var Title: String
    var Exco: String
    var Body: String
    var TimeStamp: String
}
