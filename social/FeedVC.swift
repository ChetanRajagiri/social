//
//  FeedVC.swift
//  social
//
//  Created by chetan rajagiri on 14/09/17.
//  Copyright © 2017 chetan rajagiri. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController , UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdded: UIImageView!
    
    var Posts = [Post] ()
    var imagePicker : UIImagePickerController!
    static var imageCache: NSCache <NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let postdict = snap.value as? Dictionary <String, AnyObject> {
                        let key = snap.key
                        let post = Post(postkey: key, postdata: postdict)
                        self.Posts.append(post)
                    }
                }
            }
//            self.Posts.removeAll(keepingCapacity: false)
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = Posts [indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell") as? postCell {
            cell.configureCell(post: post)
            return cell
        }else {
            return postCell()
        }
    }
    
    @IBAction func signOutBtnTapped(_ sender: UITapGestureRecognizer) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "gobacktoSignin", sender: nil)
    }
    
    @IBAction func addImgTapped(_ sender: UITapGestureRecognizer) {
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info [UIImagePickerControllerEditedImage] as? UIImage {
            imageAdded.image = imagePicked
        }
        else if let originalImagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageAdded.image = originalImagePicked
        }else{
            print("valid img nt selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}
