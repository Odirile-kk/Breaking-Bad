//
//  Character.swift
//  BB API
//
//  Created by IACD-Air-6 on 2021/07/05.
//

import Foundation


struct Character: Decodable, CustomStringConvertible, Identifiable {
    let name: String
    let nickname: String
    let portrayed: String
    let status: String
    let occupation: [String]
    let birthday: String
    let img: String
    let id: Int
    
    var description: String {
        return "\(id) - \(name) aka \(nickname) appears as \(portrayed) and is currently \(status)"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, nickname, portrayed, status, birthday, img, occupation
        
        case id = "char_id"
    }
}


