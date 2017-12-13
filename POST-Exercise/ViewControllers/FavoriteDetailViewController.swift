//
//  FavoriteDetailViewController.swift
//  POST-Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {

    var image: Image?
    
    @IBOutlet weak var favFavoriteLabel: UILabel!
    @IBOutlet weak var favDownloadLabel: UILabel!
    @IBOutlet weak var favLikeLabel: UILabel!
    @IBOutlet weak var favTagLabel: UILabel!
    @IBOutlet weak var favDetailImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        favFavoriteLabel.text = image?.favorites.description
        favTagLabel.text = image?.tags.description
        favLikeLabel.text = image?.likes.description
        favDownloadLabel.text = image?.downloads.description
        
    }
    
}
