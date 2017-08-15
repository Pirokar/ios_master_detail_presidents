//
//  DetailViewController.swift
//  Presidents
//
//  Created by Владимир Рыбалка on 15/08/2017.
//  Copyright © 2017 Vladimir Rybalka. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!

    private var languageListController: LanguageListController?
    private var languageButton: UIBarButtonItem?
    var languageString: String = "en" {
        didSet {
            if languageString != oldValue {
                configureView()
            }
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                let dict = detail
                let urlString = modifyUrlForLanguage(url: dict["url"]!, language: languageString)
                label.text = urlString
                
                let url = NSURL(string: urlString)
                let request = URLRequest(url: url! as URL)
                webView.loadRequest(request)
                let name = dict["name"]!
                title = name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        languageButton = UIBarButtonItem(title: "Выберите язык", style: .plain, target: self, action: #selector(DetailViewController.showLanguagePopover))
        navigationItem.rightBarButtonItem = languageButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLanguagePopover() {
        if languageListController == nil {
            languageListController = LanguageListController()
            languageListController!.detailViewController = self
            languageListController!.modalPresentationStyle = .popover
        }
        
        present(languageListController!, animated: true, completion: nil)
        
        if let ppc = languageListController?.popoverPresentationController {
            ppc.barButtonItem = languageButton
        }
    }
    
    private func modifyUrlForLanguage(url: String, language lang: String?) -> String {
        var newUrl = url
        if let langStr = lang {
            let range = NSMakeRange(7, 2)
            if (url as NSString).substring(with: range) != langStr {
                newUrl = (url as NSString).replacingCharacters(in: range, with: langStr)
            }
        }
        
        return newUrl
    }

    var detailItem: [String: String]? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

