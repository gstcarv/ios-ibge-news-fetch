//
//  ViewController.swift
//  IBGENews
//
//  Created by Gustavo Carvalho on 12/04/22.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    private var lastFetchedNewsResponse: IBGENewsResponse?
    private var newsItems: [NewsInformation] = []
    private var isFetching = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        fetchNextPage() { response in
            self.newsTableView.reloadData()
        }
    }
    
    func fetchNextPage (completion: @escaping (IBGENewsResponse) -> Void) {
        
        let nextPage = lastFetchedNewsResponse?.nextPage ?? 1
        
        isFetching = true
        
        // Fetch news data
        NewsService().getNews(page: nextPage) { response in
            self.lastFetchedNewsResponse = response
            self.newsItems += response.items
            self.isFetching = false
            completion(response)
        }
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // For each 5 items, the first will be a highlight item
        let cellIdentifier = indexPath.row % 5 == 0 ? "highlightNewsCell" : "simpleNewsCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsTableViewCell
        
        let currentNews = self.newsItems[indexPath.row]
        
        do {
            try cell.updateCellData(currentNews)
        } catch {
            present(UIAlertController(title: "Error", message: "Error occurs trying to render cell", preferredStyle: .alert), animated: true, completion: nil)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == newsItems.count - 1 && !isFetching {
            fetchNextPage() { response in
                var rowsToInsert: [IndexPath] = []
                
                var lastIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
                
                for _ in response.items {
                    lastIndex += 1
                    rowsToInsert.append(IndexPath(row: lastIndex, section: indexPath.section))
                }
                
                // Added the fetched items rows to table view
                tableView.insertRows(at: rowsToInsert, with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = newsItems[indexPath.row]
        
        // Open the news URL
        if let url = URL(string: selectedNews.link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

