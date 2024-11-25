//
//  UserProfileView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI

struct UserProfileView: View {
    @State var contentItems:[HomeContentItem] = [HomeContentItem(),HomeContentItem(),HomeContentItem(),HomeContentItem()]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    ForEach(contentItems,id:\.self){ item in
                        NavigationLink(destination: Text("This is will be the detail view it goes to")) { Text("Profile items here").foregroundColor(.blue) }
                    }
                    //make a grid of produced items here:
                }
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
