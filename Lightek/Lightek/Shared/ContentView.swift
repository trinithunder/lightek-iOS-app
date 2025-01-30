//
//  ContentView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

//TODO: - Need to add TshangSung into this and have the logout action in the settings be able to trigger the home tab after setting user needs to auth.

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    @State var userNeedsToAuth = !UserDefaults.standard.bool(forKey: "userNeedsToAuth") //Need to get this value from User defaults
    
    @State var showLoadingScreen = true
    @EnvironmentObject var gk:GateKeeper
    @State var showContentView = false
    
    init() {
            // Change unselected and selected item colors
            let tabBarAppearance = UITabBar.appearance()
            tabBarAppearance.unselectedItemTintColor = UIColor.gray // Default color for unselected items
            tabBarAppearance.tintColor = UIColor.white // Color for selected items
            tabBarAppearance.backgroundColor = UIColor.black // Background color (optional)
        }
    
    var body: some View {
        
       ZStack{
           gk.colorSystem.vinylCTRLBlk.ignoresSafeArea()
           TabView(selection: $selection) {
            HomeHub().tabItem { Text("Home") }.tag(1)
           BookingsView().tabItem { Text("Orders") }.tag(2)
           Text("I guess this is a create view").tabItem {
               Text("Add")
               }.tag(3)
           ChatView().tabItem { Text("Chats") }.tag(4)
           
        UserProfileView().tabItem { Text("Profile") }.tag(5)
       }
       .opacity(showContentView ? 1:0)
       .fullScreenCover(isPresented: .constant(false)) {
           //userNeedsToAuth.toggle()
           //Need to set userNeedsToAuth value in User defaults
           UserDefaults.standard.set(userNeedsToAuth, forKey: "userNeedsToAuth")
       } content: {
           LoginView(userNeedsToAuth:$userNeedsToAuth)
       }
       .fullScreenCover(isPresented: $showLoadingScreen) {
           //Figure what I want to do here on dissmiss if anything
       } content: {
           DCLaunchScreen()
               .onAppear{
               
           }
               .onReceive(gk.showSplashScreenTimer) { _ in
               //showLodingScreen.toggle()
              // gk.invalidateTimer(showTimer: true)
               showContentView.toggle()
               print("Show content view \(showContentView)")
               showLoadingScreen = gk.invalidateTimer(showTimer: showContentView)
           }
               .onDisappear{
                   print("I'm up out of here fam! Because showContentView is \(!showLoadingScreen)")
               }
       }}

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
