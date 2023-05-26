//
//  Storage.swift
//  ChatGPT
//
//  Created by Danila Gorbunov on 25.04.2023.
//

import Foundation

struct Chathandler {
    static var context = PersistenceController.shared.container.viewContext
    
    static func createChat(message: String, role: String = "user", convo: Conversation) {
        let c  = Chat(context: context)
        c.message = message
        c.role = role
        c.date = Date()
        c.conv = convo
        
        Chathandler.save()
    }
    
    static func createConvo(name: String) {
        let c = Conversation(context: context)
        c.name = name
        Chathandler.save()
    }
    
    static func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    static func completeNetwork(convo: Conversation) async {
        do {
            let res = try await Network.fetchChat(chats: Chathandler.fetchAllChats())
            if !(res?.choice?.isEmpty ?? true) {
                Chathandler.createChat(
                    message: res?.choice?.first?.message?.content ?? "error",
                    role: "assistant",
                    convo: convo
                )
            }
        } catch {
            print(error)
        }
    }
    
    static func fetchAllChats() -> [Chat] {
        var c: [Chat] = []
        
        let fr = Chat.fetchRequest()
        fr.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            c = try context.fetch(fr)
        } catch {
            print(error)
        }
        return c
    }
}
