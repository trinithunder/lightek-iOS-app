//
//  DataLayer.swift
//  Lightek
//
//  Created by Marlon on 12/2/24.
//

import Foundation
import SwiftUI

struct User:CodableHashable{
    var id:Int
    var email: String
    var created_at: String
    var updated_at: String
    var role:String
    var user_profile: UserProfile
}

struct UserProfile:CodableHashable{
    var id:Int
    var first_name:String
    var last_name:String
    var bio:String
    var twitter:String
    var instagram:String
    var blue_sky:String
    var tiktok:String
    var phone_number:String
    var user_id:Int
    var created_at:String
    var updated_at:String
}
