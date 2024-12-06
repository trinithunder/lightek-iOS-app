//
//  BookingSummaryPaymentMethod.swift
//  Lightek
//
//  Created by Marlon on 12/5/24.
//

import SwiftUI

struct BookingSummaryPaymentMethod: View {
    @EnvironmentObject var gk:GateKeeper
    var body: some View {
        ZStack{
            gk.vinylCTRLDarkColor.ignoresSafeArea()
            VStack(spacing:16){
                Text("Payment Method").foregroundColor(.white).font(.largeTitle).fontWeight(.bold)
                Spacer().frame(height:30)
                ForEach(PaymentMethod.allCases, id: \.self) { method in
                                HStack {
                                    Image(systemName: method == .applePay ? "applelogo" : "creditcard.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text(method.rawValue)
                                        .font(.headline)
                                    Spacer()
                                    Image(systemName: gk.selectedPaymentMethod == method ? "checkmark": "")
                                            .foregroundColor(.black)
                                            .padding()
                                            .background(
                                                            Circle()
                                                                .fill(gk.selectedPaymentMethod == method ? Color.yellow : Color.clear)
                                                                .overlay(
                                                                    Circle()
                                                                        .stroke(gk.selectedPaymentMethod == method ? Color.clear : Color.gray, lineWidth: 1)
                                                                )
                                                        )
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(gk.selectedPaymentMethod == method ? Color.blue : Color.gray, lineWidth: 1)
                                        .frame(height: 80)
                                )
                                .onTapGesture {
                                    gk.selectedPaymentMethod = method
                                }
                    Spacer().frame(height:20)
                            }
                Spacer()
                
                Button {
                    //
                } label: {
                    RoundedRectangle(cornerRadius: 25).frame(width: 342, height: 60).foregroundColor(.yellow).overlay(VStack{
                        Text("Pay $30.65").foregroundColor(.black)
                        Text("Full price").foregroundColor(.gray)
                    })
                }
                
                Button {
                    //
                } label: {
                    RoundedRectangle(cornerRadius: 25).frame(width: 342, height: 60).foregroundColor(.yellow).overlay(VStack{
                        Text("Pay $2.00").foregroundColor(.black)
                        Text("Deposit").foregroundColor(.gray)
                    })
                }
                Spacer().frame(height:20)

                
            }
        }
    }
}

struct BookingSummaryPaymentMethod_Previews: PreviewProvider {
    static var previews: some View {
        BookingSummaryPaymentMethod()
    }
}
