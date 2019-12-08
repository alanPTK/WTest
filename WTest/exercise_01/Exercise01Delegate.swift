//
//  Exercise01Delegate.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 04/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit

protocol Exercise01Delegate {
    
    func showPostalCodes(postalCodes: [PostalCode])
    func showFilteredPostalCodes(filteredPostalCodes: [PostalCode])
    func showLoadingMessage(message: String)
    func hideLoadingMessage()
    
}
