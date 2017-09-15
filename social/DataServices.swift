//
//  DataServices.swift
//  social
//
//  Created by chetan rajagiri on 14/09/17.
//  Copyright © 2017 chetan rajagiri. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    static let ds = DataService()
    
    //database references
    private var _REF_BASE = DB_BASE
     private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS : DatabaseReference {
        return _REF_POSTS
    }
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    //storage references
    private var _REF_POSTS_IMAGES = STORAGE_BASE.child("posts-pics")
    
    var REF_POSTS_IMAGES : StorageReference {
        return _REF_POSTS_IMAGES
    }
    
 
    func createFirebaseDBUser(uid: String, userdata: Dictionary<String, String>)  {
        REF_USERS.child(uid).updateChildValues(userdata)
    }

}
