//
//  HomeHub.swift
//  Lightek
//
//  Created by Marlon on 11/27/24.
//

import SwiftUI

struct HomeHub: View {
    let gk = GateKeeper()
    @State var items:[HomeContentItem] = [HomeContentItem(),HomeContentItem(),HomeContentItem(),HomeContentItem()]
    var body: some View {
        NavigationView{
            
                ZStack{
                    Color.black.ignoresSafeArea()
                    ScrollView{
                        VStack{
//                            Spacer().frame(height:100)
                            Group{
                                HStack{
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.white)
                                    PlaceholderTextField(placeholder: "Search for events")
                                    Image(systemName: "gear").foregroundColor(.white)
                                    Spacer().frame(width:160)
                                    Image(systemName: "gear").foregroundColor(.white)
                                    Image(systemName: "gear").foregroundColor(.white)
                                }
                            }
                            Group{
                                HStack{
                                    Text("Welcome, Mukul 👋").font(.system(size: 15))
                                        .foregroundColor(gk.vinylCTRLYellow)
                                        .padding(.leading,16)
                                    Spacer()
                                }
                            }
                            Group{
                                HStack{
                                    Text("Discover Customers")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .font(.system(size: 26))
                                        .padding(.leading,16)
                                    Spacer()
                                }
                            }
                            Spacer().frame(height:29.5)
                            Group{
                                HStack{
                                    Text("Trending in Your Genre")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18))
                                        .padding(.leading,16)
                                    Spacer()
                                    Capsule()
                                        .frame(width: 63, height: 30)
                                        .foregroundColor(.gray)
                                        .overlay(Text("View all")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 12)))
                                }
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(items, id: \.self) { item in
                                        ZStack{
                                                HomeCell(imageURL: "https://images3.alphacoders.com/678/678085.jpg")
                                            
                                            VStack{
                                                Spacer()
                                                Text("David Warner")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 14))
                                                    .fontWeight(.bold)
                                                HStack{
                                                    Image(systemName: "clock")
                                                        .foregroundColor(gk.vinylCTRLYellow)
                                                        .frame(width: 12, height: 12)
                                                        .padding(.leading,16)
                                                    Text("Tuesday, 10 Dec 2024 | 12:00 AM")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 10))
                                                    Spacer()

                                                }
                                                HStack{
                                                    Image(systemName: "clock")
                                                        .foregroundColor(gk.vinylCTRLYellow)
                                                        .frame(width: 12, height: 12)
                                                        .padding(.leading,16)
                                                    Text("123, XYZ street, Jakarta, Indonesia")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 10))
                                                    Spacer()
                                                }
                                                .padding(.bottom,10)
                                                HStack{
                                                    Capsule().foregroundColor(gk.vinylCTRLYellow)
                                                        .frame(width:78,height:28)
                                                        .overlay(Text("$25-30").foregroundColor(.black).fontWeight(.bold))
                                                        .padding(.leading,16)
                                                        .padding(.bottom,8)
                                                    Spacer()
                                                }
                                                    
                                            }
                                            
                                        }
                                    }
                                }
                                .padding()
                                Spacer()
                            }
                            
                            HStack{
                                Text("Upcoming events")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                    .padding(.leading,16)
                                Spacer()
                                Capsule()
                                    .frame(width: 63, height: 30)
                                    .foregroundColor(.gray)
                                    .overlay(Text("View all")
                                                .foregroundColor(.white)
                                                .font(.system(size: 12)))
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(items, id: \.self) { item in
                                        VStack{
                                            HomeCell(imageURL: "https://images3.alphacoders.com/678/678085.jpg",width: 98,height: 130)
                                            Text("Customer na...")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14))
                                            Text("Something")
                                                .foregroundColor(.white)
                                                .font(.system(size: 10))
                                        }
                                        
                    //                    Text(item)
                    //                        .padding()
                    //                        .frame(width: 100, height: 100)
                    //                        .background(Color.green.opacity(0.3))
                    //                        .cornerRadius(8)
                                    }
                                }
                                .padding()
                                
                                Spacer()
                            }
                                
                            
                        }
                        
                    }
                    
                    
                }
            
        }
    }
}

struct HomeHub_Previews: PreviewProvider {
    static var previews: some View {
        HomeHub()
    }
}
