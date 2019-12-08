//
//  Exercise01ViewController.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 04/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit
import SVProgressHUD

struct PostalCodeObj {
    var id: String = ""
    var numCodPostal: String = ""
    var extCodPostal: String = ""
    var desigPostal: String = ""
}

class Exercise01ViewController: UIViewController {
    
    @IBOutlet weak var tvPostalCodes: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var postalCodes: [PostalCode] = []
    var filteredPostalCodes: [PostalCode] = []
    var presenter: Exercise01Presenter?
    
    //check is search field is empty
    var isPostalCodeSearchIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //check is filtering is active
    var isFiltered: Bool {
        return searchController.isActive && !isPostalCodeSearchIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Exercise01Presenter(delegate: self)
        
        //configure search controller to filter results
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search postal codes", comment: "")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        tvPostalCodes.tableFooterView = UIView(frame: .zero)
        
        navigationItem.title = NSLocalizedString("Exercise 01", comment: "")
        
        //check if synchronizations is already happened
        if let synchronizationIsFinished = Preferences.shared.synchronizationIsFinished {
            if synchronizationIsFinished {
                presenter?.getAllPostalCodes()
            } else {
                presenter?.loadPostalCodesFromServer()
            }
        }
        
    }

}

extension Exercise01ViewController: Exercise01Delegate {
    
    // show all the postal codes on the table view
    func showPostalCodes(postalCodes: [PostalCode]) {
        self.postalCodes = postalCodes
        tvPostalCodes.reloadData()
    }
    
    // show the filtered postal codes on the table view
    func showFilteredPostalCodes(filteredPostalCodes: [PostalCode]) {
        self.filteredPostalCodes = filteredPostalCodes
        tvPostalCodes.reloadData()
        
        navigationItem.title = NSLocalizedString("Exercise 01", comment: "")
    }
    
    // show the loading message
    func showLoadingMessage(message: String) {
        SVProgressHUD.show(withStatus: message)
    }
    
    // hides the loading message
    func hideLoadingMessage() {
        SVProgressHUD.dismiss()
    }
    
}

extension Exercise01ViewController: UISearchResultsUpdating {
    
    // method called when the user types something on the search field
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText != "" {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                    self.presenter?.searchPostalCodes(searchText: searchText)
                }
            }
        }
    }
    
}

extension Exercise01ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredPostalCodes.count
        }
        return postalCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postalCode: PostalCode
            
        if isFiltered {
            postalCode = filteredPostalCodes[indexPath.row]
        } else {
            postalCode = postalCodes[indexPath.row]
        }
        
        let postalCodeCell = tableView.dequeueReusableCell(withIdentifier: "postalCodeCell", for: indexPath)
        postalCodeCell.textLabel?.text = String(format: "%@-%@, %@", postalCode.numCodPostal, postalCode.extCodPostal, postalCode.desigPostal.capitalized)
        
        return postalCodeCell
    }
    
    
    
}
