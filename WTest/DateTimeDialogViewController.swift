//
//  DateTimeDialogViewController.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 08/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit

class DateTimeDialogViewController: UIViewController {

    @IBOutlet weak var dpDate: UIDatePicker!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btFinish: UIButton!
    @IBOutlet weak var btCancel: UIButton!
    
    var date: String = ""
    
    var onDone: ((_ date: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dpDate.setDate(Date(), animated: true)

        lbTitle.text = NSLocalizedString("Select a date", comment: "")
        
        btCancel.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        btFinish.setTitle(NSLocalizedString("Finish", comment: ""), for: .normal)
        view.backgroundColor = .white
    }
    
    @IBAction func onDoneClick(_ sender: UIButton) {
        onDone?(formatDate(date: dpDate.date, format: "yyyy-MM-dd"))
        
        self.dismiss(animated: true)
    }
        
    @IBAction func onCancelClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func formatDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }

}
