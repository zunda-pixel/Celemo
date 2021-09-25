//
//  UserDefaultWrapper.swift
//  UserDefaultWrapper
//
//  Created by zunda on 2021/09/15.
//

import Foundation

enum UserDefaultWrapperError : Error {
    case SaveError
    case LoadError
    case NotFoundKey
}

struct UserDefaultWrapper {
    static func saveData<DecodeObject>(key: String, _ deviceModels: DecodeObject) throws {
        let archiveData = try NSKeyedArchiver.archivedData(withRootObject: deviceModels, requiringSecureCoding: true)
        UserDefaults.standard.setValue(archiveData, forKey: key)
    }
    
    static func saveArrayOfData<DecodeObject>(key: String, _ deviceModels: [DecodeObject]) throws {
        let archiveData = try NSKeyedArchiver.archivedData(withRootObject: deviceModels, requiringSecureCoding: true)
        UserDefaults.standard.setValue(archiveData, forKey: key)
    }
    
    static func loadData<DecodedObject>(key: String) throws -> DecodedObject where DecodedObject : NSObject, DecodedObject : NSSecureCoding {
        guard let storedData = UserDefaults.standard.object(forKey: key) as? Data else {
            throw UserDefaultWrapperError.NotFoundKey
        }

        if let data = try NSKeyedUnarchiver.unarchivedObject(ofClass: DecodedObject.self, from: storedData) {
            return data
        } else {
            throw UserDefaultWrapperError.LoadError
        }
    }
    
    static func loadArrayOfData<DecodedObject>(key: String) throws -> [DecodedObject] where DecodedObject : NSObject, DecodedObject : NSSecureCoding {
        guard let storedData = UserDefaults.standard.object(forKey: key) as? Data else {
            throw UserDefaultWrapperError.NotFoundKey
        }

        if let datas = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: DecodedObject.self, from: storedData) {
            return datas
        } else {
            throw UserDefaultWrapperError.LoadError
        }
    }
}
