//
//  GateKeeper.swift
//  Lightek
//
//  Created by Marlon on 11/26/24.
//

import Foundation
import SwiftUI
import UIKit
import UserNotifications

struct ColorSystem{
    let vinylCTRLYellow = Color("VinylCTRLYellow")
    let vinylCTRLPurp = Color("VinylCTRLPurp")
    let vinylCTRLBlk = Color("VinylCTRLBlk")
    let vinylCTRLDarkColor = Color(hex: "131313")
    let vinlCTRLHintColor = Color(hex: "94a3b8")
    let vinlCTRLDarkColorStroke = Color(hex: "525b68")
}

class GateKeeper: NSObject, ObservableObject, UIApplicationDelegate {
//    let vinylCTRLYellow = Color("VinylCTRLYellow")
//    let vinylCTRLPurp = Color("VinylCTRLPurp")
//    let vinylCTRLBlk = Color("VinylCTRLBlk")
//    let vinylCTRLDarkColor = Color(hex: "131313")
//    let vinlCTRLHintColor = Color(hex: "94a3b8")
//    let vinlCTRLDarkColorStroke = Color(hex: "525b68")
    let colorSystem = ColorSystem()
    @Published var items:[AnyHashable] = []
    @Published var isLoggedIn: Bool
    @Published var group:Groups = .client
    @Published var hubs = Hubs()
    @Published var currentUser:User = User(id: 2, email: "", created_at: "", updated_at: "", role: "", user_profile: UserProfile(id: 2, user_id: 2, created_at: "", updated_at: "")) //UserDefaults.standard.object(forKey: "currentUser") as? Int ?? 2
    @Published var selectedPaymentMethod: PaymentMethod? = nil
    @Published var timerStatus = true
    @Published var timeRemaining = 60
    let defaultTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let showSplashScreenTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @Published var video_manger = VideoManager()
    let isDebuggin = true
    @Published var profileImage = Image(systemName: "house")
    let networkManager = // Start monitoring network reachability
    NetworkManager.shared

        override init() {
            // Initialize isLoggedIn based on UserDefaults, defaulting to false
            self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
            self.networkManager.startMonitoring()
            
            super.init()

            // Ensure that a default value is set in UserDefaults if not already set
            if UserDefaults.standard.object(forKey: "isLoggedIn") == nil {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
            }
        }
    
    //MARK: - functions
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }
    
    private func fetchData<T: HashableCodable>(url: URL, myObjectForCollection: T.Type) async -> [T] {
        do {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = ["Accept": "application/json"] // Example header
            request.httpMethod = "GET"

            // Perform the request and wait for the response
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode the data into an array of the specified type
            guard let decodedObjects = try? JSONDecoder().decode([T].self, from: data)else{return []}
            
            return decodedObjects
        } catch {
            print("Error fetching or decoding data: \(error)")
            return []
        }
    }
    
