//
//  LoginForm.swift
//  demo
//
//  Created by Starry on 2024/5/7.
//

import SwiftUI

struct LoginForm: View {
    
    var icon: String
    var iconTint: Color = .gray
    var hint: String
    var isPasswd: Bool = false
    @Binding var value: String
    @State private var showPasswd: Bool = false
    
    var body: some View {
        HStack(alignment: .top,spacing: 8, content: {
            Image(systemName: icon)
                .foregroundColor(iconTint)
                .frame(width: 30)
                .offset(y :2)
            
            VStack(alignment:.leading,spacing: 8) {
                if isPasswd {
                    Group{
                        if showPasswd {
                            TextField(hint, text: $value)
                        } else {
                            SecureField(hint, text: $value)
                        }
                    }
                }else{
                    TextField(hint, text: $value)
                }
                
                Divider()
            }
            .overlay(alignment: .trailing) {
                if isPasswd {
                    Button {
                        withAnimation {
                            showPasswd.toggle()
                        }
                    } label: {
                        Image(systemName: showPasswd ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    }
                }
            }
        })
    }
}


