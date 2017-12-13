//
//  ViewController.swift
//  POST-Exercise
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var images = [Image]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
    }
    func loadData() {
        let ApiKey = "7289923-0b68ed7d233fab7c0c5f1be3f"
        let urlStr = "https://pixabay.com/api/?key=\(ApiKey)&q=\(searchTerm)"
        ImagesAPIClient.manager.getImage(from: urlStr, completionHandler: {self.images = $0}, errorHandler: {print($0)})
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ImageDetailViewController {
            let selectedImage = images[tableView.indexPathForSelectedRow!.row]
            destination.image = selectedImage
        }
    }
}
extension ImageViewController: UITableViewDataSource, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageTableViewCell else {return UITableViewCell()}
        let image = images[indexPath.row]
        imageCell.tableImage.image = nil
        imageCell.imageSpinner.isHidden = false
        imageCell.imageSpinner.startAnimating()
        let imageURL = image.previewURL
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            imageCell.tableImage.image = onlineImage
            imageCell.setNeedsLayout()
            DispatchQueue.main.async {
                imageCell.imageSpinner.isHidden = true
                imageCell.imageSpinner.stopAnimating()
            }
        }
            ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: {print($0)})
        return imageCell
    }
}
