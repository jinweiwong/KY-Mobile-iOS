//
//  NoticeModel.swift
//  KY Mobile
//
//  Created by Wong Jin Wei on 27/12/2020.
//

import Foundation

struct Notice: Identifiable {
    var id = UUID()
    var Title: String
    var Exco: String  // eg. Academic, Welfare, General
    var Body: String
    var TimeStamp: String  // Epoch Time
}
