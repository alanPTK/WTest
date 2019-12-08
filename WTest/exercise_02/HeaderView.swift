//
//  HeaderView.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 06/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var ivHeader: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
