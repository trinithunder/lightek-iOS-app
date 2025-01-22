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
    @State var showSearch = false
    @State var menuItems:[ProfileSettingItem] = [ProfileSettingItem(title: "Edit Profile", iconImage: "chevron.right"),ProfileSettingItem(title: "Check availability", iconImage: "chevron.right"),ProfileSettingItem(title: "Transactions detail", iconImage: "chevron.right"),ProfileSettingItem(title: "Settings", iconImage: "chevron.right"),ProfileSettingItem(title: "Logout", iconImage: "chevron.right"),ProfileSettingItem(title: "Delete account", iconImage: "chevron.right")]
    @State var showImagePicker = false
    var body: some View {
        NavigationView {
            ZStack{
                gk.vinylCTRLDarkColor.ignoresSafeArea()
                ScrollView {
                    VStack(spacing:20){
                        Button{
                            showSearch.toggle()
                        }label:{
                            SearchBar().fullScreenCover(isPresented: $showSearch) {
                                
                            } content: {
                                SearchView()
                            }
                        }
                        
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
                            
                            ForEach(contentItems,id:\.self){ item in
                                Group{
                                    HStack{
                                        Button{
                                          print("::..Image upload called..::")
                                            showImagePicker.toggle()
                                        }label:{
                                            //Add a user image url to the user profile model so we can pass it in here
                                            if gk.profileImage == Image(systemName:"house"){
                                                Circle().frame(width: 118, height: 121).foregroundColor(.yellow).overlay(Text("D").font(.system(size:104)))
                                            }else{
                                                //Replace with profile_image from the user profile model
                                                gk.profileImage
                                                    .resizable()
                                                    .frame(width: 118, height: 121)
                                            }
                                        }
                                    
                                    VStack(spacing:9){
                                        Text("\(item.user_profile.first_name ?? "") " + "\(item.user_profile.last_name ?? "")").foregroundColor(.white).font(.system(size:20))
                                            .padding(.bottom,9)
                                        Text("\(item.user_profile.experience ?? "")" ).foregroundColor(.white).font(.system(size:12))
                                            .background(RoundedRectangle(cornerRadius: 25).frame(width:163,height:26).foregroundColor(.purple).padding(.top,10).padding(.trailing,10).padding(.bottom,10).padding(.leading,10)).padding(.bottom,9)
                                            .opacity(item.user_profile.experience == nil ? 0:1)
                                        Text("\(item.user_profile.bio ?? "")").foregroundColor(.white).font(.system(size: 13))
                                    }.frame(width:224).opacity(item.user_profile.bio == nil ? 0:1)
                                }}
                                Group{
                                    HStack{
                                    Image(systemName: "house").foregroundColor(.white).padding(.leading,16)
                                    Text("\(item.user_profile.location ?? "")").foregroundColor(.white).font(.system(size:12))
                                    Spacer()
                                    }.opacity(item.user_profile.location == nil ? 0:1)
                                Rectangle().frame(width:UIScreen.main.bounds.width,height:4).foregroundColor(.gray)
                                Spacer().frame(height:20)}
                                
                                Group{
                                    ForEach(menuItems,id:\.self){menuItem in
                                        Group{
                                            Button {
                                            //Switch on the menu items title to see what we doing on the trasition.
                                                switch menuItem.title {
                                                case "Edit Profile":
                                                    showImagePicker.toggle()
                                                case "Check availability":
                                                    print("")
                                                case "Transactions detail":
                                                    print("")
                                                case "Settings":
                                                    print("")
                                                case "Logout":
                                                    print("")
                                                case "Delete account":
                                                    print("Aight you're out of here...DELETE!")
                                                default:
                                                    print("Pump fake")
                                                }
                                        } label: {
                                            VStack{
                                                HStack{
                                                    Text(menuItem.title.uppercased())
                                                        .foregroundColor(.white)
                                                        .padding(.leading,16)
                                                    Spacer()
                                                    Image(systemName:menuItem.iconImage).foregroundColor(.yellow)
                                                        .background(Circle().frame(width:24,height:24).padding().foregroundColor(gk.vinylCTRLDarkColor)).padding(.trailing,16)
                                                    
                                                    
                                                }
                                                Spacer().frame(height:14)
                                                Rectangle().frame(width:UIScreen.main.bounds.width,height:1).foregroundColor(.gray)
                                            }
                                        }}
                                        
                                    }
                                }
                                
                                Group{Spacer()
                                    
                                }

                            }
                            
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
                    .fullScreenCover(isPresented: $showImagePicker) {
                        ImageUploaderView(showImageUploader: $showImagePicker)
                            }
                }.foregroundColor(gk.vinylCTRLPurp)
            }
        }.onAppear{
            gk.loadThatJson(myCodableObject: gk.currentUser,id: gk.currentUser.id) { items in
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
