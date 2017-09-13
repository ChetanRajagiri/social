//
//  FeedVC.swift
//  social
//
//  Created by chetan rajagiri on 14/09/17.
//  Copyright © 2017 chetan rajagiri. All rights reserved.
//

import UIKit

class FeedVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell") as! postCell
        return cell
    }
    
    
}
