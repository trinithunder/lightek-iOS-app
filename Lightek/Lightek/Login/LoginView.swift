//
//  LoginView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @Binding var userNeedsToAuth:Bool
    @State var phoneNumber = ""
    @State var isIncorrectPhoneNumber = false
    @State var showRegisterScreen = false
    @State var showAuthCodeScreen = false
    var body: some View {
        NavigationView {
            ZStack{
                Color.black.ignoresSafeArea()
                ScrollView{
                VStack(spacing:20) {
                    HStack{Text("Welcome back 👋").foregroundColor(.gray).padding(.leading,16)
                        //Image(systemName: "house").foregroundColor(.yellow)
                        Spacer()
                    }
                    Text("Sign into your account").font(.largeTitle).foregroundColor(.white)
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.yellow, lineWidth: 1) // Add a light gray stroke
                        .frame(width: UIScreen.main.bounds.width - 20, height: 62)
                        .overlay(
                            TextField(
                                "",
                                text: $phoneNumber,
                                prompt: Text("Enter phone number")
                                    .foregroundColor(.white) // Set the placeholder text color
                            )
                            .foregroundColor(.white) // Set the actual input text color
                            .padding(.horizontal) // Add padding for better appearance
                        )
                    Text("Oops! Incorrect Phone Number try another one.").foregroundColor(.red).opacity(isIncorrectPhoneNumber ? 1:0)
                    Spacer().frame(height:320)
                    
                    Text("By using VinylCTRL, you agree to the/n  Terms of Conditions and Privacy Policy.").foregroundColor(.white)
                    
                    Button {
                        //Upon success of your phone number passing auth we will then show you the auth code screen
                        //loginUserIn()
                        showAuthCodeScreen.toggle()
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.yellow)
                            //.stroke(Color.gray, lineWidth: 1) // Add a light gray stroke
                            .frame(width: UIScreen.main.bounds.width - 20, height: 62).overlay(Text("Login").foregroundColor(.black)).fullScreenCover(isPresented: $showAuthCodeScreen) {
                                //Figure out what we want to do on dismiss here
                            } content: {
                                AuthCodeView()
                            }

                    }

                    
                    HStack{
                        Text("Don’t have an account? ").foregroundColor(.white)
                        Button {
                            showRegisterScreen.toggle()
                        } label: {
                            Text("Register").foregroundColor(.yellow).fullScreenCover(isPresented: $showRegisterScreen) {
                                //Will figure what we want to do on dismiss here later
                            } content: {
                                SignUpView()
                            }

                        }

                    }
                    Spacer().frame(height:200)

                }
                    
            }}
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }
        }.onAppear {
            userNeedsToAuth.toggle()
        }
        
    }
    
    func loginUserIn(){
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userNeedsToAuth:.constant(true))
    }
}
