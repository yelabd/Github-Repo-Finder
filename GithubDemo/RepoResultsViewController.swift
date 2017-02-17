//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    @IBOutlet weak var tableView: UITableView!
    var repos: [GithubRepo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            self.repos = newRepos
            self.tableView.reloadData()
            for repo in newRepos {
                print(repo)
//                self.repos.append(repo)
            }

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return repos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
        
        cell.descriptionLabel.text = repos[indexPath.row].repoDescription!
        let url = URL(string: repos[indexPath.row].ownerAvatarURL!)
        cell.avatarView.setImageWith(url!)
        cell.forkLabel.text = String(repos[indexPath.row].forks!)
        cell.starLabel.text = String(repos[indexPath.row].stars!)
        cell.titleLabel.text = repos[indexPath.row].name!
        cell.ownerLabel.text = repos[indexPath.row].ownerHandle!

        
        
        
        return cell
    }

}
