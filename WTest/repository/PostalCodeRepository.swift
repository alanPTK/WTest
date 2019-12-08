//
//  PostalCodeRepository.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 04/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import RealmSwift

class PostalCodeRepository {
    
    private var realm: Realm
    private let backgroundQueue = DispatchQueue(label: "backgroundQueue")
    private var token: NotificationToken?
    
    init() {
        realm = try! Realm()
    }
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    //save postal codes on realm database
    func executePostalCode(postalCodeObjs: [PostalCodeObj]) {
        var postalCode: PostalCode
        var postalCodes: [PostalCode] = []
        
        for postalCodeObj in postalCodeObjs {
            postalCode = PostalCode()
            postalCode.id = postalCodeObj.id
            postalCode.numCodPostal = postalCodeObj.numCodPostal
            postalCode.extCodPostal = postalCodeObj.extCodPostal
            postalCode.desigPostal = postalCodeObj.desigPostal
            
            postalCodes.append(postalCode)
        }
        
        savePostalCode(postalCodes: postalCodes)
    }
    
    func savePostalCode(postalCodes: [PostalCode]) {
        try! realm.write {
            realm.add(postalCodes)
        }
    }
    
    func getAllPostalCodes() -> Results<PostalCode> {
        return realm.objects(PostalCode.self)
    }
    
    func searchPostalCodes(value: String, completionHandler: @escaping (_ result: [PostalCode]) -> Void) {
        let searchPredicate = NSPredicate(format: "numCodPostal CONTAINS[cd] %@ OR extCodPostal CONTAINS[cd] %@ OR desigPostal CONTAINS[cd] %@", value, value, value)
        
        let results = realm.objects(PostalCode.self).filter(searchPredicate)
        
        token = results.observe { changes in
            switch changes {
            case .initial(let postalCodes):
                completionHandler(Array(postalCodes))                                
            case .update:
                print("update")
            case .error:
                print("error")
            }
        }
    }
    
    func deleteAll() {                
        try! realm.write {
            realm.deleteAll()
        }
    }
}

