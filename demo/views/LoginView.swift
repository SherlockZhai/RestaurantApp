//
//  LoginView.swift
//  demo
//
//  Created by Starry on 2024/5/7.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: TableListViewModel
    @AppStorage("isLogin") var isLogin: Bool = false
    @Binding var showSignup: Bool
    
    @State private var account: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please Sign in to use")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25){
                LoginForm(icon: "at", hint: "Account", value: $account)
                
                LoginForm(icon: "lock", hint: "password", isPasswd: true,value: $password)
                    .padding(.top , 5)
                
                LoginButton(title: "Login", icon: "arrow.right") {
                    vm.gotoLogin(account: account, password: password)
                }
                .disabled(account.isEmpty || password.isEmpty)
                
                Text(vm.errorMessage).font(.body).foregroundColor(.red)
            }
            .padding(.top,20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6, content: {
                Text("Don't hava an account ? Please").foregroundColor(.gray)
                
                Button("SignUp") {
                    showSignup.toggle()
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
        .onChange(of: vm.user.id) { oldValue, newValue in
            if newValue != 0 {
                self.isLogin = true
            }
        }
    }
    
    
}


