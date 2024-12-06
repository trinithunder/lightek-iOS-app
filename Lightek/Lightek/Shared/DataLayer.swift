//
//  DataLayer.swift
//  Lightek
//
//  Created by Marlon on 12/2/24.
//

import Foundation
import SwiftUI
import UIKit

protocol CodableHashable: Codable, Hashable {}

typealias HashableCodable = CodableHashable

enum Groups {
    case client
    case artist
}

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

struct Networking {
    static let baseUrl = "http://localhost:3000"
}

struct Routes{
    static let user_profile = "user_profile"
    static let users = "users"
}

struct Hubs {
    
    func onboarding()-> some View{
       return tshangShung()
    }
    
    func signIn()-> some View{
       return tshangShung()
    }
    
    func signUp()-> some View{
       return tshangShung()
    }
    
    func home()-> some View{
       return tshangShung()
    }
    
    func profile()-> some View{
       return tshangShung()
    }
    
    func transactions()-> some View{
       return tshangShung()
    }
    
    func services()-> some View{
       return tshangShung()
    }
    
    func subscription()-> some View{
       return tshangShung()
    }
    
    func chat()-> some View{
       return tshangShung()
    }
    
    func artistBooking()-> some View{
       return tshangShung()
    }
    
    func bookingHistory()-> some View{
       return tshangShung()
    }
    
    func requirements()-> some View{
       return tshangShung()
    }
    
    private func tshangShung()->some View{
        return EmptyView()
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}

