//
//  charQoutes.swift
//  BB API
//
//  Created by Odirile Kekana on 2021/07/13.
//

import Foundation

struct CharQoutes: Decodable, Identifiable {
    let author: String
    let quote: String
    let id: Int
    let series: String
    
    enum CodingKeys: String, CodingKey {
        case quote, author, series
        case id = "qoute_id"
    }
}
