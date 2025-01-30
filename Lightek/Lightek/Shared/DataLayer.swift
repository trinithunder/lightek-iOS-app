//
//  DataLayer.swift
//  Lightek
//
//  Created by Marlon on 12/2/24.
//

import Foundation
import SwiftUI
import UIKit
import SceneKit
import AVKit
import Combine
import Security
import AVFoundation
import Network

protocol CodableHashable: Codable, Hashable {}
typealias HashableCodable = CodableHashable

enum A{case competitive, perfectionistic,highlymotivated }
enum B {case relaxed, flexible, lessambitious}
enum C {case conscientious /*but has difficulty expressing emotions*/}
enum D {case pessimistic, anxious, pronetoisolation}
enum PsychoanalyticPersonalities{
    case psychopathic // (Antisocial)
    case narcissistic
    case schizoid
    case paranoid
    case depressive // and Manic *I may make manic it's own thing later or maybe not who knows, I'm high so we will see that's where there's comments here to help.
    case masochistic // (Self-Defeating)
    case obsessive // and Compulsive
    case hysterical // (Histrionic)
    case dissociative
}
enum Groups {
    case client
    case artist
}
enum PaymentMethod: String, CaseIterable {
    case applePay = "Apple Pay"
    case creditCard = "Credit Card"
}
//MARK: Nevaeh's stream of concience
enum StreamingMode:CodableHashable {
    case standard
    case vr
}
enum ControllerButton:CodableHashable {
    case playPause
    case forward
    case backward
}
enum GestureType:CodableHashable {
    case pinch
    case swipeLeft
    case swipeRight
}
// Enum to represent interactions
enum VRInteractionType:CodableHashable {
    case none
    case handTracking
    case controller
}
//Activity type
enum ActivityType:CodableHashable{
    case episode
    case video
    case series
    
}
enum Networks{
    case name
}
enum ViewingMode{
    
}

struct Root:CodableHashable{
    var user:[User]
}

struct User:CodableHashable{
    var id:Int
    var email: String
    var created_at: String
    var updated_at: String
    var role:String
    var user_profile: UserProfile
    
    //Since you're already using Devise for authentication, we can build a simple token-based authentication system without adding unnecessary libraries. Here’s how we'll do it:
    //
    //Generate a Token on Login → When a user logs in via the Devise sign-in endpoint, issue a unique token and store it in the database.
    //Authenticate Requests → Require the token in request headers for authentication.
    //Allow Token Revocation → Users can log out and invalidate their token.
    //    On login, store the token securely in Keychain.
        func login(email: String, password: String) {
            guard let url = URL(string: "https://your-backend.com/users/sign_in") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: Any] = ["email": email, "password": password]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else { return }

                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: String],
                   let token = json["token"] {
                    KeychainHelper.shared.save(token, forKey: "authToken")  // Store token securely
                }
            }.resume()
        }
    
    func signup(email: String, password: String,block:@escaping (Bool)->()) {
        guard let url = URL(string: "https://your-backend.com/users/sign_in") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return block(false) }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: String],
               let token = json["token"] {
                KeychainHelper.shared.save(token, forKey: "authToken")  // Store token securely
                block(true)
            }
        }.resume()
    }
}
struct LoginTextContent{
    var welcomeText = Text("Welcome back 👋")
    var signInText = Text("Sign into your account")
    var phoneNumberText = Text("Enter phone number")
    var wrongNumberText = Text("Oops! Incorrect Phone Number try another one.")
    var tosText = Text("By using VinylCTRL, you agree to the/n  Terms of Conditions and Privacy Policy.")
    var loginText = Text("Login")
    var noAccountText = Text("Don’t have an account? ")
    var registerText = Text("Register")
}
struct UserProfile:CodableHashable{
    var id:Int
    var first_name:String?
    var last_name:String?
    var bio:String?
    var twitter:String?
    var instagram:String?
    var blue_sky:String?
    var tiktok:String?
    var phone_number:String?
    var user_id:Int
    var created_at:String
    var updated_at:String
    var youtube:String?
    var soundcloud:String?
    var  willing_to_travel:Bool?
    var experience:String?
    var location:String?
    var favorites:[Favorites]?
}
struct ProfileSettingItem:CodableHashable{
    var title:String
    var iconImage:String
}
struct PersonalityType{
    var psychoanalytic:PsychoanalyticPersonalities?
    var typeA:A?
    var typeB:B?
    var typeC:C?
    var typeD:D?
}
struct Requirement:CodableHashable{
    var event_name:String
    var event_type:String
    var event_date_time:String
    var duration:String
    var location:String
    var genre:String
    var special_song:String
    var additional_services:String
    
}
struct Service:CodableHashable{
    var service_name:String
    var service_type:String
    var service_description:String
    var phone_number:String
    var email:String
    var budget:String
    var availibility:String
    var additional_services:String
    
}
struct Networking {
    static var baseUrl: String {
        return getConfigValue(forKey: "BaseURL") ?? "http://localhost:3000"
    }
    
    static var debuggingBaseUrl: String {
        return getConfigValue(forKey: "DebuggingBaseURL") ?? "http://localhost:3000"
    }
    
    private static func getConfigValue(forKey key: String) -> String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path),
              let config = try? PropertyListDecoder().decode([String: String].self, from: xml) else {
                  return nil
              }
        return config[key]
    }
}
struct Routes{
    static let user_profile = "user_profile"
    static let users = "users"
}
struct Hubs {
    
    func onboarding()-> some View{
        return tshangShung()
    }
    
    func signIn()-> some View{
        return tshangShung()
    }
    
