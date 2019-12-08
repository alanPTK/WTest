//
//  Exercise03TableViewCell.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 08/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit

struct ValueObj {
    var textField: UITextField!
    var index: Int = 0
}

class Exercise03TableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfValue: UITextField!
    var currentIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // configure the cell content accordingly to its type
    func configureCell(itemObj: ItemObj, index: Int) {
        self.currentIndex = index
        
        switch itemObj.type {
        case "text":
            lbTitle.text = "text"
        case "number":
            lbTitle.text = "number"
            tfValue.keyboardType = .decimalPad
        case "uppercase":
            lbTitle.text = "uppercase"
            tfValue.autocapitalizationType = .allCharacters
        case "date":
            lbTitle.text = "date"
        case "list":
            lbTitle.text = "list"
        default:
            lbTitle.text = "default"
        }
        
        tfValue.placeholder = NSLocalizedString("Input some value", comment: "")
        tfValue.tag = itemObj.position
        tfValue.returnKeyType = .done
        tfValue.delegate = self
        tfValue.text = ValueRepository.shared.values[index]
        
        let placeholderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        placeholderView.backgroundColor = .white
        
        let placeholderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        placeholderLabel.text = "Input some value - \(lbTitle.text ?? "")"
        placeholderLabel.textAlignment = .center
        placeholderLabel.textColor = .black
        placeholderView.addSubview(placeholderLabel)
        
        tfValue.inputAccessoryView = placeholderView
        selectionStyle = .none
    }
    
    // when the user types something on the cell, check its types and do the necessary procedure
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 0:
            //any kind of letters are allowed
            return true
        case 1:
            //only number are allowed
            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
                return true
            } else {
                return false
            }
        case 2:
            //only uppercase letters are allowed
            textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
            
            return false
        case 3:
            //only dates are allowed
            return false
        case 4:
            //no letters are allowed
            return false
        default:
            return true
        }
    }
    
    // method called when the user touches on the field, check which text field is and shows a date picker or a list of values
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            let valueObj = ValueObj(textField: textField, index: currentIndex)
            NotificationCenter.default.post(name: Notification.Name("showDatePicker"), object: valueObj)
            
            return false
        } else if textField.tag == 4 {
            let valueObj = ValueObj(textField: textField, index: currentIndex)
            NotificationCenter.default.post(name: Notification.Name("showList"), object: valueObj)
            
            return false
        } else {
            return true
        }
    }
    
    // method called when the user touches on the 'Done' button, ends the editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // method called when the user finished the editing, saves the typed value
    func textFieldDidEndEditing(_ textField: UITextField) {
        ValueRepository.shared.values[currentIndex] = textField.text ?? ""
    }

}
