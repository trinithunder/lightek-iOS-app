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
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing:20) {
                    Text("Email:")
                    
                    TextField("Enter your email", text: $email)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                        .border(Color.blue, width: 1)
                        .padding(.top,20)
                        .padding(.bottom,20)

                    
                    Text("Password:")
                    SecureField("Enter your password", text: $password)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                        .border(Color.blue, width: 1)
                        .padding(.top,20)
                        .padding(.bottom,20)
                    
                    RoundedRectangle(cornerRadius: 3.0)
                        .frame(width: UIScreen.main.bounds.width - 20,height:50)
                        .foregroundColor(Color.blue)
                        .overlay(Button("\(Text("Login").foregroundColor(Color.white))") {
                            loginUserIn()
                        })
                    
                }
            }
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }
        }
        
    }
    
    func loginUserIn(){
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
