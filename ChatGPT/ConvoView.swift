//
//  ConvoView.swift
//  ChatGPT
//
//  Created by Danila Gorbunov on 25.04.2023.
//

import SwiftUI

struct ConvoView: View {
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \Conversation.name,
                ascending:  true
            )
        ],
        animation: .default
    )
    private var items: FetchedResults<Conversation>
    
    @State var sheet = false
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    ChatView(
                        items:
                            FetchRequest(
                                entity: Chat.entity(),
                                sortDescriptors: [
                                    NSSortDescriptor(
                                        key: "date",
                                        ascending: true
                                    )
                                ],
                                predicate: NSPredicate(
                                    format: "convo.name == %@",
                                    item.name ?? ""
                                )
                            ),
                        convo: item
                    )
                } label: {
                    Text(item.name ?? "")
                }
            }
        }
        .sheet(isPresented: $sheet) {
            CreateConvo(sheet: $sheet)
        }
        .toolbar {
            Button {
                sheet = true
            } label: {
                Text("add")
            }
        }
        .navigationTitle(Text("Convos"))
    }
}

struct CreateConvo: View {
    @State var name = ""
    @Binding var sheet: Bool
    
    var body: some View {
        HStack {
            TextField("name", text:  $name)
            
            Button {
                sheet = false
                Chathandler.createConvo(name: name)
            } label: {
                Text("Done")
            }
        }
    }
}

struct ConvoView_Previews: PreviewProvider {
    static var previews: some View {
        ConvoView()
    }
}
