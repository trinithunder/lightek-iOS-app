//
//  ChatView.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI

struct ChatView: View {
    @State var contentItems:[HomeContentItem] = [HomeContentItem(),HomeContentItem(),HomeContentItem(),HomeContentItem()]
    @EnvironmentObject var gk:GateKeeper
    var body: some View {
        NavigationView {
            ZStack{
                gk.colorSystem.vinylCTRLDarkColor?.ignoresSafeArea()
                ScrollView {
                    VStack(spacing:16){
                        ForEach(contentItems,id:\.self){ item in
                            NavigationLink(destination: Text("This is will be the detail view it goes to")) { Text("Testing this out").foregroundColor(.blue) }
                        }
                    }
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
