//
//  ChatView.swift
//  ChatGPT
//
//  Created by Danila Gorbunov on 25.04.2023.
//

import SwiftUI

struct ChatView: View {
    @FetchRequest var items: FetchedResults<Chat>
    @State var message = ""
    
    var convo: Conversation
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(items) { item in
                    MessageView(message: item)
                }
            }
            
            Spacer()
            
            HStack {
                TextField("message", text: $message)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Spacer()
                
                Button {
                    Chathandler.createChat(message: message, convo: convo)
                    
                    Task {
                        await Chathandler.completeNetwork(convo: convo)
                    }
                    message = ""
                } label: {
                    Image(systemName: "paperplane")
                        .padding(.trailing)
                }
            }
            .navigationTitle(Text(convo.name ?? ""))
        }
    }
}
