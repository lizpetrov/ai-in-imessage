//
//  ContentView.swift
//  AI Messages
//
//  Created by Elizabeth Petrov on 4/28/23.
//

import SwiftUI
import Resolver

struct MessagesView: View {
    
    @InjectedObject var messageGod: MessageGod
    
    @State var whoSelected: MessageSender = .me
    
    @State var settingsOpen: Bool = false
    
    var body: some View {
        VStack {
            
            VStack {
                Spacer().frame(height: 30)
                // top bar
                HStack(alignment: .center) {
                    // left arrow
                    Image(systemName: "chevron.left")
                        .font(Constants.topBarIcons)
                        .foregroundColor(Constants.iosBlue)
                    
                    Spacer()
                    
                    // name and pic
                    VStack(alignment: .center, spacing: 3) {
                        // image
                        
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(.gray)
                            
                            Text("AI").foregroundColor(.white).font(.system(size: 22, weight: .semibold, design: .rounded))
                        }
                        .frame(width: 50, height: 50)
                        
                        HStack(spacing: 2) {
                            Text("Friend").font(Constants.nameInMessage).foregroundColor(.black)
                                
                            Image(systemName: "chevron.right")
                                .font(Constants.nameInMessage)
                                .foregroundColor(Constants.iosMidGray)
                        }
                        .onTapGesture {
                            // OPEN UP SETTINGS
                            self.settingsOpen.toggle()
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "video")
                        .font(Constants.topBarIcons)
                        .foregroundColor(Constants.iosBlue)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
                
                
            }
            .background(Color.white
            .shadow(radius: 1) )
            

            ScrollView(showsIndicators: false) {
                ScrollViewReader { value in
                    
                    ForEach(messageGod.messages, id: \.id) { message in
                        
                        HStack {
                            if message.sender == .me {
                                Spacer()
                            }
                            
                            MessageView(message: message)
                            
                            if message.sender == .you {
                                Spacer()
                            }
                        }
                        .padding(.vertical, 1)
                        .padding(.horizontal, 15)
                        
                    }
                    .onChange(of: messageGod.messages.count) { _ in
                        value.scrollTo(messageGod.messages.count - 1)
                    }
                    
                    VStack(alignment: .center, spacing: 10) {
                        
                        // SHARED GOES HERE
                        if messageGod.sharedAIRec != "" && messageGod.sharedOn {
                            SharedAIView()
                        }
                        
                        // PERSONAL GOES HERE
                        if messageGod.personalAIRec != "" && messageGod.personalOn {
                            PersonalAIView()
                        }
                        
                        if messageGod.friendAIRec != "" && messageGod.friendOn {
                            FriendAIView()
                        }
                    }
                }
            }
            
            // ADDING IN MESSAGES!
            
            HStack(alignment: .bottom, spacing: 5) {
                Image(systemName: "camera.fill")
                    .font(Constants.iconMessageText)
                    .foregroundColor(Constants.iosMidGray)
                    .padding(.bottom, 5)
                    .onTapGesture {
                        messageGod.reloadMessages()
                    }
                
                HStack(alignment: .center, spacing: 5) {
                    TextField("iMessage", text: $messageGod.newMessage, axis: .vertical)
        //                .textFieldStyle(.roundedBorder)
                        .font(Constants.messageText)
                        
                    
                    Spacer()
                    
                    if messageGod.newMessage.isEmpty {
                        Image(systemName: "mic")
                            .font(Constants.iconMessageText)
                            .foregroundColor(Constants.iosMidGray)
                            .onTapGesture {
                                hideKeyboard()
                            }
                    }
                    else {
                        
                        HStack {
                            
                            Image(systemName: "arrow.up.circle.fill")
                                .font(Constants.iconMessageText)
                                .foregroundColor(Constants.iosLightGray)
                                .onTapGesture {
                                    // ADD IN THE MESSAGE!!!
                                    messageGod.addMessage(from: .you, message: messageGod.newMessage)
                                    
                                    messageGod.newMessage = ""
                                    
                                }
                            
                            Image(systemName: "arrow.up.circle.fill")
                                .font(Constants.iconMessageText)
                                .foregroundColor(Constants.iosBlue)
                                .onTapGesture {
                                    // ADD IN THE MESSAGE!!!
                                    messageGod.addMessage(from: .me, message: messageGod.newMessage)
                                    
                                    messageGod.newMessage = ""
                                    
                                }
                        }
                       
                    }
                   
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Constants.iosMidGray, lineWidth: 0.5)
                )

            }
            .padding(.horizontal, 15)
            .padding(.vertical, 2)
            
            Spacer().frame(height: 30)

        }
        .adaptsToKeyboard()
        .ignoresSafeArea(.all)
        .onAppear {
            
            messageGod.reloadMessages()
        }
        .sheet(isPresented: $settingsOpen) {
            MessageSettings()
        }
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
