//
//  FavoriteImageViewController.swift
//  POST-Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FavoriteImageViewController: UIViewController {

    
    @IBOutlet weak var favTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.dataSource = self
        DataModel.shared.load()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favTableView.reloadData()
    }
    
}
extension FavoriteImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.getLists().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteTableViewCell else {return UITableViewCell()}
        let image = DataModel.shared.getLists()[indexPath.row]
        let imageURL = image.previewURL
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: {cell.favoriteImageView.image = $0} , errorHandler: {print($0)})
        return cell
    }
    
}






