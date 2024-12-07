//
//  LightekApp.swift
//  Lightek
//
//  Created by Marlon on 11/23/24.
//

import SwiftUI

@main
struct LightekApp: App {
    @UIApplicationDelegateAdaptor(GateKeeper.self) var gk
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            BookingDetailsPaidTotal()
                .environmentObject(gk)
        }
        .onChange(of: scenePhase) { newPhase in
            gk.handleAppStateChange(newPhase)
        }
    }
    
}

