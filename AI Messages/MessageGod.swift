//
//  MessageGod.swift
//  AI Messages
//
//  Created by Elizabeth Petrov on 4/28/23.
//

import Foundation
import SwiftUI
import OpenAISwift



/// keeps track of everything :)
class MessageGod: ObservableObject {
    
    @Published var newMessage: String = ""
    
    // messages themselves
    @Published var messages: [Message] = []
    
    // AI ASSISTANT - TODO: this
    @Published var sharedDescription: String = ""
    @Published var sharedOn: Bool = false
    @Published var personalDescription: String =  ""
    @Published var personalOn: Bool = false
    
    @Published var friendDescription: String =  ""
    @Published var friendOn: Bool = false
    
    @Published var sharedAIRec: String = ""
    @Published var personalAIRec: String = ""
    @Published var friendAIRec: String = ""
    
    // openai
    let openAI = OpenAISwift(authToken: AI_MessagesApp.OPENAI_AUTH)


    func reloadMessages() {
        messages.removeAll()
        
        // add in initial messages!
        self.addMessage(from: .me, message: "hey, whats up?", passOverAI: true)

        self.addMessage(from: .you, message: "had a wild dream last night. what about you?", passOverAI: true)

        self.addMessage(from: .me, message: "omg! same here! in my dream, i was in a magical candy land with rivers of chocolate", passOverAI: true)

        self.addMessage(from: .you, message: "whoa, that sounds sweet! in mine, I was floating in space and having a chat with some friendly aliens", passOverAI: true)

        self.addMessage(from: .me, message: "thats out of this world! dreams can be so bizarre, but also fascinating", passOverAI: true)

        self.addMessage(from: .you, message: "yeahhh, they really are... maybe we should try to analyze what our dreams mean", passOverAI: true)

        self.addMessage(from: .me, message: "oooh! thats a wonderful idea", passOverAI: false)
        
        // should trigger the AI!
    }
    
    // message functions
    func addMessage(from: MessageSender, message: String, passOverAI: Bool = false) {
        let newM = Message(sender: from, message: message, id: messages.count)
        
        messages.append(newM)
        
        if passOverAI != true {
            querySharedAI()
            queryPersonalAI()
            queryFriendAI()

        }
    }
    
    func querySharedAI() {
        sharedAIRec = ""
        if sharedOn == false { return }
        
        // make the prompt
        var prompt: String = "You are a message assistant that sits in a message thread between me and my friend, and you can see all our messages. You operate as an assistant that either gives us advice or accurate factual information. You keep a goal in mind. You return your advice in the format of a short casual phrase with the audience being my friend and I. Make your response in third person.\n\nYour goal as a message assistant is as follows: "
        
        prompt += sharedDescription
        
        prompt += "\n\nExisting Message Thread:\n"
        prompt += self.getThreadString()
        
        prompt += "\n\nYour suggestion: "
        
        // OPENAI QUERY!
        openAI.sendCompletion(with: prompt,
                              model: .gpt3(.davinci),
                              maxTokens: 35,
                            temperature: 1) { result in // Result<OpenAI, OpenAIError>
            switch result {
            case .success(let success):
                let suggestion = (success.choices?.first?.text ?? "")
                
                DispatchQueue.main.async {
                    self.sharedAIRec = suggestion
                }
                print("AI SHARED:  \(suggestion)")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func queryPersonalAI() {
        personalAIRec = ""
        if personalOn == false { return }
        
        // make the prompt
        var prompt: String = "You are a message assistant that sits in a message thread between me and my friend, and you can see all our messages. You operate as my personal assistant and suggest text messages I can send that accomlish the goal I give you. You return your advice in the format of a short suggested text message that is in the style of my text messages. Keep it short and to the point. Follow the goal as closely as possible. Don't recommend redundant messages.\n\nYour goal as a message assistant is to suggest a message that matches my writing style, and, most importantly, does the following:  "
        
        prompt += personalDescription
        
        prompt += "\n\nExisting Message Thread:\n"
        prompt += self.getThreadString()
        
        prompt += "\n\nSuggested Response:\nMe: "
        
        print(prompt)
        
        // OPENAI QUERY!
        openAI.sendCompletion(with: prompt,
          model: .gpt3(.davinci),
          maxTokens: 25,
        temperature: 1
        ) { result in // Result<OpenAI, OpenAIError>
            switch result {
            case .success(let success):
                let suggestion = (success.choices?.first?.text ?? "")
                DispatchQueue.main.async {
                    self.personalAIRec = suggestion
                }
                print("AI PERSONAL:  \(suggestion)")
                print(success.choices)

            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func queryFriendAI() {
        friendAIRec = ""
        if friendOn == false { return }
        
        // make the prompt
        var prompt: String = "You are a message assistant that sits in a message thread between me and my friend, and you can see all our messages. You operate as my personal assistant and suggest text messages I can send that accomlish the goal I give you. You return your advice in the format of a short suggested text message that is in the style of my text messages. Keep it short and to the point. Follow the goal as closely as possible. Don't recommend redundant messages.\n\nYour goal as a message assistant is to suggest a message that matches my writing style, and, most importantly, does the following:  "
        
        prompt += friendDescription
        
        prompt += "\n\nExisting Message Thread:\n"
        prompt += self.getThreadString(pov: .you)
        
        prompt += "\n\nSuggested Response:\nMe: "
        
        print(prompt)
        
        // OPENAI QUERY!
        openAI.sendCompletion(with: prompt,
          model: .gpt3(.davinci),
          maxTokens: 25,
        temperature: 1
        ) { result in // Result<OpenAI, OpenAIError>
            switch result {
            case .success(let success):
                let suggestion = (success.choices?.first?.text ?? "")
                DispatchQueue.main.async {
                    self.friendAIRec = suggestion
                }
                print("AI FRIEND:  \(suggestion)")
                print(success.choices)

            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    /// returns the message thread in a form gpt can read
    func getThreadString(pov: MessageSender = .me) -> String {
    
        var thread: String = ""
        
        for message in messages {
            if pov == .me {
                thread += message.sender.string
            }
            else {
                thread += message.sender.oppositeString
            }
            thread += message.message
            thread += "\n"
        }
        
        return thread
    }
    
}


struct Message {
    var sender: MessageSender
    
    var message: String
    
    var id: Int
}

enum MessageSender {
    case me, you
    
    var string: String {
        switch self {
            
        case .me:
            return "Me: "
        case .you:
            return "Friend: "
        }
    }
    
    var oppositeString: String {
        switch self {
            
        case .me:
            return "Friend: "
        case .you:
            return "Me: "
        }
    }
}
