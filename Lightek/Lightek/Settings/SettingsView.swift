//
//  SettingsView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

struct SettingsButton:Hashable{
var image:String
var title:String
var buttonType:SettingsButtonType
var buttonImage:String
    
}

enum SettingsButtonType {
case logOut
case deleteAccount
}

import SwiftUI

struct SettingsView: View {
    @State var contentItems:[SettingsButton] = [SettingsButton(image: "", title: "", buttonType: .logOut, buttonImage: ""),SettingsButton(image: "", title: "", buttonType: .deleteAccount, buttonImage: ""),SettingsButton(image: "", title: "", buttonType: .deleteAccount, buttonImage: ""),SettingsButton(image: "", title: "", buttonType: .deleteAccount, buttonImage: "")]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing:16){
                    //Going to need a custom settings button object
                    //Example: SettingsButton{image:string,title:string,buttonType:.logOut,buttonImage:string}
                    Text("Push notification     button")
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    ForEach(contentItems,id:\.self){ item in
                        //switch on the buttonType to dictate where the destination goes eithier to a content page or logout/delete modal.
                        switch item.buttonType {
                        case .logOut:
                            NavigationLink(destination: Text("This is will be the detail view for each setting I have selected")) { Text("Settings item here").foregroundColor(.blue) }
                        case .deleteAccount:
                            NavigationLink(destination: Text("This is will be the detail view for each setting I have selected")) { Text("Settings item here").foregroundColor(.blue) }
                        }
                        
                    }
                }
                .onAppear {
                    //Will set the contentItems array here
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
