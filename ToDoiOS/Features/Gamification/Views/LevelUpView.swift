import SwiftUI

struct LevelUpView: View {
    let level: Int
    let onDismiss: () -> Void

    @State private var animate = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "star.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.yellow)
                    .scaleEffect(animate ? 1.2 : 1)
                    .animation(.easeInOut(duration: 0.5).repeatForever(), value: animate)

                Text(String(localized: "levelup.title"))
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                Text("\(String(localized: "stats.level")) \(level)")
                    .font(.title)
                    .foregroundColor(.yellow)

                Button(String(localized: "levelup.continue")) {
                    onDismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
                .foregroundColor(.black)
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(.systemBackground))
            )
        }
        .onAppear { animate = true }
    }
}

#Preview {
    LevelUpView(level: 5) { }
}
