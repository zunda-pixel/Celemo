//
//  AppliancesType.swift
//  Celemo
//
//  Created by zunda on 2021/09/20.
//

import Foundation

enum AppliancesTypes: String, Codable, CaseIterable {
    case Light  = "照明"
    case TV     = "テレビ"
    case DVD
    case Switch = "スイッチ"
    case AirConditioner = "エアコン"
}

enum AirConditionerRestriction: Double {
    case Min = 16
    case Max = 31
}
