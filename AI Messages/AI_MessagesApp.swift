//
//  AI_MessagesApp.swift
//  AI Messages
//
//  Created by Elizabeth Petrov on 4/28/23.
//

import SwiftUI
import Resolver

@main
struct AI_MessagesApp: App {
    
    // ADD IN YOUR OPENAI KEY BELOW
    static var OPENAI_AUTH: String = ""
    
    var body: some Scene {
        WindowGroup {
            MessagesView()
                .preferredColorScheme(.light)
        }
    }
}


extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    
    register { MessageGod() }.scope(.application)


  }
}
