import SwiftUI

struct StreakFireView: View {
    let streakCount: Int
    @State private var animate = false

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "flame.fill")
                .font(.title)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .orange, .yellow],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .scaleEffect(animate ? 1.1 : 1)
                .animation(
                    .easeInOut(duration: 0.5).repeatForever(),
                    value: animate
                )

            Text("\(streakCount)")
                .font(.title2.bold())
        }
        .onAppear { animate = true }
    }
}

#Preview {
    StreakFireView(streakCount: 7)
}
