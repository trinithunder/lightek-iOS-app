//
//  BookingsView.swift
//  Lightek
//
//  Created by Marlon on 11/26/24.
//

import SwiftUI

struct BookingsView: View {
    @EnvironmentObject var gk:GateKeeper
    // State variable to track the selected segment index
        @State private var selectedSegment = 0
    @State var contentItems:[HomeContentItem] = [HomeContentItem(),HomeContentItem(),HomeContentItem(),HomeContentItem()]
    var body: some View {
        ZStack{
            gk.colorSystem.vinylCTRLDarkColor.ignoresSafeArea()
            ScrollView{
                VStack{
                    
                    HStack{
                        Text("Bookings")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding(.leading,16)
                        Spacer()
                    }
                    Spacer().frame(height:50)
                    
                    // Segmented Picker (Segmented Control)
                              Picker("Select View", selection: $selectedSegment) {
                                  Text("Rejected").tag(0)
                                  Text("Completed").tag(1)
                                  Text("Pending").tag(2)
                                  Text("Upcoming").tag(3)
                              }
                              .pickerStyle(SegmentedPickerStyle()) // Use the segmented style
                              
                              // Spacer to add some space between the segmented control and the views
                    Spacer()
                        .frame(height:50)
                              
                              // Conditionally display different views based on the selected segment
                              if selectedSegment == 0 {
                                  ForEach(contentItems,id:\.self){ item in
                                      NavigationLink(destination: HomeDetailView()) {
                                          HomeCell(imageURL: "https://images3.alphacoders.com/678/678085.jpg")
                                      }
                                  }
                              } else if selectedSegment == 1 {
                                  ForEach(contentItems,id:\.self){ item in
                                      NavigationLink(destination: Text("This is will be the detail view it goes to")) { HomeCell(imageURL: "")
                                      }
                                  }
                              }else if selectedSegment == 2 {
                                  ForEach(contentItems,id:\.self){ item in
                                      NavigationLink(destination: Text("This is will be the detail view it goes to")) { HomeCell(imageURL: "")
                                      }
                                  }
                              }
                    else {
                                  ForEach(contentItems,id:\.self){ item in
                                      NavigationLink(destination: Text("This is will be the detail view it goes to")) { HomeCell(imageURL: "") }
                                  }
                              }
                }
            }
            .background(gk.colorSystem.vinylCTRLDarkColor)
            //.ignoresSafeArea()
                }
            }
        }

struct BookingsView_Previews: PreviewProvider {
    static var previews: some View {
        BookingsView()
    }
}
