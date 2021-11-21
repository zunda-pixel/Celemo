//
//  CreditModel.swift
//  Celemo
//
//  Created by zunda on 2021/11/21.
//

import SwiftUI

struct CreditModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let url: String
}

extension CreditModel {
    static func getModels() -> [CreditModel] {
        let models: [CreditModel] = [
            .init(name: "Good Ware", url: "https://www.flaticon.com/authors/good-ware"),
            .init(name: "itim2101", url: "https://www.flaticon.com/authors/itim2101"),
            .init(name: "Freepik", url: "https://www.flaticon.com/authors/freepik"),
        ]
        
        return models
    }
}
