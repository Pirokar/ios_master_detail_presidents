//
//  LanguageListController.swift
//  Presidents
//
//  Created by Владимир Рыбалка on 15/08/2017.
//  Copyright © 2017 Vladimir Rybalka. All rights reserved.
//

import UIKit

class LanguageListController: UITableViewController {
    weak var detailViewController: DetailViewController? = nil
    
    private let languageNames: [String] = ["English", "Русский", "German", "Spanish"]
    private let languageCodes: [String] = ["en", "ru", "de", "es"]

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false
        preferredContentSize = CGSize(width: 320, height: languageCodes.count * 44)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageCodes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel!.text = languageNames[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailViewController?.languageString = languageCodes[indexPath.row]
        dismiss(animated: true, completion: nil)
    }

}
