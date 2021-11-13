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
            let title = "設定ファイルの読み書き時に失敗しました"
            switch self {
                case .SaveError: return "\(title)\n保存に失敗しました"
                case .LoadError: return "\(title)\n読み込みに失敗しました"
                case .NotFoundKey: return "\(title)\nキーが見つかりませんでした"
            }
        }
    }
    
    public enum Keys: String {
        case DevicesData
        case AppliancesData
    }
    
    public static func saveData<DecodeObject>(key: UserDefaults.Keys, _ data: DecodeObject) throws where DecodeObject : Encodable {
        let json = try JSONEncoder().encode(data)
        UserDefaults.standard.set(json, forKey: key.rawValue)
    }
    
    public static func saveArrayOfData<DecodeObject>(key: UserDefaults.Keys, _ datas: [DecodeObject]) throws where DecodeObject : Encodable {
        let json = try JSONEncoder().encode(datas)
        UserDefaults.standard.set(json, forKey: key.rawValue)
    }
    
    public static func loadData<DecodedObject>(key: UserDefaults.Keys) throws -> DecodedObject where DecodedObject : Decodable {
        guard let storedData = UserDefaults.standard.data(forKey: key.rawValue) else {
            throw UserDefaultsError.NotFoundKey
        }
        
        return try JSONDecoder().decode(DecodedObject.self, from: storedData)
    }
    
    public static func loadArrayOfData<DecodedObject>(key: UserDefaults.Keys) throws -> [DecodedObject] where DecodedObject : Decodable {
        guard let storedData = UserDefaults.standard.data(forKey: key.rawValue) else {
            throw UserDefaultsError.NotFoundKey
        }
        
        let datas = try JSONDecoder().decode([DecodedObject].self, from: storedData)
            
        return datas
    }
}
