//
//  ReelsView.swift
//  InstaReelsAnimationApp
//
//  Created by HASAN BERAT GURBUZ on 10.11.2024.
//

import SwiftUI
import AVKit

struct ReelsView: View {

    // MARK: - PROPERTIES

    @Binding var reel: ReelModel
    @Binding var likeCount: [LikeModel]
    @State private var player: AVPlayer?
    var size: CGSize
    var safeArea: EdgeInsets

    // MARK: - BODY

    var body: some View {
        GeometryReader {
            let rect = $0.frame(in: .scrollView(axis: .vertical))

            // MARK: - CUSTOM VIDEO PLAYER

            HVideoPlayer(player: $player)
                .preference(key: OffsetKey.self, value: rect)
                .onPreferenceChange(OffsetKey.self, perform: { value in
                    videoAction(value)
                })

            // MARK: - DETAILS VIEW

                .overlay(alignment: .bottom, content: {
                    ReelDetailsView()
                })

            // MARK: - LIKE TAP ANIMATION

                .onTapGesture(count: 2, perform: { position in
                    let id = UUID()
                    likeCount.append(LikeModel(id: id, tappedRect: position, isAnimated: false))
                    withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
                        guard let index = likeCount.firstIndex(where: { $0.id == id }) else { return }
                        likeCount[index].isAnimated = true
                    } completion: {
                        likeCount.removeAll(where: { $0.id == id })
                    }
                    reel.isLiked = true
                })

            // MARK: - CREATES PLAYER

                .onAppear {
                    guard player == nil, let bundleID = Bundle.main.path(forResource: reel.videoID, ofType: "mp4") else { return }
                    let videoURL = URL(filePath: bundleID)
                    self.player = AVPlayer(url: videoURL)
                }

            // MARK: - CLEAR PLAYER

                .onDisappear {
                    player = nil
                }
        }
    }

    // MARK: - VIDEO PLAY&PAUSE

    private func videoAction(_ rect: CGRect) {
        if -rect.minY < (rect.height * 0.5) && rect.minY < (rect.height * 0.5) {
            player?.play()
        } else {
            player?.pause()
        }

        if rect.minY >= size.height || -rect.minY >= size.height {
            player?.seek(to: .zero)
        }
    }

    // MARK: - REELDETAILSVIEW

    @ViewBuilder
    private func ReelDetailsView() -> some View {
        HStack(alignment: .bottom, spacing: 10) {

            // MARK: - DESCRIPTION

            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    Text(reel.authorName)
                        .font(.callout)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .clipped()
            }
            Spacer()

            // MARK: - BUTTONS

            VStack(spacing: 35) {
                Button("", systemImage: reel.isLiked ? "suit.heart.fill" : "suit.heart") {
                    reel.isLiked.toggle()
                }
                .symbolEffect(.bounce, value: reel.isLiked)
                .foregroundStyle(reel.isLiked ? .red : .white)

                Button("", systemImage: "message") {}
                Button("", systemImage: "paperplane") {}
                Button("", systemImage: "ellipsis") {}
            }
            .font(.title2)
            .foregroundStyle(.white)
        }
        .padding(.leading, 15)
        .padding(.trailing, 10)
        .padding(.bottom, safeArea.bottom + 10)
    }
}

// MARK: - OFFSETKEY

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// MARK: - PREVIEW

#Preview {
    ContentView()
}

