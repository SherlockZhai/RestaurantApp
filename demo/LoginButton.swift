//
//  LoginButton.swift
//  demo
//
//  Created by Starry on 2024/5/7.
//

import SwiftUI

struct LoginButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15){
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical,12)
            .padding(.horizontal, 35)
            .background(.linearGradient(colors: [.blue,.purple,.red], startPoint: .top, endPoint: .bottom),in: Capsule())
            
        })
    }
}

#Preview {
    ContentView()
}