    func signUp()-> some View{
        return tshangShung()
    }
    
    func home()-> some View{
        return tshangShung()
    }
    
    func profile()-> some View{
        return tshangShung()
    }
    
    func transactions()-> some View{
        return tshangShung()
    }
    
    func services()-> some View{
        return tshangShung()
    }
    
    func subscription()-> some View{
        return tshangShung()
    }
    
    func chat()-> some View{
        return tshangShung()
    }
    
    func artistBooking()-> some View{
        return tshangShung()
    }
    
    func bookingHistory()-> some View{
        return tshangShung()
    }
    
    func requirements()-> some View{
        return tshangShung()
    }
    
    private func tshangShung()->some View{
        return EmptyView()
    }
}
struct AsyncImageView: View {
    let imageURL: URL
    @State var imageWidth = 100.0
    @State var imageHeight = 100.0
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                // Placeholder view while the image is loading
                ProgressView()
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            case .success(let image):
                // Successfully loaded image
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth, height: imageHeight)
                    .cornerRadius(10)
            case .failure:
                // Placeholder for failed image load
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            @unknown default:
                EmptyView()
            }
        }
    }
}
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}
//MARK: Nevaeh's video manager
struct VideoManager {
    var streamingMode:StreamingMode?
    var controllerButton:ControllerButton?
    var gestureType:GestureType?
    var vr_interactionType:VRInteractionType?
    var activityType:ActivityType?
    var episode:Episode?
    var series:Series?
    var season:Season?
    var faves:[Favorites]?
    var contentRating:ContentRating?
    var seriesImage:SeriesImage?
    var headlineConfig:HeadlineConfig?
    var binge:[Episode]?
    var video_stream_view:VideoStreamingView = VideoStreamingView()
    @State var isVr = false
    
    func videoPlayer(url:String,vr:Bool = false)-> some View{
        video_stream_view.videoURL = URL(string: url)
        return vr ? AnyView(VRVideoPlayer(url: URL(string: url))): AnyView(StandardVideoPlayer(url: URL(string: url)))
    }
}
struct VideoStreamingView: View {
    @State  var streamingMode: StreamingMode = .standard
    @State var videoURL: URL?
    
