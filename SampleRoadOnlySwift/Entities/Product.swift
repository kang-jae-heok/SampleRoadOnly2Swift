//
//  Product.swift
//  SampleLoad
//
//  Created by notegg on 2022/11/25.
//

import Foundation

// MARK: - Welcome
struct Product: Codable {
    let name, summary: String
    let price: Price
    let discount: Discount
    let rating: Rating
    let brand: Brand
    let thumbnail: ClayfulImage?
    let catalogs: [Catalog]?
    let variants: [Variants]
}
struct Variants: Codable {
    let price: Price
    let types: [VariationType]
    let id: String
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price, types
    }
    
}
struct VariationType: Codable {
    let variation: Variation
}
struct Variation: Codable {
    let value: String
}


// MARK: - Brand
struct Brand: Codable {
    let name: String
}

// MARK: - Catalog
struct Catalog: Codable {
    let title, catalogDescription: String
    let image: ClayfulImage?

    enum CodingKeys: String, CodingKey {
        case title
        case catalogDescription = "description"
        case image
    }
}

// MARK: - Discount
struct Discount: Codable {
    let type: String?
    let value: ClayfulFormat?
    let discounted: ClayfulFormat
}

// MARK: - WelcomePrice
struct Price: Codable {
    let type: String?
    let original, sale: ClayfulFormat
}

// MARK: - Rating
struct Rating: Codable {
    let count, sum, average: ClayfulFormat
}

