//
//  postCell.swift
//  social
//
//  Created by chetan rajagiri on 14/09/17.
//  Copyright © 2017 chetan rajagiri. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class postCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postedImg: UIImageView!
    @IBOutlet weak var postedCaption: UITextView!
    @IBOutlet weak var numberOfLikes: UILabel!
    
    var post: Post!
    func configureCell(post: Post, img: UIImage? = nil)  {
        self.post = post
        self.postedCaption.text = post.caption
        self.numberOfLikes.text = "\(post.likes)"
        
        if img != nil {
            self.postedImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageurl)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("error downlaoding image")
                } else {
                    print("successfully downloaded img")
                    if let imgData = data  {
                        if let img = UIImage(data: imgData) {
                            self.postedImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageurl as NSString)
                        }
                    }
                }
            })
        } 
    }


}
