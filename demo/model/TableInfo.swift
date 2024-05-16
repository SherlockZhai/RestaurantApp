//
//  TableInfo.swift
//  demo
//
//  Created by Starry on 2024/5/9.
//

import SwiftUI

struct TableInfo: Identifiable,Decodable {
        var id: Int
            var table_no: String
            var status: Int
    var add_time:Date = Date.now
    var sort: Int
    
    init(id: Int, table_no: String, status: Int, add_time: Date, sort: Int) {
        self.id = id
        self.table_no = table_no
        self.status = status
        self.add_time = add_time
        self.sort = sort
    }
}
