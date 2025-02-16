//
//  LikeModel.swift
//  InstaReelsAnimationApp
//
//  Created by HASAN BERAT GURBUZ on 10.11.2024.
//

import SwiftUI

struct LikeModel: Identifiable {
    var id: UUID = UUID()
    var tappedRect: CGPoint = .zero
    var isAnimated: Bool = false
}