    var body: some View {
        VStack {
            if streamingMode == .standard {
                StandardVideoPlayer(url: videoURL)
            } else {
                VRVideoPlayer(url: videoURL)
            }
            
            Picker("Mode", selection: $streamingMode) {
                Text("Standard").tag(StreamingMode.standard)
                Text("VR").tag(StreamingMode.vr)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}
struct StandardVideoPlayer: View {
    let url: URL?
    @State var isBranded = false
    @State var network = Networks.name
    @State var isDisplayShowing:Bool = false
    @State var player = AVPlayer(url: URL(string: "") ?? URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4")!)
    
    var body: some View {
        //        let player = AVPlayer(url: url ?? URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4")!)
        if let url = url {
            switch isBranded {
            case true:
                //Branded version of the player:
                // Preload or buffer content for better performance
                //                        preloadVideo(url: url)
                
                brandedPlayer(brandUrl: url)
            default:
                //Default player:
                VRVideoPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4"))
                //standardPlayer(playerUrl: url)
                //Here is where can make the video and controls overlay
                //                                //Swap players run my own commercials a shit ton on things
            }
        } else {
            Text("No video selected")
        }
    }
    
    func preloadVideo(url: URL) {
        let player = AVPlayer(url: url)
        player.automaticallyWaitsToMinimizeStalling = true
    }
    
    func standardPlayer(playerUrl:URL?)-> some View{
        //        let std_player = AVPlayer(url: url ?? URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4")!)
        //https://www.youtube.com/watch?v=FhpSo3URr50
        let std_player = AVPlayer(url: playerUrl ?? URL(string: "https://www.youtube.com/watch?v=FhpSo3URr50")!)
        return VideoPlayer(player: std_player )
            .onAppear(perform: {
                std_player.play()
            })
            .frame(width:300,height: 300).overlay(
                //Here is where can make the video and controls overlay
                //Swap players run my own commercials a shit ton on things
                Rectangle().frame(width: 300, height: 300).foregroundColor(.orange).opacity(0.5))
    }
    
    func brandedPlayer(brandUrl:URL?)-> some View{
        return VideoPlayer(player: AVPlayer(url: brandUrl ?? URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4")!))
            .frame(width:300,height: 300).overlay(
                //Here is where can make the video and controls overlay
                //Swap players run my own commercials a shit ton on things
                Rectangle().frame(width: 300, height: 300).foregroundColor(.blue).opacity(0.5))
    }
}
struct VRVideoPlayer: View {
    let url: URL?
    @State private var player: AVPlayer?
    @State var vr_interactionView:VRInteractionView = VRInteractionView(url: URL(string: ""))
    
    var body: some View {
        if let url = url,isVRCompatible(videoURL: url) {
            SceneView(scene: createVRScene(url: url), options: [.allowsCameraControl])
        } else {
            Text("Invalid or non-VR video format")
        }
    }
    
    func createVRScene(url: URL) -> SCNScene {
        let scene = SCNScene()
        
        // Create a spherical geometry for VR projection
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 10))
        sphereNode.geometry?.firstMaterial?.isDoubleSided = true
        
        // Assign the video player as the texture for the sphere
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        sphereNode.geometry?.firstMaterial?.diffuse.contents = playerLayer
        
        scene.rootNode.addChildNode(sphereNode)
        return scene
    }
    
    func isVRCompatible(videoURL: URL) -> Bool {
        // Basic check for equirectangular video (you can expand with metadata parsing)
        return videoURL.pathExtension == "mp4" || videoURL.pathExtension == "mov"
    }
    
    func setupPlayer(for url: URL) {
        player = AVPlayer(url: url)
        player?.automaticallyWaitsToMinimizeStalling = true
        player?.currentItem?.preferredForwardBufferDuration = 5.0 // Seconds
        player?.play()
    }
}
//MARK: - Basic Gaze Control with RealityKit:
struct VRInteractionView: View {
    let url: URL?
    @State  var interactionType: VRInteractionType = .controller
    @State  var isPlaying: Bool = true
    @State var isDisplayShowing:Bool = false
    
    var body: some View {
        ZStack {
            if let url = url {
                SceneView(scene: createVRScene(url: url))
            } else {
                Text("No VR video selected")
            }
            
            switch interactionType{
            case .handTracking:
                Text("Hand Tracking Enabled").foregroundColor(.white)
            case .controller:
                Text("Controller Mode").foregroundColor(.white)
            case .none:
                Text("Default Mode").foregroundColor(.white)
            }
        }
        .onAppear {
            initializeSDK()
        }
        .onTapGesture {
            handleTap()
        }
    }
    
    func initializeSDK() {
        // Initialize Meta SDK or custom hand/controller SDK
        print("Initializing VR SDK for interaction")
        // Example: Meta SDK setup or custom input manager
    }
    
    func handleTap() {
        // Simulate play/pause toggle with interaction
        isPlaying.toggle()
        print("Toggled playback state")
    }
    
    func createVRScene(url: URL) -> SCNScene {
        let scene = SCNScene()
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 10))
        sphereNode.geometry?.firstMaterial?.isDoubleSided = true
        sphereNode.geometry?.firstMaterial?.diffuse.contents = url
        scene.rootNode.addChildNode(sphereNode)
        return scene
    }
    
    //
    //Hand Gesture or Controller Input
    //Integrate input systems based on the SDK.
    //
    //Example: Hand Gesture Tracking
    //Use Meta SDK or OpenXR for skeletal tracking data.
    //Map gestures like pinch (e.g., thumb touching index finger) to actions.
    func handleHandGesture(gesture: GestureType) {
        switch gesture {
        case .pinch:
            togglePlayPause()
        case .swipeLeft:
            seekBackward()
        case .swipeRight:
            seekForward()
            //        default:
            //            break
        }
    }
    
    func togglePlayPause() {
        isPlaying.toggle()
        print(isPlaying ? "Playing" : "Paused")
    }
    
    func seekForward() {
        isPlaying.toggle()
        print(isPlaying ? "Playing" : "Paused")
    }
    
    func seekBackward() {
        isPlaying.toggle()
        print(isPlaying ? "Playing" : "Paused")
    }
    
    //MARK: Example: Controller Input
    //Bind buttons to actions, such as play/pause or seeking through video.
    
    func handleControllerInput(button: ControllerButton) {
        switch button {
        case .playPause:
            togglePlayPause()
        case .forward:
            seekForward()
        case .backward:
            seekBackward()
            
        }
    }
}
struct Favorites:CodableHashable{
    var author:Int
    var activityType:ActivityType
    var item:Int
    
}
struct ContentRating:CodableHashable {
    var TVPG:String //"TV-14",
    var Microsoft:String // "12",
    var ESRB:String //"ESRB:T",
    var PEGI:String // "PEGI:12"
}
struct PublishDate:CodableHashable {
    var dateString:String // "2014-11-04T00:00:00-0500",
    var timestamp:String // 1415077200
}
struct SeriesImage:CodableHashable{
    var height:String // 1136,
    var resizable:Bool // true,
    var url:String // "http:\/\/4.images.spike.com\/tve\/lsb_iphone_series-pinned_031215.jpg",
    var width:String // 640,
    var aspectRatio:String // "9:16",
    var type:String // "SeriesBannerPhone"
}
struct HeadlineConfig:CodableHashable {
    var headline:String // "LIP SYNC",
    var headline2:String // "BATTLE",
    var tuneIn:String // "SPIKE SERIES",
    var tuneIn2:String // "Thursdays At 10\/9C"
}
struct ParentEntity:CodableHashable {
    var entityType:String // "series",
    var id:String // "mgid:arc:series:spike.com:a858471b-0ff9-4a7a-b98f-f152cc9f770a",
    var title:String // "Lip Sync Battle"
}
struct Series:CodableHashable {
    var id:Int //"mgid:arc:series:spike.com:a858471b-0ff9-4a7a-b98f-f152cc9f770a"
    var entityType:ActivityType // "series"
    var title:String // "Lip Sync Battle"
    var subTitle:String // "Lip Sync Battle"
    var description:String // "Lip Sync Battle is already a huge viral sensation. Now Spike is taking it to the next level with its very own show, hosted by LL Cool J and with colorful commentary by social media maven and supermodel co-host, Chrissy Teigen. Each episode will feature two A-list celebrities like you've never seen them before - synching their hearts out in hysterically epic performances. The mic is off, the battle is on!"
    var content_rating:ContentRating
    var publishDate:PublishDate
    var url:String // "http:\/\/api.spike.com\/feeds\/networkapp\/android\/series\/1.0\/mgid:arc:series:spike.com:a858471b-0ff9-4a7a-b98f-f152cc9f770a?key=spikenetworkapp1.0",
    var urlTimestamp:String // 1436889723,
    var images: [SeriesImage]
    var headlineConfig:HeadlineConfig
    var seasons:[Season]
}
struct Season:CodableHashable {
    var episodes:[Episode]
}
struct Episode:CodableHashable {
    var parentEntity:ParentEntity
    //    "id": "mgid:arc:episode:spike.com:094816ad-999e-496e-a5b8-4ead63c6b157",
    var title:String // "Salt vs. Pepa",
    var subTitle:String // "Season 1, Ep 9",
    var description:String // "Bandmates, friends and now...competitors! Hip hop legends Salt-N-Pepa go to battle for lip sync glory.",
    //    "duration": {
    //        "milliseconds": 1232000,
    //        "timecode": "1232"
    //    },
    //    "entityType": "episode",
    //    "publishDate": {
    //        "dateString": "2015-05-22T07:00:00-04:00",
    //        "timestamp": 1432292400
    //    },
    var url:String // "http:\/\/api.spike.com\/feeds\/networkapp\/android\/episode\/1.0\/mgid:arc:episode:spike.com:094816ad-999e-496e-a5b8-4ead63c6b157?key=spikenetworkapp1.0",
    //    "urlTimestamp": 1435680345,
    var authRequired:Bool // false,
    var images: [SeriesImage]
    var contentRating:ContentRating
    var distPolicy:DistroPolicy
    var hasExtras:Bool // true,
    var extrasURL:String? // "http:\/\/api.spike.com\/feeds\/networkapp\/android\/episode\/items\/1.0\/mgid:arc:episode:spike.com:094816ad-999e-496e-a5b8-4ead63c6b157?types=extra&key=spikenetworkapp1.0",
    //    "extrasURLTimestamp": 1435669678
}
struct DistroPolicy:CodableHashable {
    var authTve: Bool // false,
    var available: Bool //true,
    var startDate: String //1435636800,
    var endDate: String //1436587200,
    var canonicalURL:String // "http:\/\/www.spike.com\/full-episodes\/w2h6j1\/lip-sync-battle-salt-vs-pepa-season-1-ep-109"
}
struct AuthView:View {
    @State var pollingTimer: Timer?
    var body: some View{
        Text("I am just here until Marlon can finish my view work.").onAppear {
            startPolling()
        }
        .onDisappear {
            stopPolling()
        }
        
    }
    
    func startPolling() {
        pollingTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) {  _ in
            fetchAuthCode()
        }
    }
    
    func stopPolling() {
        pollingTimer?.invalidate()
        pollingTimer = nil
    }
    
    func fetchAuthCode() {
        let url = URL(string: "https://yourserver.com/check-auth-code")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching code: \(String(describing: error))")
                return
            }
            
            if let code = String(data: data, encoding: .utf8), !code.isEmpty {
                self.triggerLocalNotification(with: code)
            }
        }
        task.resume()
    }
    
    func triggerLocalNotification(with code: String) {
        let content = UNMutableNotificationContent()
        content.title = "Your Authentication Code"
        content.body = "Code: \(code)"
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error displaying notification: \(error)")
            }
        }
    }
}
struct ImageMetaData:CodableHashable{
    var test = ""
}
struct ImageUploaderView: View {
    @State private var selectedImage: UIImage? = nil
    @State  var isImagePickerPresented = false
    @State private var isUploading = false
    @State private var uploadSuccess = false
    @EnvironmentObject var gk:GateKeeper
    @Binding var showImageUploader:Bool
    @State private var sampleData: [String: String] = ["name": "Test", "description": "Sample Data"]
    @State var isUploadAvailiable = false

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        Text("Select an Image")
                            .foregroundColor(.gray)
                    )
            }

            Button("Choose Image") {
                isImagePickerPresented = true
            }
            .padding()
            
            Button("Testing shit"){
                uploadSuccess = true
            }
            
            Button("Save") {
                isUploading = true
                Task {
                    let url = URL(string: "\(Networking.baseUrl)/upload")!
                    let success = await gk.postThatJSON(
                        url: url,
                        body: ImageMetaData(),
                        image: selectedImage
                    )
                    uploadSuccess = success
                    isUploading = false
                }
            }
            .disabled(selectedImage == nil || isUploading)
            .padding()
            .foregroundColor(.white)
            .background(selectedImage == nil ? Color.gray : Color.blue)
            .cornerRadius(10)
            .opacity(selectedImage == nil ? 0:1)

            if isUploading {
                ProgressView("Uploading...")
            } else if uploadSuccess {
                Text("Upload Successful!")
                    .foregroundColor(.green)
                    .onAppear{
                        showImageUploader.toggle()
                    }
                
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
        .padding()
        .onAppear{
            gk.profileImage = Image(uiImage: (selectedImage ?? UIImage(systemName: "house"))!)
        }
        .onDisappear{
            gk.profileImage = Image(uiImage: (selectedImage ?? UIImage(systemName: "house"))!)
        }
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage
            }
            picker.dismiss(animated: true)
        }
    }
}
//MARK: View Template
struct Header_Template_Item:CodableHashable {
    var section_title:String?
    var is_search:Bool
    var search_title_text:String?
    var search_sub_title_text:String?
    var search_icon:String?
    var border_color:String?
    var border_width:Int?
    
    
}
struct Body_Template_Item:CodableHashable {
    var content_cell_title:String?
    var content_cell_sub_title:String?
    var content_body_item:String?
    
}
struct Footer_Template_Item:CodableHashable {
    var footer_link_action:String
    
}
struct Template_View:View {
    @State var header = Template_Header_View()
    @State var content_body = Template_Content_Body_View()
    @State var footer = Template_Footer_View()
    @State var header_items:[Header_Template_Item] = []
    @State var content_body_items:[Body_Template_Item] = []
    @State var footer_content_items:[Footer_Template_Item] = []
    @State var is_overlay_controls_active = false
    @State var is_video_player_view = false
    @State var is_submission_screen = false
    @State var is_onboarding_screen = false
    var body: some View{
        ScrollView{
            VStack(spacing:20){
                header.onAppear {
                    //Set header items
                    header.content_header_objects = header_items
                }
                content_body.onAppear {
                    //Set content body items
                    content_body.content_body_objects = content_body_items
                }
                footer.onAppear {
                    //TODO: - Add a check in for controls is active, this being in here seems like a good way to take this generic template and turn it into a video player template and more.
                    //Set the footer items
                    (is_video_player_view ? (footer.content_footer_objects = []):(footer.content_footer_objects = footer_content_items))
                }
            }
        }
    }
}

