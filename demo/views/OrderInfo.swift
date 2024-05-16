//
//  OrderInfo.swift
//  demo
//
//  Created by Starry on 2024/5/9.
//

import SwiftUI

struct OrderInfo: Identifiable ,Codable{
    
    var id: Int
    var order_num: String
    var table_id: Int
    var table_no: String
    var status:Int
    var user_id:Int
    var appointment_time:Date  = Date()
    var add_time:Date = Date()

    init(id: Int, order_num: String, table_id: Int, table_no: String, status: Int, user_id: Int, appointment_time: Date, add_time: Date) {
        self.id = id
        self.order_num = order_num
        self.table_id = table_id
        self.table_no = table_no
        self.status = status
        self.user_id = user_id
        self.appointment_time = appointment_time
        self.add_time = add_time
    }
}

