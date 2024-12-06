//
//  UserProfileView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI

struct SearchBar:View {
    var body: some View{
        HStack{
            Image(systemName: "house").foregroundColor(.gray)
            VStack{
                Text("In here will be something for search").foregroundColor(.white).font(.system(size: 16))
                Text("In here will be something for search").foregroundColor(.gray).font(.system(size: 12))
            }
            Spacer()
            Image(systemName: "bell").foregroundColor(.white)
            Image(systemName: "house").foregroundColor(.yellow).padding(.trailing,16)
        }
    }
}

struct UserProfileView: View {
    @State var contentItems:[User] = []
    @EnvironmentObject var gk:GateKeeper
    @State var selectedSegment = 0
    var body: some View {
        NavigationView {
            ZStack{
                gk.vinylCTRLBlk.ignoresSafeArea()
                ScrollView {
                    VStack(spacing:20){
                        SearchBar()
                        
                        HStack{
                            Text("Profile").font(.largeTitle).foregroundColor(.white).padding(.leading,16)
                            Spacer()
                        }
                        
                         //Segmented Picker (Segmented Control)
                                  Picker("Select View", selection: $selectedSegment) {
                                      Text("Personal Information").tag(0)
                                      Text("Services").tag(1)
                                  }
                                  .pickerStyle(SegmentedPickerStyle())
                                  .background(Color.clear) // Remove default background
                                              .overlay(
                                                  RoundedRectangle(cornerRadius: 8) // Shape for customizing
                                                      .stroke(Color.black.opacity(0.3), lineWidth: 1) // Optional stroke
                                              )
                                              .modifier(CustomSegmentedStyle(selectedIndex: selectedSegment))
                                              .padding()// Use the segmented style
                                  
                                  // Spacer to add some space between the segmented control and the views
                        
                        // Conditionally display different views based on the selected segment
                        if selectedSegment == 0 {
                            HStack{
                                Circle().frame(width: 118, height: 121).foregroundColor(.yellow).overlay(Text("D").font(.system(size:104)))
                                VStack(spacing:9){
                                    Text("John Doe").foregroundColor(.white).font(.system(size:20))
                                    Text("Years of experience goes here").foregroundColor(.white).font(.system(size:12))
                                    Text("Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet consectetur lorem ipsum dolor sit amet.").foregroundColor(.white).font(.system(size: 13))
                                }.frame(width:224)
                            }
                            HStack{
                                Image(systemName: "house").foregroundColor(.white).padding(.leading,16)
                                Text("123, XYZ street, Jakarta, Indonesia").foregroundColor(.white).font(.system(size:12))
                                Spacer()
                            }
                            Rectangle().frame(width:UIScreen.main.bounds.width,height:4).foregroundColor(.gray)
//                            ForEach(contentItems,id:\.self){ item in
//                                NavigationLink(destination: Text("This is will be the detail view it goes to")) { Text(item.user_profile.first_name).foregroundColor(.blue) }
//                            }
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
            }
        }.onAppear{
            gk.loadThatJson(myCodeableObject: User.self,id: gk.currentUser) { items in
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


struct CustomSegmentedStyle: ViewModifier {
    var selectedIndex: Int

    func body(content: Content) -> some View {
        content
            .onAppear {
                // Remove default background colors
                UISegmentedControl.appearance().backgroundColor = .clear
                UISegmentedControl.appearance().selectedSegmentTintColor = .black
                
                UISegmentedControl.appearance().setTitleTextAttributes(
                    [NSAttributedString.Key.foregroundColor: UIColor.gray],
                    for: .normal
                )

                UISegmentedControl.appearance().setTitleTextAttributes(
                    [NSAttributedString.Key.foregroundColor: UIColor.white],
                    for: .selected
                )

            }
            .overlay(
                CustomHighlight(selectedIndex: selectedIndex),
                alignment: .bottom
            )
    }
}

struct CustomHighlight: View {
    var selectedIndex: Int
    let segmentCount = 2 // Adjust this to match the number of segments
    let segmentHeight: CGFloat = 2 // Height of the highlight line
    @EnvironmentObject var gk:GateKeeper
    
    var body: some View {
        GeometryReader { geometry in
            let segmentWidth = geometry.size.width / CGFloat(segmentCount)
            
            Rectangle()
                .fill(gk.vinylCTRLYellow) // Color of the highlight
                .frame(width: segmentWidth, height: segmentHeight)
                .offset(x: CGFloat(selectedIndex) * segmentWidth)
                .animation(.easeInOut(duration: 0.3), value: selectedIndex)
        }
        .frame(height: segmentHeight)
    }
}
