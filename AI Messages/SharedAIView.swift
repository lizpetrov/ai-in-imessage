//
//  SharedAIView.swift
//  AI Messages
//
//  Created by Elizabeth Petrov on 4/29/23.
//

import SwiftUI
import Resolver

struct SharedAIView: View {
    @InjectedObject var messageGod: MessageGod

    var body: some View {
        HStack {

            Spacer()

            VStack(alignment: .center, spacing: 2) {

                Text("Siri Suggestion")
                    .lineLimit(1)
                    .font(Constants.inlineMessageDetailThin)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)

                Text(messageGod.sharedAIRec.trimmingCharacters(in: .whitespacesAndNewlines))
                    .lineLimit(nil)
                    .font(Constants.inlineMessageDetail)
                    .foregroundColor(.orange)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.orange, lineWidth: 2)
                )


            Spacer()

        }
        .frame(minWidth: 0, maxWidth: 250)
    }
}


//
//struct SharedAIView: View {
//
//    @InjectedObject var messageGod: MessageGod
//
//    var body: some View {
//        HStack {
//
//            Spacer()
//
//            VStack(alignment: .center, spacing: 2) {
//                Text("Siri Suggestion")
//                    .lineLimit(nil)
//                    .font(Constants.inlineMessageDetailThin)
//                    .foregroundColor(.orange)
//                    .fixedSize(horizontal: false, vertical: true)
//                    .multilineTextAlignment(.center)
//
//                Text(messageGod.sharedAIRec)
//                    .lineLimit(nil)
//                    .font(Constants.inlineMessageDetail)
//                    .foregroundColor(.orange)
//                    .fixedSize(horizontal: false, vertical: true)
//                    .multilineTextAlignment(.center)
//            }
//
//            Spacer()
//
//        }
//        .frame(minWidth: 0, maxWidth: 250)
//    }
//}
