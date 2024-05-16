//
//  SignupView.swift
//  demo
//
//  Created by Starry on 2024/5/7.
//

import SwiftUI

struct SignupView: View {
    
    @Binding var showSignup: Bool
    
    @State private var account: String = ""
    @State private var password: String = ""
    @State private var fullname: String = ""
    @State private var phone: String = ""
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            Button(action: {
                showSignup = false
            }, label: {
                Image(systemName: "arrow.left").font(.title2)
                    .foregroundColor(.gray)
            })
            .padding(.top, 10)
            
            
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top,25)
            
            Text("Please Sign up to use")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25){
                LoginForm(icon: "at", hint: "Account", value: $account)
                
                LoginForm(icon: "person", hint: "Full Name",value: $fullname)
                    .padding(.top , 5)
                
                LoginForm(icon: "phone", hint: "Phone", isPasswd: false,value: $phone)
                    .padding(.top , 5)
                
                LoginForm(icon: "lock", hint: "Password", isPasswd: true,value: $password)
                    .padding(.top , 5)
                
                
                
                LoginButton(title: "Continue", icon: "arrow.right") {
                    gotoSignup()
                }
                .disabled(account.isEmpty || password.isEmpty || fullname.isEmpty)
            }
            .padding(.top,20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6, content: {
                Text("You have an account ? Please").foregroundColor(.gray)
                
                Button("Login") {
                    showSignup = false
                }
                .fontWeight(.bold)
                .tint(.blue)
                 
            })
            .font(.callout)
            .frame(maxWidth: .infinity)
        })
        .padding(.vertical,20)
        .padding(.horizontal,25)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    func gotoSignup() {
        // URL of your server endpoint
        let url = URL(string: Config.domain + "/public/admin/front/userRegister")!
        
        // JSON data to be sent in the request body
        let requestData: [String: Any] = [
            "account": account,
            "password": password,
            "name": fullname,
            "phone": phone
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
            
            print(data)
            do {
                //let resp = try JSONDecoder().decode(String.self, from: data)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if json["errorCode"] as! Int == 0 {
                        self.showSignup = false
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
}

#Preview {
    ContentView()
}
