//
//  NGTV.swift
//  Lightek
//
//  Created by Marlon on 12/18/24.
//

import SwiftUI
import AVKit

struct NGTV: View {
    @EnvironmentObject var gk:GateKeeper
    let url = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4" //URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4")
    var body: some View {
        gk.video_manger.videoPlayer(url: url,vr:gk.video_manger.isVr).frame(width: 300, height: 300).onAppear {
            gk.video_manger.isVr = false
        }
        
//        VideoPlayer(player: AVPlayer(url: url ?? URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4")!))
//            .frame(width:300,height: 300).overlay(
//                //Here is where can make the video and controls overlay
//                //Swap players run my own commercials a shit ton on things
//                Rectangle().frame(width: 300, height: 300).foregroundColor(.red).opacity(0.5))
    }
}

struct NGTV_Previews: PreviewProvider {
    static var previews: some View {
        NGTV().environmentObject(GateKeeper())
    }
}
