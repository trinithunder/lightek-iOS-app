//
//  BookingSummaryView.swift
//  Lightek
//
//  Created by Marlon on 12/5/24.
//

import SwiftUI

struct BookingSummaryView: View {
    @State private var eventTimeDate = ""
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack(spacing:16){
                //Spacer().frame(height:10)
                Text("Booking Summary")
                    .foregroundColor(.white)
                    .font(.system(size: 28))
                Group{
                    HStack{
                    Spacer()
                    TextField("", text: $eventTimeDate)
                    .multilineTextAlignment(.center)
                    .frame(width: 358, height: 62)
                    .background(RoundedRectangle(cornerRadius: 30).strokeBorder(Color.gray, lineWidth: 1))
                    .padding(.leading, 50)
                    Spacer()
                    
                }
                
                HStack{
                    Spacer()
                    TextField("", text: $eventTimeDate)
                    .multilineTextAlignment(.center)
                    .frame(width: 358, height: 62)
                    .background(RoundedRectangle(cornerRadius: 30).strokeBorder(Color.gray, lineWidth: 1))
                    .padding(.leading, 50)
                    Spacer()
                    
                }
                
                HStack{
                    Spacer()
                    TextField("", text: $eventTimeDate)
                    .multilineTextAlignment(.center)
                    .frame(width: 358, height: 62)
                    .background(RoundedRectangle(cornerRadius: 30).strokeBorder(Color.gray, lineWidth: 1))
                    .padding(.leading, 50)
                    Spacer()
                    
                }
                
                HStack{
                    Spacer()
                    TextField("", text: $eventTimeDate)
                    .multilineTextAlignment(.center)
                    .frame(width: 358, height: 62)
                    .background(RoundedRectangle(cornerRadius: 30).strokeBorder(Color.gray, lineWidth: 1))
                    .padding(.leading, 50)
                    Spacer()
                    
                }
                
                HStack{
                    Spacer()
                    TextField("", text: $eventTimeDate)
                    .multilineTextAlignment(.center)
                    .frame(width: 358, height: 62)
                    .background(RoundedRectangle(cornerRadius: 30).strokeBorder(Color.gray, lineWidth: 1))
                    .padding(.leading, 50)
                    Spacer()
                    
                }}
                .padding(.bottom,22)
                Text("Total Price Summary").foregroundColor(.white).font(.system(size: 12))
                Spacer().frame(height:70)
                
                Group{
                 Text("Seeing if I did this right")
                }.background(RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.red)
                                .frame(width: 358, height: 200))
               Spacer().frame(height:80)
                HStack{
                    Button {
                    //
                } label: {
                    VStack{
                        Text("Pay $2.00").foregroundColor(.yellow)
                        Text("Deposit").foregroundColor(.white)
                    }.background(RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(.purple)
                                    .frame(width: 164, height: 52))
                }
                    Spacer().frame(width:100)
                    Button {
                        //
                    } label: {
                        VStack{
                            Text("Pay $30.65").foregroundColor(.black)
                            Text("Full price").foregroundColor(.white)
                        }.background(RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(.yellow)
                                        .frame(width: 164, height: 52))
                    }
                }

                Spacer()
            }
            
        }
    }
}

struct BookingSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        BookingSummaryView()
    }
}
