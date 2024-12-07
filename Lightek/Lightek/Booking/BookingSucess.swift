//
//  BookingSucess.swift
//  Lightek
//
//  Created by Marlon on 12/5/24.
//

import SwiftUI

struct BookingSucess: View {
    @EnvironmentObject var gk:GateKeeper
    var body: some View {
        ZStack{
            gk.vinylCTRLDarkColor?.ignoresSafeArea()
            VStack{
                Image(systemName: "checkmark")
                    .frame(width: 200, height: 140)
                    .foregroundColor(.yellow)
                Text("Thank you!").foregroundColor(.white)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                Spacer().frame(height:12)
                Text("You’ve successfully accepted the booking request. Click the button below to view the booking details. Thank you!")
                    .foregroundColor(gk.vinlCTRLHintColor)
                    .font(.system(size: 14))
                Spacer()
                Button {
                    //
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.yellow)
                        .frame(width: 342, height: 60)
                        .overlay(Text("View Booking Details").foregroundColor(gk.vinylCTRLDarkColor))
                }

                Spacer().frame(height:20)
            }
            
        }
    }
}

struct BookingSucess_Previews: PreviewProvider {
    static var previews: some View {
        BookingSucess()
    }
}
