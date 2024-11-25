//
//  HomeView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI
struct HomeContentItem:Hashable{
    
}

struct HomeCell: View {
    var body: some View{
        
        VStack{
            HStack{
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 42, height: 42, alignment: .leading)
                    .padding(.leading,20)
                    .padding(.top,25)
                Text("User Name")
                    .font(Font.system(size: 16))
                    .padding(.top,20)
                Spacer()
                Text("Budget")
                    .font(Font.system(size: 12))
                    .padding(.trailing,20)
                    .padding(.top,20)
            }
            HStack{
                Spacer().frame(width:50)
                Text("****")
                    .font(Font.system(size: 12))
                    .padding(.leading,20)
                Text("4.9")
                    .font(Font.system(size: 12))
                    .padding(.bottom,2)
                Spacer()
                Text("$80-$100")
                    .font(Font.system(size: 12))
                    .padding(.trailing,20)
            }
            Group{
                Text("1111111kjdhfksjhfkjh: kjhfksdjhfks")
                Text("1111111kjdhfksjhfkjh: kjhfksdjhfks")
                Text("1111111kjdhfksjhfkjh: kjhfksdjhfks")
                Text("1111111kjdhfksjhfkjh: kjhfksdjhfks")
                Text("1111111kjdhfksjhfkjh: kjhfksdjhfks")
                    .lineSpacing(4.0)
                Spacer()
            }
            .font(Font.system(size: 12))
        }.frame(width: 343, height: 170)
            .background(Color.gray)
            .padding(.bottom)
    }
                         }

struct HomeView: View {
    @State var contentItems:[HomeContentItem] = [HomeContentItem(),HomeContentItem(),HomeContentItem(),HomeContentItem()]
    // State variable to track the selected segment index
        @State private var selectedSegment = 0
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    HStack{
                        Text("Home")
                            .padding(.leading,20)
                        Spacer()
                            Image(systemName: "house")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Image(systemName: "house")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing,20)
                    }
                    Spacer()
                        .frame(height:50)
                    // Segmented Picker (Segmented Control)
                              Picker("Select View", selection: $selectedSegment) {
                                  Text("View 1").tag(0)
                                  Text("View 2").tag(1)
                                  Text("View 3").tag(2)
                              }
                              .pickerStyle(SegmentedPickerStyle()) // Use the segmented style
                              
                              // Spacer to add some space between the segmented control and the views
                    Spacer()
                        .frame(height:50)
                              
                              // Conditionally display different views based on the selected segment
                              if selectedSegment == 0 {
                                  ForEach(contentItems,id:\.self){ item in
                                      NavigationLink(destination: HomeDetailView()) {
                                          HomeCell()
                                      }
                                  }
                              } else if selectedSegment == 1 {
                                  ForEach(contentItems,id:\.self){ item in
                                      NavigationLink(destination: Text("This is will be the detail view it goes to")) { HomeCell()
                                      }
                                  }
                              } else {
                                  ForEach(contentItems,id:\.self){ item in
                                      NavigationLink(destination: Text("This is will be the detail view it goes to")) { HomeCell() }
                                  }
                              }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
