//
//  ViewController.swift
//  IBGENews
//
//  Created by Gustavo Carvalho on 12/04/22.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    private var newsResponse: IBGENewsResponse!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newsTableView.delegate = self;
        newsTableView.dataSource = self;
        
        NewsService().getNews() { response in
            self.newsResponse = response
            self.newsTableView.reloadData()
        }
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResponse?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = indexPath.row % 5 == 0 ? "highlightNewsCell" : "simpleNewsCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsTableViewCell
        
        let currentNews = self.newsResponse.items[indexPath.row]
        
        do {
            try cell.updateCellData(currentNews)
        } catch {
            present(UIAlertController(title: "Error", message: "Error occurs trying to render cell", preferredStyle: .alert), animated: true, completion: nil)
        }
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}

