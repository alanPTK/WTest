//
//  Exercise03ViewController.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 08/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit

struct ItemObj {
    var type: String = ""
    var position: Int = 0
}

class Exercise03ViewController: UIViewController {
    
    var items: [ItemObj] = []

    override func viewDidLoad() {
        super.viewDidLoad()                
        
        NotificationCenter.default.addObserver(self, selector: #selector(showList), name: Notification.Name("showList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showDatePicker), name: Notification.Name("showDatePicker"), object: nil)        
        
        loadData()
    }
    
    @objc func showDatePicker(notification: Notification) {
        let valueObj = notification.object as! ValueObj
        let textField = valueObj.textField!
        let index = valueObj.index
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dateTimeDialogViewController = storyBoard.instantiateViewController(withIdentifier: "DateTimeDialogViewController") as! DateTimeDialogViewController
        
        dateTimeDialogViewController.onDone = { (date: String) -> () in
            textField.text = date
            ValueRepository.shared.values[index] = textField.text ?? ""
        }
        
        present(dateTimeDialogViewController, animated: true)
    }
    
    @objc func showList(notification: Notification) {
        let valueObj = notification.object as! ValueObj
        let textField = valueObj.textField!
        let index = valueObj.index
        
        let alertController = UIAlertController(title: NSLocalizedString("Attention ", comment: ""), message: NSLocalizedString("Choose a value", comment: ""), preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: NSLocalizedString("Value 1", comment: ""), style: .default) { (alert) in
            textField.text = "Value 1"
            
            ValueRepository.shared.values[index] = textField.text ?? ""
        }
        
        let option2 = UIAlertAction(title: NSLocalizedString("Value 2", comment: ""), style: .default) { (alert) in
            textField.text = "Value 2"
            
            ValueRepository.shared.values[index] = textField.text ?? ""
        }
        
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .destructive, handler: nil)
        
        alertController.addAction(option1)
        alertController.addAction(option2)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func loadData() {
        var position = 0
        
        for _ in 0...50 {
            var itemObj = ItemObj()
            
            switch position {
                case 0:
                    itemObj.type = "text"
                    itemObj.position = position
                    position += 1
                case 1:
                    itemObj.type = "number"
                    itemObj.position = position
                    position += 1
                case 2:
                    itemObj.type = "uppercase"
                    itemObj.position = position
                    position += 1
                case 3:
                    itemObj.type = "date"
                    itemObj.position = position
                    position += 1
                case 4:
                    itemObj.type = "list"
                    itemObj.position = position
                    position = 0
                default:
                    print("...")
            }
            items.append(itemObj)
            ValueRepository.shared.values.append("")
        }
    }

}

extension Exercise03ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Exercise03TableViewCell
        let item = items[indexPath.row]
        
        cell.configureCell(itemObj: item, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}