//    func loadThatJson<T: HashableCodable>(myCodeableObject:T.Type,id:Int? = nil, block:( @escaping ([T]) ->())){
//        Task.detached { [self] in
//            // Background work
//            print("Background thread: \(!Thread.isMainThread)")
//
//            // Determine URL based on the type of T
//                    let urlString: String
//                    switch T.self {
//                    case is User.Type:
//                        if let id = id {
//                            urlString = "\(isDebuggin ? Networking.debuggingBaseUrl:Networking.baseUrl)/\(Routes.user_profile)/\(id)"
//                                    } else {
//                                        urlString = "\(Networking.baseUrl)/\(Routes.users)"
//                                    }
//                    case is UserProfile.Type:
//                        urlString = "\(isDebuggin ? Networking.debuggingBaseUrl:Networking.baseUrl)/\(Routes.user_profile)/2"
//                    default:
//                        urlString = "\(isDebuggin ? Networking.debuggingBaseUrl:Networking.baseUrl)/default_route"
//                    }
//
//                    // Fetch data
//                    guard let url = URL(string: urlString) else {
//                        print("Invalid URL")
//                        return
//                    }
//
//            let tempDataSource:[T] = await fetchData(url: url, myObjectForCollection: T.self)
//
//            await MainActor.run {
//                            // Switch to main thread
//                            print("Switched to main thread: \(Thread.isMainThread)")
//                block(tempDataSource)
//                        }
//        }
//    }
    
    func loadThatJson<T: HashableCodable>(myCodableObject: T, id: Int? = nil, block: @escaping ([T]) -> ()) {
        Task.detached { [self] in
            // Background work
            print("Background thread: \(!Thread.isMainThread)")

            // Determine URL based on the type of T
            let urlString: String
            switch T.self {
            case is User.Type:
                if let id = id {
                    urlString = "\(isDebuggin ? Networking.debuggingBaseUrl : Networking.baseUrl)/\(Routes.user_profile)/\(id)"
                } else {
                    urlString = "\(Networking.baseUrl)/\(Routes.users)"
                }
            case is UserProfile.Type:
                urlString = "\(isDebuggin ? Networking.debuggingBaseUrl : Networking.baseUrl)/\(Routes.user_profile)/2"
            default:
                urlString = "\(isDebuggin ? Networking.debuggingBaseUrl : Networking.baseUrl)/default_route"
            }

            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            // Prepare POST data
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONEncoder().encode(myCodableObject)
            } catch {
                print("Failed to encode object: \(error)")
                return
            }

            // Fetch data
            let tempDataSource: [T] = await fetchData(url: url, myObjectForCollection: T.self) //fetchData(urlRequest: request, myObjectForCollection: T.self)

            await MainActor.run {
                // Switch to main thread
                print("Switched to main thread: \(Thread.isMainThread)")
                block(tempDataSource)
            }
        }
    }

    
    func postThatJson(parms:[String:Any]){
        
        if (parms["image"] != nil){
         
        }
        
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
    
     func postThatJSON<T: HashableCodable>(url: URL, body: T, image: UIImage? = nil) async -> Bool {
        do {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = ["Accept": "application/json"]
            request.httpMethod = "POST"

            let boundary = UUID().uuidString
            var bodyData = Data()

            if let image = image {
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

                // Append image data
                bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
                bodyData.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                bodyData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                bodyData.append(image.jpegData(compressionQuality: 0.8)!)
                bodyData.append("\r\n".data(using: .utf8)!)
            }

            // Append JSON body data
            if let jsonData = try? JSONEncoder().encode(body) {
                if image != nil {
                    bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
                    bodyData.append("Content-Disposition: form-data; name=\"json\"\r\n".data(using: .utf8)!)
                    bodyData.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
                    bodyData.append(jsonData)
                    bodyData.append("\r\n".data(using: .utf8)!)
                } else {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    bodyData = jsonData
                }
            }

            if image != nil {
                bodyData.append("--\(boundary)--\r\n".data(using: .utf8)!)
            }

            request.httpBody = bodyData

            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Server error")
                return false
            }

            return true
        } catch {
            print("Error in POST request: \(error)")
            return false
        }
    }


    func handleAppStateChange(_ newPhase: ScenePhase) {
        switch newPhase {
        case .active:
            print("App is active")
            // Perform actions when the app becomes active (e.g., resume tasks, refresh data).
            self.networkManager.startMonitoring()
            print("request permissions for location notifications")
            requestNotificationPermissions()
        case .inactive:
            print("App is inactive")
            // Perform actions when the app becomes inactive (e.g., pause tasks, save data).
        case .background:
            print("App is in the background")
            self.networkManager.stopMonitoring()
            // Perform actions when the app moves to the background (e.g., save state, release resources).
        @unknown default:
            print("Unexpected new phase")
        }
    }
    
    func timerIsActive()-> Bool{
        return timerStatus
    }
    
    func invalidateTimer(showTimer:Bool)-> Bool{
        var timerShowStatus = showTimer
        timerShowStatus.toggle()
        print(":::..Changed the show status for screen..:::")
    showSplashScreenTimer.upstream.connect().cancel()
        print(":::..Canceled timer..:::")
        return timerShowStatus
        
    }

    
}
