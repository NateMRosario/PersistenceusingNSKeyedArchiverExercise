//
//  ImageDetailViewController.swift
//  POST-Exercise
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    var image: Image?
    
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var imageDetailView: UIImageView!
    @IBAction func favoritesButtonPressed(_ sender: UIButton) {
        DataModel.shared.addImageItemToList(imageItem: image!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        guard let image = image else {return}
        tagLabel.text = "Tags: \(image.tags)"
        likeLabel.text = "Likes: \(image.likes)"
        favoriteLabel.text = "Favorites: \(image.favorites)"
        downloadLabel.text = "Downloads: \(image.downloads)"
        let imageURL = image.previewURL 
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: {self.imageDetailView.image = $0}, errorHandler: {print($0)})
        
    }
    

}
