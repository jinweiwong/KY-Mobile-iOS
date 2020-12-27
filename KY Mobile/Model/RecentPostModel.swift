//
//  RecentPostModel.swift
//  KY Mobile
//
//  Created by Wong Jin Wei on 27/12/2020.
//

import Foundation

struct RecentPost: Identifiable {
    var id = UUID()
    var Title: String
    var TimeStamp: String  // Epoch Time
}
