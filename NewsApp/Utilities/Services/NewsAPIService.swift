//
//  NewsAPIService.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import Foundation

protocol NewsAPIServiceProtocol {
    func getArticles(amount: Int) async throws -> [Article]
}

final actor NewsAPIService: NewsAPIServiceProtocol {
    private let apiKey = "PASTE KEY HERE"
    private let endPoint = "https://newsapi.org/v2/top-headlines?country=us"

    func getArticles(amount: Int) async throws -> [Article]  {
        let responseObject = try await getResponseObject(amount: amount)

        if responseObject.status == "ok" {

            guard let articles = responseObject.articles else {
                throw NewsError.somethingWentWrong
            }

            return articles

        } else {

            guard let errorMessage = responseObject.message else {
                throw NewsError.somethingWentWrong
            }
            throw NewsError.defaultCustom(errorMessage)
        }

    }

    private func getResponseObject(amount: Int) async throws -> NewsRepsonseObject {
        // 100 is max
        let size = amount >= 100 ? 100 : amount

        guard let url = URL(string: endPoint + "&pageSize=\(size)&apiKey=\(apiKey)") else {
            throw NewsError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw NewsError.somethingWentWrong
        }

        guard response.statusCode == 200 else {
            throw NewsError.invalidResponse(code: response.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(NewsRepsonseObject.self, from: data)
            try FileManager.default.encode(response, to: .getJsonStr(for: .newsResponse))
            return response
        } catch {
            throw error
        }
    }


}



