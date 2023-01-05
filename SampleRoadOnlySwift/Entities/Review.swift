//
//  Review.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


// MARK: - WelcomeElement
struct Review: Codable {
    // 리뷰 아이디, 타이틀(=한줄평), 바디, 시간, 닉네임, 이미지
    let id: String
    let helped: Helped
    let body: String
    var images: [ClayfulImage]
    let customer: Customer?
    let title: String
    let createdAt: ClayfulDate
    let rating: reviewRating

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case helped, body, images, customer, title, createdAt, rating
    }
}

// MARK: - EdAt
struct ClayfulDate: Codable {
    let raw: String
}



// MARK: - Customer
struct Customer: Codable {
    let alias: String
}

// MARK: - Avatar
struct ClayfulImage: Codable {
    let id: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case url
    }
}

// MARK: - Helped
struct Helped: Codable {
    let up, down, value, total: ClayfulFormat
}
struct reviewRating: Codable {
    let raw: Int
    let formatted: String
    let converted: String
}
// MARK: - Rating
struct ClayfulFormat: Codable {
    let raw: Int
    let formatted, converted: String
    let convertedRaw: Int?
}



