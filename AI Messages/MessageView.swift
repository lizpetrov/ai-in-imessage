//
//  MessageView.swift
//  AI Messages
//
//  Created by Elizabeth Petrov on 4/28/23.
//

import SwiftUI

struct MessageView: View {
    
    var message: Message
    
    var body: some View {
        
        HStack {
            
            if message.sender == .me {
                Spacer()
            }
            
            Text(message.message)
                .lineLimit(nil)
                .font(Constants.messageText)
                .foregroundColor(message.sender == .me ? .white : .black)
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
                .background(message.sender == .me ? Constants.iosBlue : Constants.iosLightGray)
                .cornerRadius(16)
                .fixedSize(horizontal: false, vertical: true)

            if message.sender == .you {
                Spacer()
            }
            
            
        }
        .frame(minWidth: 0, maxWidth: 250)
        
    }
}
