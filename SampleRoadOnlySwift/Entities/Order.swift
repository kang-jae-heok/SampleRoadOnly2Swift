//
//  Order.swift
//  SampleRoadOnlySwift
//
//  Created by kcn on 2022/12/27.
//

import Foundation

struct Orders: Codable {
    let orderArr: [Order]
}

struct Order: Codable {
    let items: [OrderItems]
    let id: String
    let fulfillments: [Fulfillments]
    let status: String
    let refunds: [Refunds]
    let createdAt: CreatedAt

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case items
        case fulfillments
        case status
        case refunds
        case createdAt
    }
}

struct OrderItems: Codable {
    let quantity: OrderQuantity
    let product: OrderProduct
    let brand: Brand
    let total: OrderTotal
    let id: String
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case total,brand,product,quantity
    }
}
struct OrderQuantity: Codable {
    let raw: Int
}
struct OrderProduct: Codable {
    let id, name : String
    let thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case thumbnail
    }
}
struct OrderTotal: Codable {
    let price: Price
}
struct Fulfillments: Codable {
    let status: String
    let tracking: Tracking
}
struct Refunds: Codable {
    let items: [RefundsItems]
    let status: String
}
struct RefundsItems: Codable {
    let item: RefundItem
}
struct RefundItem: Codable {
    let id: String
    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}
struct Tracking: Codable {
    let uid: String
}
struct CreatedAt: Codable {
    let raw: String
}
