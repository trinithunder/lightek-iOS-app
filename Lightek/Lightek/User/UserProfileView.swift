//
//  UserProfileView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI

struct UserProfileView: View {
    @State var contentItems:[User] = []
    @EnvironmentObject var gk:GateKeeper
    @State var selectedSegment = 0
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                     //Segmented Picker (Segmented Control)
                              Picker("Select View", selection: $selectedSegment) {
                                  Text("View 1").tag(0)
                                  Text("View 2").tag(1)
                                  Text("View 3").tag(2)
                              }
                              .pickerStyle(SegmentedPickerStyle()) // Use the segmented style
                              
                              // Spacer to add some space between the segmented control and the views
                    
                    // Conditionally display different views based on the selected segment
                    if selectedSegment == 0 {
                        ForEach(contentItems,id:\.self){ item in
                            NavigationLink(destination: Text("This is will be the detail view it goes to")) { Text(item.user_profile.first_name).foregroundColor(.blue) }
                        }
                    } else if selectedSegment == 1 {
                        ForEach(contentItems,id:\.self){ item in
                            NavigationLink(destination: Text("This is will be the detail view it goes to")) { HomeCell(imageURL: "")
                            }
                        }
                    } else {
                        ForEach(contentItems,id:\.self){ item in
                            NavigationLink(destination: Text("This is will be the detail view it goes to")) { HomeCell(imageURL: "") }
                        }
                    }
                    
                    //make a grid of produced items here:
                }
            }
        }.onAppear{
            gk.loadThatJson(myCodeableObject: User.self) { items in
                contentItems = items
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(GateKeeper())
    }
}
