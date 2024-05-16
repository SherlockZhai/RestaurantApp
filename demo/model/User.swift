//
//  User.swift
//  demo
//
//  Created by Starry on 2024/5/9.
//

import SwiftUI

struct User: Identifiable,Codable {
    var id: Int
        var account: String
        var phone: String
    var add_time: Date = Date.now
    var password: String = ""
    var name: String = ""
    
    
    init(id: Int, account: String, phone: String) {
        self.id = id
        self.account = account
        self.phone = phone
    }
}


