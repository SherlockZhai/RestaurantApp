//
//  TableListViewModel.swift
//  demo
//
//  Created by Starry on 2024/5/9.
//

import SwiftUI

class TableListViewModel: ObservableObject {
    
    
    @Published var dataArray: [TableInfo] = []
    @Published var orderList: [OrderInfo] = []
    @Published var user: User = User(id: 0, account: "", phone: "")
    
    @Published var errorMessage: String = ""
    
    func loadData() {
        fetchData()
    }
    
    func gotoLogin(account: String,password: String) {
        // URL of your server endpoint
        let url = URL(string: Config.domain + "/public/admin/front/userLogin")!
        
        // JSON data to be sent in the request body
        let requestData: [String: Any] = [
            "account": account,
            "password": password
            // Add other data as needed
        ]
        
        // Convert data to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            print("Error converting data to JSON")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a data task for the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                //let resp = try JSONDecoder().decode(String.self, from: data)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(json)
                    if json["errorCode"] as! Int == 0 {
                        guard let user = json["data"] as? [String: Any] else {
                            return
                        }
                        let id = user["id"] as? Int ?? 0
                        let account = user["account"] as? String ?? ""
                        let name = user["name"] as? String ?? ""
                        let phone = user["phone"] as? String ?? ""
                        
                        var u = User(id: id, account: account, phone: phone)
                        u.name = name
                        DispatchQueue.main.async {
                            self.errorMessage = ""
                            self.user = u
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.errorMessage = "Accout or Password is Error!"
                        }
                    }
                } else {
                        print("Failed to parse JSON")
                }
            } catch let error as NSError {
                print("Error post", error.localizedDescription)
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    
    private func fetchData() {
        // URL of your server endpoint
        let url = URL(string: Config.domain + "/public/admin/front/getAllTable")!
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a data task for the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if response != nil {
                //print(response)
            }
            
            guard let data = data else { return }
            
            
            do {
                //let resp = try JSONDecoder().decode(String.self, from: data)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let dataArray = json["data"] as? [[String: Any]] else {
                        return
                    }
                    DispatchQueue.main.async {
                        
                        var tableInfoArray: [TableInfo] = []
                        for item in dataArray {
                            print(item)
                            let id = item["id"] as? Int
                            let status = item["status"] as? Int
                            let table_no = item["table_no"] as? String
                            let add_time = item["add_time"] as? Date
                            let sort = item["sort"] as? Int
                            let tableInfo = TableInfo(id: id ?? 1, table_no: table_no ?? "", status: status ?? 1, add_time: add_time ?? Date(), sort: sort ?? 1)
                            
                            tableInfoArray.append(tableInfo)
                            
                        }
                        self.dataArray = tableInfoArray
                        
                    }
                } else {
                    print("Failed to parse JSON")
                }
            } catch let error as NSError {
                print("Error post", error.localizedDescription)
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    func booking(id: Int,table_no: String,userId:Int, phone:String,appointment_time: Date) {
        // URL of your server endpoint
        let url = URL(string: Config.domain + "/public/admin/front/addOrder")!
        
        let requestData: [String: Any] = [
            "user_id": userId,
            "phone": phone,
            "appointment_time": ISO8601DateFormatter().string(from: appointment_time),
            "table_id": id,
            "table_no": table_no
            // Add other data as needed
        ]
        
        // Convert data to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            print("Error converting data to JSON")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a data task for the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
           
            do {
                //let resp = try JSONDecoder().decode(String.self, from: data)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(json)
                    if json["errorCode"] as! Int == 0 {
                        self.fetchData()
                    }else{
                        
                    }
                } else {
                        print("Failed to parse JSON")
                }
            } catch let error as NSError {
                print("Error post", error.localizedDescription)
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    func cancelBooking(id: Int) {
        // URL of your server endpoint
        let url = URL(string: Config.domain + "/public/admin/front/cancelOrder")!
        
        let requestData: [String: Any] = [
            "id": id
        ]
        
        // Convert data to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            print("Error converting data to JSON")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a data task for the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            
            do {
                //let resp = try JSONDecoder().decode(String.self, from: data)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if json["errorCode"] as! Int == 0 {
                        self.loadOrderList(userId: self.user.id )
                    }else{
                        
                    }
                } else {
                        print("Failed to parse JSON")
                }
            } catch let error as NSError {
                print("Error post", error.localizedDescription)
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    func loadOrderList(userId: Int) {
        // URL of your server endpoint
        let url = URL(string: Config.domain + "/public/admin/front/getAllOrderByUser")!
        
        let requestData: [String: Any] = [
            "user_id": userId
        ]
        
        // Convert data to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            print("Error converting data to JSON")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a data task for the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            
            do {
                //let resp = try JSONDecoder().decode(String.self, from: data)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let dataArray = json["data"] as? [[String: Any]] else {
                        return
                    }
                    
                    
                    var orderArray: [OrderInfo] = []
                    for item in dataArray {
                        print(item)
                        let appointment_time = item["appointment_time"] as? String
                        if let date = ISO8601DateFormatter().date(from: appointment_time ?? "") {
                            let id = item["id"] as? Int
                            let user_id = item["user_id"] as? Int
                            let order_num = item["order_num"] as? String
                            let table_no = item["table_no"] as? String
                            let add_time = item["add_time"] as? Date
                            let status = item["status"] as? Int
                            let table_id = item["table_id"] as? Int
                            
                            let order = OrderInfo(id: id ?? 0, order_num: order_num ?? "", table_id: table_id ?? 0, table_no: table_no ?? "", status: status ?? 0, user_id: user_id ?? 0, appointment_time: date, add_time: add_time ?? Date())
                            
                            print("tableInfo")
                            orderArray.append(order)
                        } 
                    }
                    DispatchQueue.main.async {
                        self.orderList = orderArray
                    }
                } else {
                    print("Failed to parse JSON")
                }
            } catch let error as NSError {
                print("Error post", error.localizedDescription)
            }
        }
        
        // Start the data task
        task.resume()
    }
}