struct Template_Header_View:View {
    @State var content_header_text = "Hello world"
    @State var content_header_objects:[Header_Template_Item] = []
    var body: some View{
        VStack{
            Text(content_header_text)
            HStack(spacing:10){
                ForEach(content_header_objects,id:\.self){object in
//                   Header_Template_Item(section_title: <#T##String?#>, is_search: <#T##Bool?#>, border_color: <#T##String?#>, border_width: <#T##Int?#>)
                    Text(object.section_title ?? "")
                    if object.is_search {
                        //Style search header items
                        
                        Rectangle().frame(width: 300, height: 100).foregroundColor(.orange).overlay(
                            HStack{
                                Spacer().frame(width:10)
                                Image(systemName: object.search_icon ?? "").foregroundColor(.white)
                                Spacer()
                            }
                        )
                    }else{
                        //Non search styled header items
                    }
                }
            }
        }
    }
}

struct Template_Content_Body_View:View {
    @State var content_body_text = "Hello world"
    @State var content_body_objects:[Body_Template_Item] = []
    var body: some View{
        VStack(spacing:20){
            Text(content_body_text)
            ForEach(content_body_objects,id:\.self){object in
                
            }
        }
    }
}

struct Template_Footer_View:View {
    @State var content_footer_text = "Hello world"
    @State var content_footer_objects:[Footer_Template_Item] = []
    @State var display_controls = false
    var body: some View{
        ScrollView{
            VStack{
                Text(content_footer_text)
                HStack(spacing:10){
                    ForEach(content_footer_objects,id:\.self){object in
                        
                    }
                    //Check if the player controls are active
                    Text("Player controls will replace this view").opacity(display_controls ? 1:0)
                }
            }
        }
    }
}

