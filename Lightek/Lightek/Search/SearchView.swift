//
//  SearchView.swift
//  Lightek
//
//  Created by Marlon on 11/28/24.
//

import SwiftUI

struct SearchView: View {
    @State var searchQuery = ""
    @State var searchResults: [AnyHashable] = []
    @State var filterBy = ""
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                Capsule().foregroundColor(.yellow).frame(width: UIScreen.main.bounds.width, height: 64)
                    .overlay( TextField("", text: $searchQuery).focused($isTextFieldFocused).onChange(of: isTextFieldFocused, perform: { isTyping in
                        //Here we will provided suggested results if the textfield value is < 5 : server search results if > 5
                        isTyping ? sendSearchRequest(): print("Done")
                        
                    }))
                Spacer()
                ForEach(searchResults,id: \.self){
                    item in
                }
            }
        }
    }
    
    func sendSearchRequest(){
        Task.detached {
            // Background work
            print("Background thread: \(Thread.isMainThread)")

            await MainActor.run {
                // Switch to main thread
                print("Switched to main thread: \(Thread.isMainThread)")
            }
        }

        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
