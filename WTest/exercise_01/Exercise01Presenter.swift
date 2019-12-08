//
//  Exercise01Presenter.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 04/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit
import Alamofire

class Exercise01Presenter {
    
    private var delegate: Exercise01Delegate?
    private let postalCodeRepository = PostalCodeRepository()
    
    init(delegate: Exercise01Delegate) {
        self.delegate = delegate
    }
    
    // get all post codes from the database
    func getAllPostalCodes() {
        let postalCodes = Array(postalCodeRepository.getAllPostalCodes())
        
        delegate?.showPostalCodes(postalCodes: postalCodes)
        delegate?.hideLoadingMessage()
    }
    
    // get all the filtered post codes from the database
    func searchPostalCodes(searchText: String) {
        delegate?.showLoadingMessage(message: NSLocalizedString("Searching postal codes...", comment: ""))
        
        postalCodeRepository.searchPostalCodes(value: searchText) { (postalCodes) in
            self.delegate?.showFilteredPostalCodes(filteredPostalCodes: postalCodes)
            self.delegate?.hideLoadingMessage()
        }
    }
    
    // get all the postal codes from the server and save it on a file
    func loadPostalCodesFromServer() {
        postalCodeRepository.deleteAll()
        
        delegate?.showLoadingMessage(message: NSLocalizedString("Loading postal codes...", comment: ""))
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent("file.csv")
            
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download("https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/codigos_postais.csv", to: destination).responseData { response in
            if let destinationUrl = response.destinationURL {
                let data = try! Data(contentsOf: destinationUrl.absoluteURL, options: .dataReadingMapped)
                
                var postalCodes: [PostalCodeObj] = []
                
                if let lines = String(data: data, encoding: .utf8)?.split(separator: "\n") {
                    var index = 0
                    
                    for line in lines {
                        let values = line.split(separator: ",")
                        
                        if index > 0 {
                            let len = values.count
                            let postalCode = PostalCodeObj(id: UUID().uuidString,
                                                           numCodPostal: String(values[len-3]),
                                                           extCodPostal: String(values[len-2]),
                                                           desigPostal: String(values[len-1]))
                            postalCodes.append(postalCode)
                        }
                        index += 1
                    }
                    self.postalCodeRepository.executePostalCode(postalCodeObjs: postalCodes)
                    self.getAllPostalCodes()
                    
                    Preferences.shared.synchronizationIsFinished = true
                }
            }
        }
    }
    
}
