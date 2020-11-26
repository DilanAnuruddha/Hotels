//
//  User.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import Foundation

struct User {
    let id:Int
    let name:String
    let email:String
    
    init(id:Int,name:String,email:String) {
        self.id = id
        self.name = name
        self.email = email
    }
}
