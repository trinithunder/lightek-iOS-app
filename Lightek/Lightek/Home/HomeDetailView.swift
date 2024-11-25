//
//  HomeDetailView.swift
//  Lightek
//
//  Created by Marlon on 11/24/24.
//

import SwiftUI

struct HomeDetailView: View {
    @State var showContact = false
    var body: some View {
        
        List{
                Group{
                    VStack{
                        HStack{
                            Spacer()
                            Image(systemName: "house")
                                .padding(.trailing,16)
                        }
                        Spacer().frame(height:50)
                        HStack{
                            Image(systemName: "house")
                            Text("DJ/Artist name")
                        }
                        HStack{
                            Spacer()
                            VStack{
                              Text("Experience : Professional (5+ years)")
                                    .padding(.bottom,8)
                                Text("****    4.8 (1265)")
                            }
                            Spacer()
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: 94, height: 55)
                                .padding(.trailing,8)
                                .overlay(VStack{
                                    Text("starting rate")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .padding(8)
                                    Text("$30.56")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.bottom,5)
                                })
                        }
                    }
                }
                
               //Genere group:
                Group{
                    VStack(spacing:6){
                        HStack{
                            Text("Genre")
                                .padding(.top,20)
                            Spacer()
                        }
                        HStack{
                            Text("Genre1")
                            Text("Genre2")
                            Text("Genre3")
                            Spacer()
                        }
                    }
                }
                
                //Event Type group:
                Group{
                    VStack(spacing:6){
                        HStack{
                            Text("Event Type")
                                .padding(.top,20)
                            Spacer()
                        }
                        HStack{
                            Text("Event Type1")
                            Text("Event Type")
                            Text("Event Type3")
                            Spacer()
                        }
                    }
                }
                
                //Additional Services group:
                Group{
                    VStack(spacing:6){
                        HStack{
                            Text("Additional Services")
                                .padding(.top,20)
                            Spacer()
                        }
                        HStack{
                            Text("Services1")
                            Text("Services2")
                            Text("Services3")
                            Spacer()
                        }
                    }
                }
                
                //Reviews group:
                Group{
                    VStack(spacing:6){
                        HStack{
                            Text("Reviews")
                                .padding(.top,20)
                            Spacer()
                        }
                        HStack{
                            Text("Services1")
                            Text("Services2")
                            Text("Services3")
                            Spacer()
                        }
                    }
                }
                
                //Button group:
                Button {
                    showContact.toggle()
                } label: {
                    Spacer()
                Rectangle()
                        .frame(width: 343, height: 44)
                        .foregroundColor(.black)
                        .overlay(Text("Contact").foregroundColor(.white))
                        .fullScreenCover(isPresented: $showContact) {
                            Text("This is the contact view")
                        }
        }
    }
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView()
    }
}
