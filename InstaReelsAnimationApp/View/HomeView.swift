//
//  HomeView.swift
//  InstaReelsAnimationApp
//
//  Created by HASAN BERAT GURBUZ on 10.11.2024.
//

import SwiftUI

struct HomeView: View {

    // MARK: - PROPERTIES

    @State private var likeCount: [LikeModel] = []
    @State private var reelsData: [ReelModel] = [
        .init(videoID: "sampleVideo0", authorName: "Full fill the beers"),
        .init(videoID: "sampleVideo1", authorName: "Processing continues"),
        .init(videoID: "sampleVideo2", authorName: "Processing is complete"),
        .init(videoID: "sampleVideo3", authorName: "Test Process"),
        .init(videoID: "sampleVideo4", authorName: "Packaging")
    ]
    var size: CGSize
    var safeArea: EdgeInsets

    // MARK: - BODY

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach($reelsData) { $reel in
                    ReelsView(
                        reel: $reel,
                        likeCount: $likeCount,
                        size: size,
                        safeArea: safeArea
                    )
                    .frame(maxWidth: .infinity)
                    .containerRelativeFrame(.vertical)
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .background(.black)
        .environment(\.colorScheme, .dark)

        // MARK: - LIKE ANIMATION

        .overlay(alignment: .center, content: {
            ZStack {
                ForEach(likeCount) { like in
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 75))
                        .foregroundStyle(.red.gradient)
                        .frame(width: 100, height: 100)
                        .animation(.smooth, body: { view in
                            view
                                .scaleEffect(like.isAnimated ? 1 : 1.8)
                                .rotationEffect(.init(degrees: like.isAnimated ? 0 : .random(in: -30...30)))
                        })
                        .offset(x: like.tappedRect.x - 50, y: like.tappedRect.y - 50)
                        .offset(y: like.isAnimated ? -(like.tappedRect.y + safeArea.top) : 0)
                }
            }
        })

        // MARK: - TOP BAR VIEW

        .overlay(alignment: .top, content: {
            Text("Reels")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button("", systemImage: "camera") {}
                    .font(.title2)
                }
                .foregroundStyle(.white)
                .padding(.top, safeArea.top + 15)
                .padding(.horizontal, 15)
        })
    }
}

// MARK: - PREVIEW

#Preview {
    ContentView()
}
