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

class FeedVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var Posts = [Post] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let caption = post.caption
        print(caption)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell") as! postCell
        return cell
    }
    
    @IBAction func signOutBtnTapped(_ sender: UITapGestureRecognizer) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "gobacktoSignin", sender: nil)
    }
    
    
    
    
    
    
    
    
}
