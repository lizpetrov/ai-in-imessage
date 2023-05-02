//
//  PersonalAIView.swift
//  AI Messages
//
//  Created by Elizabeth Petrov on 4/29/23.
//

import SwiftUI
import Resolver

struct FriendAIView: View {
    
    @InjectedObject var messageGod: MessageGod
    
    var body: some View {
        HStack {
            
            Spacer()
            
            VStack(alignment: .center, spacing: 2) {
                Text("Siri Suggested Text")
                    .lineLimit(nil)
                    .font(Constants.inlineMessageDetailThin)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                Text(messageGod.friendAIRec)
                    .lineLimit(nil)
                    .font(Constants.inlineMessageDetail)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            }

            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: 250)
        .onTapGesture {
            messageGod.newMessage = messageGod.friendAIRec
        }
    }
}
