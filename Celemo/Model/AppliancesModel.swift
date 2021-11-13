//
//  AppliancesModel.swift
//  Celemo
//
//  Created by zunda on 2021/09/20.
//

import Foundation

struct AppliancesModel: Codable, Identifiable{
    let id: String
    let number: Int
    let type: AppliancesTypes
}
