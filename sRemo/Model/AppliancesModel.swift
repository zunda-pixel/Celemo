//
//  AppliancesModel.swift
//  sRemo
//
//  Created by zunda on 2021/09/20.
//

import Foundation

class AppliancesModel: NSObject, Identifiable, NSSecureCoding{
    let deviceID: String
    let deviceNumber: Int
    let appliancesType: AppliancesTypes
    
    static var supportsSecureCoding: Bool = true
    
    init(id: String, number: Int, type: AppliancesTypes) {
        self.deviceID = id
        self.deviceNumber = number
        self.appliancesType = type
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(deviceID, forKey: "deviceID")
        coder.encode(deviceNumber, forKey: "deviceNumber")
        coder.encode(appliancesType.rawValue, forKey: "appliancesType")
    }
    
    required init?(coder: NSCoder) {
        guard let deviceID = coder.decodeObject(forKey: "deviceID") as? String,
              let appliancesType = coder.decodeObject(forKey: "appliancesType") as? String else {
            return nil
        }
        
        let deviceNumber = coder.decodeInteger(forKey: "deviceNumber")
        
        self.deviceID = deviceID
        self.deviceNumber = deviceNumber
        self.appliancesType = AppliancesTypes(rawValue: appliancesType)!
    }
}
