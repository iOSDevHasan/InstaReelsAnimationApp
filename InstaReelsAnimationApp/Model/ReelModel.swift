//
//  ReelModel.swift
//  InstaReelsAnimationApp
//
//  Created by HASAN BERAT GURBUZ on 10.11.2024.
//

import SwiftUI

struct ReelModel: Identifiable {
    let id: UUID = UUID()
    var videoID: String
    var authorName: String
    var isLiked: Bool = false
}