//MARK: - Sync management
//MARK: How It Works:
//The ACHClientState object automatically updates when values change (@Published).
//The ACHClientView binds to ACHClientState, so any edits reflect in real-time.
//Changes are stored in UserDefaults, persisting data across app launches.

//Step 1: Define the ACHClient Struct
//This struct will store the properties and conform to Codable for easy storage in UserDefaults:
struct ACHClient: Codable {
    var apiBaseURL: String
    var apiKey: String
}



//Step 2: Create a UserDefaults Wrapper
//This wrapper handles saving and loading from UserDefaults:
class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let key = "achClient"

    func save(achClient: ACHClient) {
        if let encoded = try? JSONEncoder().encode(achClient) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func load() -> ACHClient? {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(ACHClient.self, from: savedData) {
            return decoded
        }
        return nil
    }
}

//Step 3: Make an ObservableObject for Live Updates
//This will allow SwiftUI views to auto-update when the data changes:
                                            
//class ACHClientState: ObservableObject {
//    @Published var achClient: ACHClient {
//        didSet {
//            UserDefaultsManager.shared.save(achClient: achClient)
//        }
//    }
//
//    init() {
//        self.achClient = UserDefaultsManager.shared.load() ?? ACHClient(apiBaseURL: "", apiKey: "")
//    }
//}

class ACHClientState: ObservableObject {
    @Published var apiBaseURL: String = UserDefaults.standard.string(forKey: "apiBaseURL") ?? ""
    @Published var apiKey: String = KeychainHelper.shared.load(forKey: "apiKey") ?? ""

    func save() {
        guard isValidURL(apiBaseURL) else {
            print("Invalid API Base URL")
            return
        }
        guard !apiKey.isEmpty else {
            print("API Key cannot be empty")
            return
        }

        UserDefaults.standard.set(apiBaseURL, forKey: "apiBaseURL")
        KeychainHelper.shared.save(apiKey, forKey: "apiKey")
    }

    private func isValidURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
}

//Step 4: SwiftUI View to Display and Edit ACHClient
//This SwiftUI view will update in real-time when the data changes:
//struct ACHClientView: View {
//    @StateObject private var achClientState = ACHClientState()
//
//    var body: some View {
//        VStack {
//            Text("ACH Client Configuration")
//                .font(.headline)
//
//            TextField("API Base URL", text: $achClientState.achClient.apiBaseURL)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            TextField("API Key", text: $achClientState.achClient.apiKey)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Button("Save") {
//                UserDefaultsManager.shared.save(achClient: achClientState.achClient)
//            }
//            .padding()
//        }
//        .padding()
//    }
//}

//✅ Securely stores API key in Keychain
//✅ Ensures valid input before saving
//✅ Syncs changes with Rails backend

struct ACHClientView: View {
    @StateObject private var achClientState = ACHClientState()

