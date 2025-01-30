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
    @EnvironmentObject var gk:GateKeeper
    @State var loginContext = LoginTextContent()
    var body: some View {
        NavigationView {
            ZStack{
                gk.colorSystem.vinylCTRLDarkColor.ignoresSafeArea()
                ScrollView{
                VStack(spacing:20) {
                    HStack{loginContext.welcomeText.foregroundColor(.gray).padding(.leading,16)
                        //Image(systemName: "house").foregroundColor(.yellow)
                        Spacer()
                    }
                    loginContext.signInText.font(.largeTitle).foregroundColor(.white)
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.yellow, lineWidth: 1) // Add a light gray stroke
                        .frame(width: UIScreen.main.bounds.width - 20, height: 62)
                        .overlay(
                            TextField(
                                "",
                                text: $phoneNumber,
                                prompt: loginContext.phoneNumberText
                                    .foregroundColor(.white) // Set the placeholder text color
                            )
                            .foregroundColor(.white) // Set the actual input text color
                            .padding(.horizontal) // Add padding for better appearance
                        )
                    loginContext.wrongNumberText.foregroundColor(.red).opacity(isIncorrectPhoneNumber ? 1:0)
                    Spacer().frame(height:320)
                    
                    loginContext.tosText.foregroundColor(.white)
                    
                    Button {
                        //Upon success of your phone number passing auth we will then show you the auth code screen
                        //loginUserIn()
                        showAuthCodeScreen.toggle()
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.yellow)
                            //.stroke(Color.gray, lineWidth: 1) // Add a light gray stroke
                            .frame(width: UIScreen.main.bounds.width - 20, height: 62).overlay(loginContext.loginText.foregroundColor(.black)).fullScreenCover(isPresented: $showAuthCodeScreen) {
                                //Figure out what we want to do on dismiss here
                            } content: {
                                AuthCodeView()
                            }

                    }

                    
                    HStack{
                        loginContext.noAccountText.foregroundColor(.white)
                        Button {
                            showRegisterScreen.toggle()
                        } label: {
                            loginContext.registerText.foregroundColor(.yellow).fullScreenCover(isPresented: $showRegisterScreen) {
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
    struct zForLogIn:CodableHashable{
        
    }
    func loginUserIn(){
        gk.loadThatJson(myCodableObject: zForLogIn()) { items in
            //get the objects out of the items array, mainly should be email, and token(if I chose so) and a bool.
            //Set bool response to a show this view/dismiss or change userNeedsAuth or something like that.
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userNeedsToAuth:.constant(true))
    }
}
