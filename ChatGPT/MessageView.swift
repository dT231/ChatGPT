//
//  MessageView.swift
//  ChatGPT
//
//  Created by Danila Gorbunov on 25.04.2023.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var message: Chat
    
    var body: some View {
        HStack(alignment: .bottom) {
            if message.role == "user" {
                Spacer()
            } else {
                Image(systemName: "r.joystick.tilt.right")
            }
            Text(AttributedString(message.message ?? ""))
                .padding()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(message.role == "user" ? .blue : .black)
                )
            if message.role != "user" {
                Spacer()
            } else {
                Image(systemName: "person")
            }
        }
    }
}
