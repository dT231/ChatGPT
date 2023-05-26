//
//  Network.swift
//  ChatGPT
//
//  Created by Danila Gorbunov on 25.04.2023.
//

import Foundation



struct Network {
    
    static func fetchChat(chats: [Chat]) async throws -> ChatResponse? {
        var bearerToken: String = "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"
        
        if let key = Bundle.main.infoDictionary?["API_KEY"] as? String {
            bearerToken = key
            print(key)
        }
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { fatalError("Missing URL") }
        
        
        var cs: [[String: String]] = []
        for chat in chats {
            cs.append(["role": chat.role ?? "", "content": chat.message ?? ""])
        }
        let jsonBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "message": cs
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
        
        return chatResponse
    }
    
}
