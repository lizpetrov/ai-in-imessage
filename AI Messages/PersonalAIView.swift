//
//  PersonalAIView.swift
//  AI Messages
//
//  Created by Elizabeth Petrov on 4/29/23.
//

import SwiftUI
import Resolver

struct PersonalAIView: View {
    
    @InjectedObject var messageGod: MessageGod
    
    var body: some View {
        HStack {
            
            Spacer()
            
            VStack(alignment: .center, spacing: 2) {
                Text("Siri Suggested Text")
                    .lineLimit(nil)
                    .font(Constants.inlineMessageDetailThin)
                    .foregroundColor(.blue)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                Text(messageGod.personalAIRec)
                    .lineLimit(nil)
                    .font(Constants.inlineMessageDetail)
                    .foregroundColor(.blue)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            }

            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: 250)
        .onTapGesture {
            messageGod.newMessage = messageGod.personalAIRec
        }
    }
}
