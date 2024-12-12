//
//  DCLaunchScreen.swift
//  Lightek
//
//  Created by Marlon on 12/12/24.
//

import SwiftUI

struct DCLaunchScreen: View {
    @EnvironmentObject var gk:GateKeeper
    var body: some View {
        ZStack{
            gk.vinylCTRLBlk.ignoresSafeArea()
            VStack{
                HStack{
                    Text("2:38").foregroundColor(.blue)
                    Text("Havic").foregroundColor(.blue)
                    Spacer().frame(width:80)
//                    Image(systemName: "house").resizable()
//                        .frame(width: 50, height: 50).foregroundColor(.blue)
                    EmptyView()
                    Spacer()
                    Text("Lightek").foregroundColor(.blue)
                    Image(systemName: "antenna.radiowaves.left.and.right").foregroundColor(.blue)
                    Image(systemName: "battery.full").foregroundColor(.blue)
                    
                    
                }
                Spacer().frame(height:200)
                
                Text("Your dreams".uppercased()).foregroundColor(.blue).font(.system(size: 36))
                
                Text("are calling you").foregroundColor(.blue).font(.subheadline)
                
                Spacer().frame(height:15)
                Group{
                    HStack{
                    Spacer().frame(width:100)
                    loadButtonImage(title: "Answer", buttonImage: "phone", buttonColor: .blue, width: 100.0)
                    Spacer()
                    
                        loadButtonImage(title: "Ignore", buttonImage: "phone", buttonColor: .red, width: 100.0)
                    Spacer().frame(width:100)
                }}
                
                
                //Bottom spacer to bring everything up everthing before this
                Spacer()
            }
            
        }
    }
    
    func loadButtonImage(title:String,buttonImage:String,buttonColor:Color,width:CGFloat)-> some View{
        return VStack{
            
            Spacer().frame(height:75)
            Circle().frame(width: width, height: width).foregroundColor(buttonColor).overlay(Image(systemName:buttonImage).resizable()
                                                                                                .frame(width: width/4, height: width/4).foregroundColor(.white))
            Spacer().frame(height:15)
            Text(title).foregroundColor(buttonColor)
        }
    }
}

struct DCLaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        DCLaunchScreen()
    }
}
