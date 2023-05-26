//
//  Models.swift
//  ChatGPT
//
//  Created by Danila Gorbunov on 25.04.2023.
//

import Foundation

struct ChatResponse: Codable {
    let id: String?
    let object: String?
    let created: Int?
    let choice: [Choice]?
}

struct Choice: Codable {
    let index: Int?
    let message: Message?
    let finish_reason: String?
}

struct Message: Codable {
    let role: String?
    let content: String?
}
