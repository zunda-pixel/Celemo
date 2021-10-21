//
//  UserDefaultWrapper.swift
//  UserDefaultWrapper
//
//  Created by zunda on 2021/09/15.
//

import Foundation

extension UserDefaults {
    public enum UserDefaultsError : Error {
        case SaveError
        case LoadError
        case NotFoundKey
        
        var localizedDescription: String {
            switch self {
                case .SaveError: return "保存に失敗しました"
                case .LoadError: return "読み込みに失敗しました"
                case .NotFoundKey: return "キーが見つかりませんでした"
            }
        }
    }
    
    public enum Keys: String {
        case DevicesData
        case AppliancesData
    }
    
    public static func saveData<DecodeObject>(key: UserDefaults.Keys, _ deviceModels: DecodeObject) throws {
        let archiveData = try NSKeyedArchiver.archivedData(withRootObject: deviceModels, requiringSecureCoding: true)
        UserDefaults.standard.setValue(archiveData, forKey: key.rawValue)
    }
    
    public static func saveArrayOfData<DecodeObject>(key: UserDefaults.Keys, _ deviceModels: [DecodeObject]) throws {
        let archiveData = try NSKeyedArchiver.archivedData(withRootObject: deviceModels, requiringSecureCoding: true)
        UserDefaults.standard.setValue(archiveData, forKey: key.rawValue)
    }
    
    public static func loadData<DecodedObject>(key: UserDefaults.Keys) throws -> DecodedObject where DecodedObject : NSObject, DecodedObject : NSSecureCoding {
        guard let storedData = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
            throw UserDefaultsError.NotFoundKey
        }
        
        if let data = try NSKeyedUnarchiver.unarchivedObject(ofClass: DecodedObject.self, from: storedData) {
            return data
        } else {
            throw UserDefaultsError.LoadError
        }
    }
    
    public static func loadArrayOfData<DecodedObject>(key: UserDefaults.Keys) throws -> [DecodedObject] where DecodedObject : NSObject, DecodedObject : NSSecureCoding {
        guard let storedData = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
            throw UserDefaultsError.NotFoundKey
        }
        
        if let datas = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: DecodedObject.self, from: storedData) {
            return datas
        } else {
            throw UserDefaultsError.LoadError
        }
    }
}
