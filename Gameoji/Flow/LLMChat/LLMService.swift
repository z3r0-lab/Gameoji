//
//  LLMService.swift
//  Gameoji
//
//  Created by Бағжан Артыкбаев on 28.04.2025.
//
import Foundation

class LLMService {
    static let shared = LLMService()
    private init() {}

    private let apiKey = "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"

    func sendMessage(userMessage: String, systemPrompt: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.groq.com/openai/v1/chat/completions") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let messages = [
            ["role": "system", "content": systemPrompt],
            ["role": "user", "content": userMessage]
        ]

        let body: [String: Any] = [
            "model": "llama3-70b-8192", // Самая мощная бесплатная модель от Groq
            "messages": messages,
            "temperature": 0.7 // Можно настраивать стиль ответов
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Ошибка кодирования JSON:", error)
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка при запросе:", error)
                completion(nil)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP статус код:", httpResponse.statusCode)
            }

            guard let data = data else {
                print("Нет данных в ответе")
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let choices = json["choices"] as? [[String: Any]],
                       let message = choices.first?["message"] as? [String: Any],
                       let content = message["content"] as? String {
                        completion(content)
                    } else {
                        print("Ответ без choices:", json)
                        completion(nil)
                    }
                }
            } catch {
                print("Ошибка разбора JSON:", error)
                completion(nil)
            }
        }.resume()
    }
}
