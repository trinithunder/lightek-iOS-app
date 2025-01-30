//
//  SignUpView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var gk:GateKeeper
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
                        .overlay(Button("\(Text("Sign up").foregroundColor(Color.white))") {
                            gk.currentUser.signup(email: email, password: password) { sign_up_status in
                                //Most likely take sign_up_status and pass that to a binded object that will 
                            }
                        })
                    
                }
            }
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }
        }
        
    }
    
    func registerUser(params:[String:Any]) {
//        gk.postThatJson(parms: ["":""])
        let imageData = ImageMetaData()
        gk.loadThatJson(myCodableObject: imageData) { ResponseOb in
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
