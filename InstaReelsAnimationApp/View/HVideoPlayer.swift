//
//  HVideoPlayer.swift
//  InstaReelsAnimationApp
//
//  Created by HASAN BERAT GURBUZ on 10.11.2024.
//

import SwiftUI
import AVKit

struct HVideoPlayer: UIViewControllerRepresentable {

    // MARK: - PROPERTIES

    @Binding var player: AVPlayer?
    
    // MARK: - FUNCTIONS

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.videoGravity = .resizeAspectFill
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}
