//
//  Exercise02ViewController.swift
//  WTest
//
//  Created by Alan Filipe Cardozo Fabeni on 04/12/19.
//  Copyright © 2019 Alan Filipe Cardozo Fabeni. All rights reserved.
//

import UIKit
import Kingfisher

class Exercise02ViewController: UIViewController {
    
    @IBOutlet weak var tvItems: UITableView!
    private lazy var headerView = UINib(nibName: "HeaderView", bundle: nil)
    @IBOutlet weak var vTest: UIView!
    
    var items: [String] = []
    var textAttributes: [NSAttributedString.Key: Color] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        customizeViewStyle()
    }
    
    // creates the table view entries
    func loadData() {
        for _ in 0...50 {
            items.append(UUID().uuidString)
        }
        
        tvItems.reloadData()
    }
    
    func customizeViewStyle() {
        view.backgroundColor = .red
        
        title = NSLocalizedString("Exercise 02", comment: "")
        
        textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
}


extension Exercise02ViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item
        
        return cell
    }
    
    // creates the header and downloads the image
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerV = headerView.instantiate(withOwner: self, options: nil).first as? HeaderView
        
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/b/bc/Rainforest_Fatu_Hiva.jpg")
        headerV?.ivHeader.kf.setImage(with: url)
        
        return headerV
    }
    
    // changes the color when the user is scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let limit: CGFloat = 200
        let alpha = min(1, scrollView.contentOffset.y / limit)
        
        let newNavigationColor = UIColor(white: 1, alpha: alpha)
        navigationController?.navigationBar.backgroundColor = newNavigationColor
        
        if alpha >= 1 {
            textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }
    
}
