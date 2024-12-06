//
//  BookingSummaryView.swift
//  Lightek
//
//  Created by Marlon on 12/5/24.
//

//TODO: - Check for if you are missing any fields from being filled out and trigger the booking error

import SwiftUI

struct BookingSummaryView: View {
    @State private var eventType = "" // Currently selected value
    @State private var eventTimeDate = "" // Currently selected value
        @State private var options = ["Wedding","Corporate Event", "Private Party","Clubs/Bar Gig","Festival","Concert","School Event","Other"] // List of options
        @State private var bookingError = false // Error flag
    @State private var selectedDate = Date() // State to hold the selected date and time
    @State private var phoneNumber = ""
    @State private var location = ""
    @State private var additionalRequest = ""
    var body: some View {
        ZStack{
            gk.vinylCTRLDarkColor.ignoresSafeArea()
            ScrollView{
                VStack{
                    //Spacer().frame(height:10)
                    Text("Booking Summary")
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                    Group{
                        HStack {
                                    Spacer()
                                    Picker(selection: $eventType, label: Text("Event type")) {
                                        ForEach(options, id: \.self) { option in
                                            Text(option).tag(option)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle()) // Use a menu-style picker for a dropdown-like appearance
                                    .frame(width: 358, height: 62)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .strokeBorder(bookingError ? Color.red : Color.gray, lineWidth: 1)
                                    )
                                    .padding(.leading, 50)
                                    Spacer()
                                }
                    
                        HStack {
                                    Spacer()
                                    DatePicker(
                                        "Pick a date or time",
                                        selection: $selectedDate,
                                        displayedComponents: [.date, .hourAndMinute] // Enables both date and time selection
                                    )
                                    .labelsHidden() // Hides the default label
                                    .frame(width: 358, height: 62)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .strokeBorder(bookingError ? Color.red : Color.gray, lineWidth: 1)
                                    )
                                    .padding(.leading, 50)
                                    Spacer()
                                }
                    
                    HStack{
                        Spacer()
                        TextField("Phone number", text: $phoneNumber)
                        .multilineTextAlignment(.center)
                        .frame(width: 358, height: 62)
                        .background(RoundedRectangle(cornerRadius: 30).strokeBorder(bookingError ? Color.red:Color.gray, lineWidth: 1))
                        .padding(.leading, 50)
                        Spacer()
                        
                    }
                    
                    HStack{
                        Spacer()
                        TextField("location", text: $location)
                        .multilineTextAlignment(.center)
                        .frame(width: 358, height: 62)
                        .background(RoundedRectangle(cornerRadius: 30).strokeBorder(bookingError ? Color.red:Color.gray, lineWidth: 1))
                        .padding(.leading, 50)
                        Spacer()
                        
                    }
                    
                    HStack{
                        Spacer()
                        TextField("Additional request", text: $additionalRequest)
                        .multilineTextAlignment(.center)
                        .frame(width: 358, height: 62)
                        .background(RoundedRectangle(cornerRadius: 30).strokeBorder(bookingError ? Color.red:Color.gray, lineWidth: 1))
                        .padding(.leading, 50)
                        Spacer()
                        
                    }}
                    .padding(.bottom,22)
                    HStack{
                        Text("Total Price Summary").foregroundColor(.white).font(.system(size: 17)).padding(.leading,16)
                        Spacer()
                    }
                    Spacer().frame(height:12)
                    
                    Group{
                        HStack{
                            Image(systemName: "house").font(.system(size: 94)).padding(.top,-50)
                            VStack{
                                Text("Taylor Swift").foregroundColor(.yellow)
                                RoundedRectangle(cornerRadius: 25).foregroundColor(.purple).frame(width: 158, height: 26).overlay(Text("Professional (5+ Years)").font(.system(size: 18)).padding())
                                Spacer()
                                HStack{
                                    Spacer()
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Image(systemName: "star")
                                    Text("5.0 " + "(128)")
                                    Spacer()
                                }
                                Spacer().frame(height:14)
                                HStack{
                                    Text("Deposit")
                                    Spacer()
                                    Text("$2.00")
                                    Spacer()
                                }
                                Spacer().frame(height:12)
                                HStack{
                                    Text("Order Price")
                                    Spacer()
                                    Text("$2.00")
                                    Spacer()
                                }
                                Spacer().frame(height:12)
                                HStack{
                                    Text("Total Price")
                                    Spacer()
                                    Text("$2.00")
                                    Spacer()
                                }.padding(.bottom, 10)

                            }
                            Spacer()
                        }
                        
                        
                    }.frame(width: UIScreen.main.bounds.width - 20).background(RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color(hex: "1E1E1E")))
                   Spacer().frame(height:80)
                    if bookingError{
                        Spacer().frame(height:10)
                        HStack{
                            Text("")
                            Spacer()
                        }.background(RoundedRectangle(cornerRadius: 2).frame(width: 338, height: 52).foregroundColor(.white).overlay(HStack{
                            Image(systemName: "exclamationmark.triangle.fill").padding(.leading,6).foregroundColor(.red)
                            Text("Please fill out the required details above.").font(.system(size: 20)).foregroundColor(.black)
                        }))
                    }else{
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
                    }
                    

                    Spacer().frame(height:20)
                }.onAppear{
                    //Pass in the selected user information.
                }
            }
            
        }
    }
}

struct BookingSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        BookingSummaryView()
    }
}
