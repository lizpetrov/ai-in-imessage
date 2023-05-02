//
//  MessageSettings.swift
//  AI Messages
//
//  Created by Elizabeth Petrov on 4/28/23.
//

import SwiftUI
import Resolver

/// message settings screen
struct MessageSettings: View {
    
    @InjectedObject var messageGod: MessageGod
    
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                
                HStack {
                    Spacer()
                    
                    Text("Done")
                        .foregroundColor(.blue)
                        .font(Constants.messageText).bold()
                }
                
                // face and name
                VStack(alignment: .center, spacing: 7) {
                    // image
                    
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(.gray)
                        
                        Text("AI").foregroundColor(.white).font(.system(size: 35, weight: .semibold, design: .rounded))
                    }
                    .frame(width: 80, height: 80)
                    
                    Text("Friend").font(.title).bold().foregroundColor(.black)
                    
                }
                
                // bar of calls and such - not needed
                
                
                // AI Suggestions
                // shared
                VStack(alignment: .leading, spacing: 10) {
                    
                    Toggle(isOn: $messageGod.sharedOn) {
                        Text("Shared AI").bold()
                        //Spacer()
                    }
                    .tint(.orange)
                    
                    Text("This AI sits in your message thread and acts as a third participant, adding on to the conversation based on what you want it to do.")
                        .font(Constants.nameInMessage).italic()
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                    TextField("What does your shared AI do?", text: $messageGod.sharedDescription, axis: .vertical)
                        .font(Constants.messageText).bold()
                        .frame(height: 100)
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                
                // personal
                VStack(alignment: .leading, spacing: 10) {
                    
                    Toggle(isOn: $messageGod.personalOn) {
                        Text("Personal AI").bold()
                        //Spacer()
                    }
                    .tint(.blue)
                    
                    Text("This AI sees your messages and suggest replies for you based on what you want.")
                        .font(Constants.nameInMessage).italic()
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("What does your personal AI do?", text: $messageGod.personalDescription, axis: .vertical)
                        .font(Constants.messageText).bold()
                        .frame(height: 100)
                    
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                
                // friend
                VStack(alignment: .leading, spacing: 10) {
                    
                    Toggle(isOn: $messageGod.friendOn) {
                        Text("Friend's Personal AI").bold()
                        //Spacer()
                    }
                    .tint(.gray)
                    
                    Text("This AI sees your messages and suggest replies for you based on what you want.")
                        .font(Constants.nameInMessage).italic()
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("What does your friend's personal AI do?", text: $messageGod.friendDescription, axis: .vertical)
                        .font(Constants.messageText).bold()
                        .frame(height: 100)
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                
                
                
                Spacer()
            }
            
            // Demo Hacks
            // friend
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Text("Personal AI Demo").bold()
                    Spacer()
                }

                Text("Help me write the funniest text that will leave the other person laughing")
                    .font(Constants.messageText)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        messageGod.sharedOn = false
                        messageGod.sharedDescription = ""
                        
                        messageGod.friendOn = false
                        messageGod.friendDescription = ""
                        
                        messageGod.personalOn = true
                        messageGod.personalDescription = "Help me write the funniest text that will leave the other person laughing"
                    }
                
                Divider()
                                
                Text("Help me flirt with this person, I really like them")
                    .font(Constants.messageText)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        messageGod.sharedOn = false
                        messageGod.sharedDescription = ""
                        
                        messageGod.friendOn = false
                        messageGod.friendDescription = ""
                        
                        messageGod.personalOn = true
                        messageGod.personalDescription = "Help me flirt with this person, I really like them"
                    }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            
            // shared
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Text("Shared AI Demo").bold()
                    Spacer()
                }

                Text("Encourage us to meet up in real life, because face to face interactions are better!")
                    .font(Constants.messageText)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        messageGod.personalOn = false
                        messageGod.personalDescription = ""
                        
                        messageGod.friendOn = false
                        messageGod.friendDescription = ""
                        
                        messageGod.sharedOn = true
                        messageGod.sharedDescription = "Encourage us to meet up in real life, because face to face interactions are better!"
                    }
                
                Divider()
                                
                Text("Give us factual information on what we are conversing about")
                    .font(Constants.messageText)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        messageGod.personalOn = false
                        messageGod.personalDescription = ""
                        
                        messageGod.friendOn = false
                        messageGod.friendDescription = ""
                        
                        messageGod.sharedOn = true
                        messageGod.sharedDescription = "Give us factual information on what we are conversing about"
                    }
                
                Divider()
                
                Text("Ask us questions to keep the conversation flowing and help us bond")
                    .font(Constants.messageText)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        messageGod.personalOn = false
                        messageGod.personalDescription = ""
                        
                        messageGod.friendOn = false
                        messageGod.friendDescription = ""
                        
                        messageGod.sharedOn = true
                        messageGod.sharedDescription = "Ask us questions to keep the conversation flowing and help us bond"
                    }
                
                Divider()
                
                Text("We are a long distant couple, help us stay in touch.")
                    .font(Constants.messageText)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        messageGod.personalOn = false
                        messageGod.personalDescription = ""
                        
                        messageGod.friendOn = false
                        messageGod.friendDescription = ""
                        
                        messageGod.sharedOn = true
                        messageGod.sharedDescription = "We are a long distant couple, help us stay in touch."
                    }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            
            // both
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Text("AI <-> AI Demo").bold()
                    Spacer()
                }
                
                Text("Planning to meet - coffee vs dinner")
                    .font(Constants.messageText)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        messageGod.sharedOn = false
                        messageGod.sharedDescription = ""
                        
                        messageGod.friendOn = true
                        messageGod.friendDescription = "Help me plan times to meet in person with my friend, preferably over coffee"
                        
                        messageGod.personalOn = true
                        messageGod.personalDescription = "Help me plan times to meet in person with my friend, preferably over dinner"
                    }
                
                Divider()

                Text("Unrequited love <3")
                    .font(Constants.messageText)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        messageGod.sharedOn = false
                        messageGod.sharedDescription = ""
                        
                        messageGod.friendOn = true
                        messageGod.friendDescription = "I know my friend likes me, but I only see them as a friend. Help me not break their heart."
                        
                        messageGod.personalOn = true
                        messageGod.personalDescription = "Help me flirt with this person, I really like them"
                    }
                
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            
        }
        .padding(15)
        .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
        
        // prompt for AI assistant - Shared
        // turn on switch
        
        // prompt for AI assistant - Personal
        // turn on switch
        
    }
}