    var body: some View {
        VStack {
            Text("ACH Client Configuration")
                .font(.headline)

            TextField("API Base URL", text: $achClientState.apiBaseURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("API Key", text: $achClientState.apiKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Fetch from Server") {
                ACHClientAPI.shared.fetchACHClient { client in
                    if let client = client {
                        DispatchQueue.main.async {
                            achClientState.apiBaseURL = client.apiBaseURL
                            achClientState.apiKey = client.apiKey
                            achClientState.save()
                        }
                    }
                }
            }
            .padding()
            
            Button("Save & Sync") {
                achClientState.save()
                ACHClientAPI.shared.updateACHClient(apiBaseURL: achClientState.apiBaseURL, apiKey: achClientState.apiKey) { success in
                    if success {
                        print("Data successfully updated on server")
                    }
                }
            }
            .padding()
        }
        .padding()
    }
}


//Step 1: Secure Storage Using Keychain
//We'll create a KeychainHelper to securely store and retrieve the API key.
//✅ Stores API key securely instead of UserDefaults
//✅ Prevents unauthorized access to API keys

//MARK: KeychainHelper:
class KeychainHelper {
    static let shared = KeychainHelper()

    private func getKeychainQuery(forKey key: String) -> [CFString: Any] {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrService: Bundle.main.bundleIdentifier ?? "defaultService",
        ]
    }

    func save(_ value: String, forKey key: String) {
        let data = Data(value.utf8)
        var query = getKeychainQuery(forKey: key)
        query[kSecValueData] = data

        SecItemDelete(query as CFDictionary)  // Remove existing item
        SecItemAdd(query as CFDictionary, nil)  // Add new item
    }

    func load(forKey key: String) -> String? {
        var query = getKeychainQuery(forKey: key)
        query[kSecReturnData] = kCFBooleanTrue
        query[kSecMatchLimit] = kSecMatchLimitOne

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    func delete(forKey key: String) {
        let query = getKeychainQuery(forKey: key)
        SecItemDelete(query as CFDictionary)
    }
}

//Step 3: Fetch and Update from Rails Backend
//We’ll add networking methods to:
//
//Fetch ACH client data from Rails backend
//Update Rails backend with new ACH client details
//✅ Fetches ACH client data from Rails backend
//✅ Updates Rails backend when changes are made
class ACHClientAPI {
    static let shared = ACHClientAPI()

    private let baseURL = "https://your-rails-backend.com/api/ach_clients"

    func fetchACHClient(completion: @escaping (ACHClient?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Fetch Error:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            
            if let achClient = try? JSONDecoder().decode(ACHClient.self, from: data) {
                DispatchQueue.main.async {
                    completion(achClient)
                }
            }
        }.resume()
    }

    func updateACHClient(apiBaseURL: String, apiKey: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["api_base_url": apiBaseURL, "api_key": apiKey]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Update Error:", error.localizedDescription)
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    
    //MARK: Sending Authenticated Requests Include the token in headers:
//    ✅ Token stored securely in Keychain
//    ✅ All API calls include Authorization header
    
//    Final Overview
//
//    ✅ Secure Token Generation
//    ✅ Login Issues Token
//    ✅ Logout Invalidates Token
//    ✅ Authenticated API Requests
//    ✅ SwiftUI App Stores & Uses Token
//
//    🚀 Now your mobile users are securely authenticated with a simple and efficient token-based system! 🚀
    
    func fetchACHClients() {
        guard let token = KeychainHelper.shared.load(forKey: "authToken"),
              let url = URL(string: "https://your-backend.com/api/ach_clients") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
}



//MARK: Aight this where the heart of the streaming comes from, this is will be used for all streaming work not just phone service.

//1️⃣ AVAudioRecorder Setup for Recording Audio
//We'll set up the AVAudioRecorder to record audio in 1-second intervals or a desired clip length.
//
//Recording Audio Clip

class AudioRecorder: NSObject, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder?
    var audioFileURL: URL?
    var recordingSession: AVAudioSession!
    
    func setupRecorder() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            let audioFilename = getDocumentsDirectory().appendingPathComponent("audio_clip.m4a")
            audioFileURL = audioFilename
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFileURL!, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
        } catch {
            print("Failed to set up audio recorder: \(error)")
        }
    }
    
    func startRecording() {
        if let recorder = audioRecorder, !recorder.isRecording {
            recorder.record()
        }
    }
    
