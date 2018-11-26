//
//  ViewController.swift
//  CoffeApp
//
//  Created by Rached Fourati on 26/11/2018.
//  Copyright © 2018 Rached Fourati. All rights reserved.
//

import Foundation


// To parse the JSON, add this file to your project and do:
//
//   let coffees = try? newJSONDecoder().decode(Coffees.self, from: jsonData)

import Foundation

struct Coffees: Codable {
    let code: Int?
    let bars: [Coffee]?
    let neighborhoods: [Neighborhood]?
    let city: City?
}

struct Coffee: Codable {
    let id: Int?
    let address, name, url: String?
    let imageurl: String?
    var tags: Tags?
    let latitude, longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, address, name, url
        case imageurl = "image_url"
        case tags, latitude, longitude
    }
}

enum Tags: Codable, Hashable {
    case bool(Bool)
    case string(String)

    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Tags.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Tags"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct City: Codable {
    let name, nameonly: String?
    let id: Int?
}

struct Neighborhood: Codable {
    let id: Int?
    let name, slug: String?
}
