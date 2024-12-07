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

enum PaymentMethod: String, CaseIterable {
        case applePay = "Apple Pay"
        case creditCard = "Credit Card"
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

struct AsyncImageView: View {
    let imageURL: URL
    @State var imageWidth = 100.0
    @State var imageHeight = 100.0
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                // Placeholder view while the image is loading
                ProgressView()
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            case .success(let image):
                // Successfully loaded image
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth, height: imageHeight)
                    .cornerRadius(10)
            case .failure:
                // Placeholder for failed image load
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            @unknown default:
                EmptyView()
            }
        }
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

