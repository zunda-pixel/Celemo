//
//  UserDefaultWrapper.swift
//  UserDefaultWrapper
//
//  Created by zunda on 2021/09/15.
//

import Foundation

enum SavingError : Error {
    case NoError
    case SaveError
    case LoadError
    case NotFoundKey
}

struct UserDefaultWrapper {
    static func saveData<DecodeObject>(key: String, _ deviceModels: DecodeObject) -> SavingError {
        do {
            let archiveData = try NSKeyedArchiver.archivedData(withRootObject: deviceModels, requiringSecureCoding: true)
            UserDefaults.standard.setValue(archiveData, forKey: key)
            return .NoError
        } catch {
            return .SaveError
        }
    }
    
    static func saveArrayOfData<DecodeObject>(key: String, _ deviceModels: [DecodeObject]) -> SavingError {
        do {
            let archiveData = try NSKeyedArchiver.archivedData(withRootObject: deviceModels, requiringSecureCoding: true)
            UserDefaults.standard.setValue(archiveData, forKey: key)
            return .NoError
        } catch {
            return .SaveError
        }
    }
    
    static func loadData<DecodedObject>(key: String) -> Result<DecodedObject, SavingError> where DecodedObject : NSObject, DecodedObject : NSSecureCoding {
        guard let storedData = UserDefaults.standard.object(forKey: key) as? Data else {
            return .failure(.NotFoundKey)
        }

        do {
            if let secrets = try NSKeyedUnarchiver.unarchivedObject(ofClass: DecodedObject.self, from: storedData) {
                return .success(secrets)
            } else {
                return .failure(.LoadError)
            }
        } catch {
            return .failure(.LoadError)
        }
    }
    
    static func loadArrayOfData<DecodedObject>(key: String) -> Result<[DecodedObject], SavingError> where DecodedObject : NSObject, DecodedObject : NSSecureCoding {
        guard let storedData = UserDefaults.standard.object(forKey: key) as? Data else {
            return .failure(.NotFoundKey)
        }

        do {
            if let secrets = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: DecodedObject.self, from: storedData) {
                return .success(secrets)
            } else {
                return .failure(.LoadError)
            }
        } catch {
            return .failure(.LoadError)
        }
    }
}
