//
//  BookingDetailsPaidTotal.swift
//  Lightek
//
//  Created by Marlon on 12/5/24.
//

import SwiftUI

struct BookingDetailsPaidTotal: View {
    @EnvironmentObject var gk:GateKeeper
    var body: some View {
        ZStack{
            gk.colorSystem.vinylCTRLDarkColor?.ignoresSafeArea()
            VStack{
                Group{
                    Text("Booking Details").foregroundColor(.white).fontWeight(.medium).font(.system(size: 28))
                Spacer().frame(height:25)
                    
                }
                Group{
                    HStack{
                        Spacer().frame(width:42)
                        AsyncImageView(imageURL: URL(string: "https://images3.alphacoders.com/678/678085.jpg")!, imageWidth: 120, imageHeight: 94)
                    ZStack{
                        HStack{
                            Spacer()
                            Text("Confirmed".uppercased())
                                .foregroundColor(gk.colorSystem.vinylCTRLDarkColor)
                            .font(.system(size: 13))
                            .padding(.top,5)
                            .padding(.trailing,10)
                            .padding(.bottom,5)
                            .padding(.leading,10)
                            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color.green))
                            .frame(width: 100, height: 20)
                            .padding(.trailing,16)
                        }.padding(.bottom,100)
                        
                        VStack(spacing:2){
                        Text("Customer name")
                            .foregroundColor(.yellow)
                        
                        Text("Jakarta, Indonesia")
                                .foregroundColor(gk.colorSystem.vinlCTRLHintColor)
                            .font(.system(size: 14))
                        Text("Tuesday, 10 Dec 2024")
                                .foregroundColor(gk.colorSystem.vinlCTRLHintColor)
                            .font(.system(size: 14))
                    }}
                    Spacer()
                }.background(RoundedRectangle(cornerRadius: 25).frame(width: 358, height: 126).foregroundColor(Color(hex: "1e1e1e")))}
                
                Group{
                    Spacer().frame(height:50)
                    HStack{
                        Text("Order number: ".uppercased() + " ID32153612312")
                            .fontWeight(.semibold)
                            .padding(.leading,16)
                            .font(.system(size: 14))
                        Spacer()
                    }
                Rectangle().frame(width: 358, height: 1)
                        .foregroundColor(gk.colorSystem.vinlCTRLDarkColorStroke)
                }.padding(.bottom,14)
                
                Group{
                    HStack{
                    Text("Total Price")
                        .fontWeight(.semibold)
                        .padding(.leading,16)
                        .font(.system(size: 14))
                        .foregroundColor(gk.colorSystem.vinlCTRLHintColor)
                    Spacer()
                        Text("$30.65")
                        Text("Paid".uppercased())
                            .foregroundColor(gk.colorSystem.vinylCTRLDarkColor)
                            .font(.system(size: 13))
                            .padding(.top,5)
                            .padding(.trailing,10)
                            .padding(.bottom,5)
                            .padding(.leading,10)
                            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color.green))
                            .frame(width: 55, height: 20)
                            .padding(.trailing,16)
                }
                    //Spacer().frame(height:14)
            Rectangle().frame(width: 358, height: 1)
                        .foregroundColor(gk.colorSystem.vinlCTRLDarkColorStroke)
                    
                }.padding(.bottom,14)
                
                Group{
                    HStack{
                    Text("Event Type")
                        .fontWeight(.semibold)
                        .padding(.leading,16)
                        .font(.system(size: 14))
                        .foregroundColor(gk.colorSystem.vinlCTRLHintColor)
                    Spacer()
                        Text("School Event")
                            .font(.system(size: 14))
                            .padding(.trailing,16)
                }
            Rectangle().frame(width: 358, height: 1)
                        .foregroundColor(gk.colorSystem.vinlCTRLDarkColorStroke)
                    
                }.padding(.bottom,14)
                
               Group{
                   HStack{
                    Text("Time")
                        .fontWeight(.semibold)
                        .padding(.leading,16)
                        .font(.system(size: 14))
                        .foregroundColor(gk.colorSystem.vinlCTRLHintColor)
                    Spacer()
                       Text("3:19")
                           .font(.system(size: 14))
                           .padding(.trailing,16)
                }
            Rectangle().frame(width: 358, height: 1)
                       .foregroundColor(gk.colorSystem.vinlCTRLDarkColorStroke)
                   
               }.padding(.bottom,14)
                
                Group{
                    HStack{
                    Text("Duration")
                        .fontWeight(.semibold)
                        .padding(.leading,16)
                        .font(.system(size: 14))
                        .foregroundColor(gk.colorSystem.vinlCTRLHintColor)
                    Spacer()
                        Text("1hr")
                            .font(.system(size: 14))
                            .padding(.trailing,16)
                }
            Rectangle().frame(width: 358, height: 1)
                        .foregroundColor(gk.colorSystem.vinlCTRLDarkColorStroke)
                    
                }.padding(.bottom,14)
                Group{
                    HStack{
                    Text("Location")
                        .fontWeight(.semibold)
                        .padding(.leading,16)
                        .font(.system(size: 14))
                        .foregroundColor(gk.colorSystem.vinlCTRLHintColor)
                    Spacer()
                        Text("123, XYZ street,\n Jakarta, Indonesia")
                            .font(.system(size: 14))
                            .padding(.trailing,16)
                }
            Rectangle().frame(width: 358, height: 1)
                        .foregroundColor(gk.colorSystem.vinlCTRLDarkColorStroke)
                    
                }.padding(.bottom,14)
                
                Group{
                    Text("Additional Request  :  Please play our favorite song\n 'Perfect' by Ed Sheeran for the first dance.")
                        .font(.system(size: 14))
                }
                Group{
                    Spacer()
                    Button {
                        print("I touched a button and I liked it")
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.yellow)
                            .frame(width: 342, height: 60)
                            .overlay(Text("Return to Home").foregroundColor(gk.colorSystem.vinylCTRLDarkColor))
                    }
                    Spacer().frame(height:20)
                }
                
            }
            
        }
    }
}

struct BookingDetailsPaidTotal_Previews: PreviewProvider {
    static var previews: some View {
        BookingDetailsPaidTotal()
    }
}
