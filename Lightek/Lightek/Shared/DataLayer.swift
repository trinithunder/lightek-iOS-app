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
struct Template_View:View {
    @State var header = Template_Header_View()
    @State var content_body = Template_Content_Body_View()
    @State var footer = Template_Footer_View()
    var body: some View{
        VStack(spacing:20){
            header
            content_body
            footer
        }
    }
}

struct Template_Header_View:View {
    var body: some View{
        Text("")
    }
}

struct Template_Content_Body_View:View {
    var body: some View{
        Text("")
    }
}

struct Template_Footer_View:View {
    var body: some View{
        Text("")
    }
}




