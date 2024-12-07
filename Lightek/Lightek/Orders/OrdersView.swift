//
//  OrdersView.swift
//  Lightek
//
//  Created by Marlon on 11/26/24.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var gk:GateKeeper
    var body: some View {
        ZStack{
            gk.vinylCTRLDarkColor.ignoresSafeArea()
            ScrollView{
                VStack{
                    Text("This view will hold all the orders of a user")
                }
            }
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
