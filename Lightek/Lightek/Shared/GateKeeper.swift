//
//  GateKeeper.swift
//  Lightek
//
//  Created by Marlon on 11/26/24.
//

import Foundation
import SwiftUI
import UIKit

protocol CodableHashable: Codable, Hashable {}

typealias HashableCodable = CodableHashable

class GateKeeper: NSObject, ObservableObject, UIApplicationDelegate {
    let vinylCTRLYellow = Color("VinylCTRLYellow")
    let vinylCTRLPurp = Color("VinylCTRLPurp")
    let vinylCTRLBlk = Color("VinylCTRLBlk")
    @Published var items:[AnyHashable] = []
    @Published var isLoggedIn: Bool

        override init() {
            // Initialize isLoggedIn based on UserDefaults, defaulting to false
            self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
            
            super.init()

            // Ensure that a default value is set in UserDefaults if not already set
            if UserDefaults.standard.object(forKey: "isLoggedIn") == nil {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
            }
        }
    
    //MARK: - functions
    func loadThatJson<T: HashableCodable>(myCodeableObject:T,block:( @escaping ([AnyHashable]) ->())){
        Task.detached { [self] in
            // Background work
            print("Background thread: \(Thread.isMainThread)")
            
            let tempDataSource = await fetchData(url: URL(string: "") ?? URL(string: "")!, myObjectForCollection: T.self)
            
            await MainActor.run {
                            // Switch to main thread
                            print("Switched to main thread: \(Thread.isMainThread)")
                items = tempDataSource
                block(items)
                        }

            
        }
    }
    
    func logIn() {
            isLoggedIn = true
        }

        func logOut() {
            isLoggedIn = false
        }

        // Override method to store value to UserDefaults when the value changes
        func updateLoginStatus() {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    
    // Background fetch logic
       func application(
           _ application: UIApplication,
           performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
       ) {
           print("Background fetch triggered")

           Task {
               // Perform your background fetch logic here
               await performBackgroundFetch()
               completionHandler(.newData)
           }
       }

       private func performBackgroundFetch() async {
           // Simulate a fetch or background operation
           print("Performing background fetch...")
           // Add your custom logic here (e.g., fetch data, update state)
       }
    
    func loadDataInBackground() {
            Task.detached {
                // Simulate fetching data in the background
                let data = await self.fetchDataFromNetwork()

                // Update UI on the main thread
                await MainActor.run {
                    // Use the fetched data to update the state
                    self.isLoggedIn = true // Example of state change after fetch
                }
            }
        }

        private func fetchDataFromNetwork() async -> [String] {
            // Simulate network fetch
            try? await Task.sleep(nanoseconds: 2_000_000_000) // Simulate delay
            return ["Fetched Data"]
        }

       func checkUserStatus() {
           // Example logic to check if the user is logged in
           isLoggedIn = true // or fetch status from persistence
       }
    
    private func fetchData<T: HashableCodable>(url: URL, myObjectForCollection: T.Type) async -> [AnyHashable] {
        do {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = ["Content-Type": "application/json"] // Example header
            request.httpMethod = "GET"

            // Perform the request and wait for the response
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode the data into an array of the specified type
            let decodedObjects = try JSONDecoder().decode([T].self, from: data)
            
            return decodedObjects
        } catch {
            print("Error fetching or decoding data: \(error)")
            return []
        }
    }
    
    private func postThatJson<T: HashableCodable, U: HashableCodable>(
        url: URL,
        body: T,
        responseType: U.Type
    ) async -> Result<U, Error> {
        do {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            request.httpMethod = "POST"

            // Encode the body into JSON
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData

            // Perform the request and wait for the response
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode the response into the specified type
            let decodedResponse = try JSONDecoder().decode(U.self, from: data)

            return .success(decodedResponse)
        } catch {
            print("Error posting data or decoding response: \(error)")
            return .failure(error)
        }
    }

    func handleAppStateChange(_ newPhase: ScenePhase) {
        switch newPhase {
        case .active:
            print("App is active")
            // Perform actions when the app becomes active (e.g., resume tasks, refresh data).
        case .inactive:
            print("App is inactive")
            // Perform actions when the app becomes inactive (e.g., pause tasks, save data).
        case .background:
            print("App is in the background")
            // Perform actions when the app moves to the background (e.g., save state, release resources).
        @unknown default:
            print("Unexpected new phase")
        }
    }

    
}