    func stopRecording() {
        if let recorder = audioRecorder, recorder.isRecording {
            recorder.stop()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//2️⃣ AVPlayer Setup for Playlist Streaming
//We'll use AVPlayer to stream the .m3u playlist once it’s created. You can load the playlist as an array of URLs.
//
//Streaming Playlist with AVPlayer

class AudioPlayer: ObservableObject {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var playlist: [URL] = []
    
    func setupPlayer(withPlaylist playlistURLs: [URL]) {
        self.playlist = playlistURLs
        
        // Start playing the first item in the playlist
        if let firstURL = playlist.first {
            player = AVPlayer(url: firstURL)
            playerLayer = AVPlayerLayer(player: player)
            player?.play()
        }
    }
    
    func playNextClip() {
        // Move to the next clip in the playlist
        guard let currentItemIndex = playlist.firstIndex(of: player!.currentItem!.asset as! URL) else { return }
        
        let nextIndex = currentItemIndex + 1
        if nextIndex < playlist.count {
            player?.replaceCurrentItem(with: AVPlayerItem(url: playlist[nextIndex]))
            player?.play()
        } else {
            endCall()  // End call if no more items in the playlist
        }
    }
    
    func endCall() {
        // Handle the end of the conversation, sending the "end playlist"
        print("Call ended. Sending end playlist.")
        // Perform necessary actions like sending the end playlist to the server
    }
    
    func pausePlayback() {
        player?.pause()
    }
    
    func resumePlayback() {
        player?.play()
    }
    
    func preloadMedia() {
//        Preloading and Buffering
//        To prevent interruptions during playback (especially when streaming), it's essential to preload the media and buffer enough data. You can configure AVPlayerItem to buffer some data before playback starts. This ensures smooth playback without interruptions.
//
//        We already set preferredForwardBufferDuration = 10.0, which means the player will buffer 10 seconds of media before starting playback. You can increase this duration if needed.
        
        //To ensure smooth playback, you’ll want to preload and buffer media files before starting playback. AVPlayer has built-in buffering mechanisms, but you can optimize it by setting proper buffer sizes and ensuring that you load the next media file before starting playback.
        
        //This will preload the audio file, keeping a buffer of 10 seconds to ensure smooth playback without interruption. You can tweak the preferredForwardBufferDuration to optimize for your use case.
//
//        Here’s how you handle preloading and buffering:
        
//    Note: You can increase the buffer duration based on the network speed or quality to prevent buffering issues.
        
            let url = URL(string: "https://your-server.com/audio_file.mp3")!
            let playerItem = AVPlayerItem(url: url)
            
            // Preload the media item
            playerItem.preferredForwardBufferDuration = 10.0 // 10 seconds buffer
            
            player = AVPlayer(playerItem: playerItem)
        player?.play()
            
            // Optionally, you can check buffer progress to see if you're ready to play
        player?.addObserver(self as! NSObject, forKeyPath: "status", options: .new, context: nil)
        }

        func adjustBitrateBasedOnNetwork() {
//            Adjust Bitrate
//            Here, we can adjust the streaming URL to switch between different quality streams depending on whether the device is connected to Wi-Fi or cellular. For this example, I’m using placeholder URLs for high and moderate bitrate audio files (high_quality_audio.mp3 and medium_quality_audio.mp3).
//
//            Wi-Fi Connection: Use a high-quality stream.
//            Cellular Connection: Use a lower quality stream to save bandwidth.
//            No Connection: Pause playback or handle the disconnection gracefully.
//            When the network changes, you can call adjustBitrateBasedOnNetwork() to ensure the player switches to an appropriate bitrate.
            
            let networkManager = NetworkManager.shared

            if networkManager.isReachable {
                if networkManager.isOnWiFi {
                    print("WiFi detected: Adjusting bitrate to high quality")
                    // Change to high bitrate stream
                    self.streamMedia(from: URL(string: "https://your-server.com/high_quality_audio.mp3")!)
                } else {
                    print("Cellular detected: Adjusting bitrate to moderate quality")
                    // Change to moderate bitrate stream
                    self.streamMedia(from: URL(string: "https://your-server.com/medium_quality_audio.mp3")!)
                }
            } else {
                print("No network detected: Pausing playback")
                // Pause media or handle no network connection
                self.handleNoNetworkConnection()
            }
        }

        func streamMedia(from url: URL) {
            let playerItem = AVPlayerItem(url: url)
            player?.replaceCurrentItem(with: playerItem)
            player?.play()
        }
    
    // Handle no network connection
        func handleNoNetworkConnection() {
            // Pause media playback
            player?.pause()

            // Show an alert to the user (or handle the UI in any way you prefer)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No Network", message: "You have lost network connectivity. Please check your connection.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    
}


//3️⃣ Creating and Managing the Playlist
//We'll create a function to manage the .m3u playlist, including adding new clips, creating the playlist file, and updating the file as clips are recorded.
//
//Updating the Playlist

class PlaylistManager {
    static let shared = PlaylistManager()
    
    func addClipToPlaylist(clipURL: URL, playlistURL: URL) {
        var playlistContent = try? String(contentsOf: playlistURL, encoding: .utf8)
        let newEntry = "#EXTINF:1, \(clipURL.lastPathComponent)\n\(clipURL.absoluteString)\n"
        
        if playlistContent == nil {
            playlistContent = "#EXTM3U\n"
        }
        
        playlistContent?.append(newEntry)
        
        do {
            try playlistContent?.write(to: playlistURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error writing to playlist: \(error)")
        }
    }
    
    func createPlaylist(for userId: String) -> URL {
        let playlistURL = getDocumentsDirectory().appendingPathComponent("\(userId)_playlist.m3u")
        return playlistURL
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


//The "end call" feature can be triggered when either user decides to end the conversation. You’ll append an end_playlist.m3u file to indicate the end of the conversation.
//
//End Playlist Handling
//You can just send the end playlist (end_playlist.m3u) to terminate the call on both sides:


//Example for Background Task Handling in AudioRecorder
//func startRecording() {
//    DispatchQueue.global(qos: .background).async {
//        // Background task: Recording audio
//        self.audioRecorder?.record()
//
//        DispatchQueue.main.async {
//            // Main thread: Update UI or handle UI-related tasks
//            self.updateUIAfterRecording()
//        }
//    }
//}

//This way, you offload the recording task to a background thread, and once recording starts, you switch back to the main thread to update the UI (e.g., show a recording indicator).
//
//2️⃣ sendEndCallToServer Function
//The sendEndCallToServer function will likely be part of your networking logic for terminating the call session. This function will send an "end call" signal to the server, which will broadcast that the call is over and close any active connections. This should be placed wherever you need to send the "end call" signal, typically when the user presses the "end call" button.
//
//Example of Ending the Call:

//func sendEndCallToServer() {
//    // Here, we would notify the server that the call is ending
//    let url = URL(string: "https://your-server.com/end_call")!
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    // Optionally send user data or session ID if needed
//    let body = ["call_id": "12345", "user_id": "user_1"]
//    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
//
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//        if let error = error {
//            print("Error ending call: \(error)")
//            return
//        }
//
//        // Handle the server response
//        if let data = data {
//            print("Server response: \(String(data: data, encoding: .utf8) ?? "No response")")
//        }
//    }
//
//    task.resume()
//}

//In this case, you’ll want to replace the URL with your actual backend endpoint, and modify the request body as needed (e.g., to include call/session information). This function should be called when the user ends the call, and it can also trigger the sending of the end playlist file.


//Reachability
//Since you're building a media streaming app, handling buffering and network reachability efficiently will be crucial. Here's a breakdown of what you might need:
//
//Reachability
//You can use Apple's Network framework or the older Reachability framework to check network status. The code will adjust streaming parameters (like bitrate) based on available bandwidth.
//
//Here's a simple implementation using Reachability:
//
//Reachability Class

//class NetworkManager {
//    static let shared = NetworkManager()
//
//    var reachability: Reachability?
//
//    init() {
//        reachability = try? Reachability()
//
//        // Monitor network reachability changes
//        reachability?.whenReachable = { reachability in
//            if reachability.connection == .wifi {
//                // Wifi is available
//                self.adjustBitrateForWiFi()
//            } else if reachability.connection == .cellular {
//                // Cellular network is available
//                self.adjustBitrateForCellular()
//            }
//        }
//
//        reachability?.whenUnreachable = { _ in
//            self.handleNoNetworkConnection()
//        }
//    }
//
//    func startMonitoring() {
//        do {
//            try reachability?.startNotifier()
//        } catch {
//            print("Unable to start reachability notifier")
//        }
//    }
//
//    func stopMonitoring() {
//        reachability?.stopNotifier()
//    }
//
//    private func adjustBitrateForWiFi() {
//        // Adjust bitrate to a higher value for WiFi
//        print("WiFi connected: Adjusting bitrate to high")
//        // Set bitrate to higher value (e.g., 2-5 Mbps)
//    }
//
//    private func adjustBitrateForCellular() {
//        // Adjust bitrate to a lower value for cellular
//        print("Cellular connected: Adjusting bitrate to moderate")
//        // Set bitrate to a lower value (e.g., 1-2 Mbps)
//    }
//
//    private func handleNoNetworkConnection() {
//        // Handle when there's no network connection
//        print("No network connection. Pausing playback or show error.")
//        // Pause playback or display a message to the user
//    }
//}

class NetworkManager {
    static let shared = NetworkManager()
    
    private var monitor: NWPathMonitor?
    private var queue: DispatchQueue?

    var isReachable: Bool {
        return monitor?.currentPath.status == .satisfied
    }
    
    var isOnWiFi: Bool {
        return monitor?.currentPath.isExpensive == false
    }
    
    init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitorQueue")
        monitor?.start(queue: queue!)
        
        monitor?.pathUpdateHandler = { path in
            if path.status == .satisfied {
                if path.isExpensive {
                    print("Connected to cellular network")
                    self.handleCellularConnection()
                } else {
                    print("Connected to Wi-Fi network")
                    self.handleWiFiConnection()
                }
            } else {
                print("No network connection")
                self.handleNoNetworkConnection()
            }
        }
    }
    
    func startMonitoring() {
        monitor?.start(queue: queue!)
    }
    
    func stopMonitoring() {
        monitor?.cancel()
    }
    
    private func handleWiFiConnection() {
        // Handle WiFi connection (adjust bitrate, start streaming at higher quality)
        print("WiFi connected: Adjusting bitrate to high")
        // Adjust bitrate for WiFi here
    }
    
    private func handleCellularConnection() {
        // Handle Cellular connection (adjust bitrate, start streaming at lower quality)
        print("Cellular connected: Adjusting bitrate to moderate")
        // Adjust bitrate for cellular here
    }
    
    private func handleNoNetworkConnection() {
        // Handle no network connection
        print("No network connection: Pausing streaming or showing error")
        // Pause media streaming or show an error message
    }
}


//This setup will monitor network changes (e.g., switching from WiFi to Cellular) and adjust the bitrate accordingly.



//Here’s an example of how you might preload media:

//func preloadMedia() {
//    let url = URL(string: "https://your-server.com/audio_file.mp3")!
//    let playerItem = AVPlayerItem(url: url)
//    
//    // Preload the media item
//    playerItem.preferredForwardBufferDuration = 10.0 // 10 seconds buffer
//    
//    let player = AVPlayer(playerItem: playerItem)
//    player.play()
//    
//    // Optionally, you can check buffer progress to see if you're ready to play
//    player.addObserver(self, forKeyPath: "status", options: .new, context: nil)
//}

//Dynamic Bitrate Adjustment
//Once you’ve implemented reachability, you can adjust the bit rate dynamically based on the current network speed.
//This logic adjusts the media quality based on the user's current download speed.

//For example, if you're using a media streaming server, you may want to request different qualities of the video/audio based on the network connection speed. You could use URLSession to monitor download speed and adjust the streaming URL accordingly:

//func adjustBitrateBasedOnSpeed(currentSpeed: Double) {
//    let bitrateThresholds = [1.0: "low_quality_url", 3.0: "medium_quality_url", 5.0: "high_quality_url"]
//
//    for (speed, url) in bitrateThresholds {
//        if currentSpeed <= speed {
//            self.streamMedia(from: URL(string: url)!)
//            break
//        }
//    }
//}
//
//func streamMedia(from url: URL) {
//    let playerItem = AVPlayerItem(url: url)
//    player.replaceCurrentItem(with: playerItem)
//    player.play()
//}




