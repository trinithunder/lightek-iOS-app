//
//  ContentView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    @State var userNeedsToAuth = false //Need to get this value from User defaults
    var body: some View {
       TabView(selection: $selection) {
            HomeView().tabItem { Text("Home") }.tag(1)
            OrdersView().tabItem { Text("Orders") }.tag(2)
           Text("I guess this is a create view").tabItem {
               Text("+")
               }.tag(3)
           ChatView().tabItem { Text("Chats") }.tag(4)
           
        UserProfileView().tabItem { Text("Profile") }.tag(5)
       }.fullScreenCover(isPresented: $userNeedsToAuth) {
           userNeedsToAuth.toggle()
           //Need to set userNeedsToAuth value in User defaults
       } content: {
           Text("Please sign the fuck in")
       }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
