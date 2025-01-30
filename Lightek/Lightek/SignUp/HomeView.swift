//
//  HomeView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI
struct HomeContentItem:Hashable{
    
}

struct PlaceholderTextField: View {
    @State private var text: String = ""
    
    var placeholder: String
    var placeholderColor: Color = .white // Customize placeholder color
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder + "\nFind an customer, event, or gen").font(.system(size: 10))
                    .foregroundColor(placeholderColor)
            }
            VStack{
                TextField("", text: $text)
            }
            
                
        }
    }
}


struct HomeCell: View {
    var gk = GateKeeper()
    var imageURL:String
    @State var width = 300.0
    @State var height = 220.0
    var body: some View{
        
        ZStack{
            VStack{
                AsyncImage(url: URL(string: imageURL)) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder while loading
                                ProgressView()
                                    .frame(width: 100, height: 100)
                                
                            case .success(let image):
                                // Display the loaded image
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: height)
                                    .cornerRadius(10)
                                
                            case .failure:
                                // Error placeholder
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                                
                            @unknown default:
                                // Handle unexpected cases
                                EmptyView()
                            }
                        }

            }
        }
        
    }
                         }

struct HomeView: View {
    @State var contentItems:[HomeContentItem] = [HomeContentItem(),HomeContentItem(),HomeContentItem(),HomeContentItem()]
    // State variable to track the selected segment index
        @State private var selectedSegment = 0
    @State var searchString = ""
    let gk = GateKeeper()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    HStack{
                        Spacer().frame(width:10)
                        Image(systemName: "magnifyingglass")
                        PlaceholderTextField(placeholder: "Search for events")
                        Image(systemName: "gear")
                        Spacer().frame(width:160)
                        Image(systemName: "gear")
                        Image(systemName: "gear")
                        Spacer()
                    }
                    .foregroundColor(.white)
                
//                        Text("Find an customer, event, or gen")
//                            .foregroundColor(.gray)
//                            .font(.system(size: 12))
//                            .padding(.leading,-160)
                        
                    
                    Spacer()
                        .frame(height:50)
                    // Segmented Picker (Segmented Control)
//                              Picker("Select View", selection: $selectedSegment) {
//                                  Text("View 1").tag(0)
//                                  Text("View 2").tag(1)
//                                  Text("View 3").tag(2)
//                              }
//                              .pickerStyle(SegmentedPickerStyle()) // Use the segmented style
                              
                              // Spacer to add some space between the segmented control and the views
                    Spacer()
                        .frame(height:50)
                              
                              // Conditionally display different views based on the selected segment
                              if selectedSegment == 0 {
                                  ForEach(contentItems,id:\.self){ item in
                                      NavigationLink(destination: HomeDetailView()) {
                                          HomeCell(imageURL: "https://images3.alphacoders.com/678/678085.jpg")
                                      }
                                  }
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
                }
            }
            .background(gk.colorSystem.vinylCTRLBlk)
            //.ignoresSafeArea()
        }
        
    }
}

struct DynamicHorizontalScrollView: View {
    @State var items:[HomeContentItem] = [HomeContentItem(),HomeContentItem(),HomeContentItem(),HomeContentItem()]
    @State var homeCell = HomeCell(imageURL: "https://images3.alphacoders.com/678/678085.jpg")
    
    var body: some View {
        NavigationView{
            
                Color.black.ignoresSafeArea()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(items, id: \.self) { item in
                            HomeCell(imageURL: "https://images3.alphacoders.com/678/678085.jpg")
                        }
                    }
                    .padding()
                    Spacer()
                }
                .frame(height: 300)
            
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
