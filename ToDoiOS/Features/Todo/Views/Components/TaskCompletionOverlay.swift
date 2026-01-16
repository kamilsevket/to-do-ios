import SwiftUI

struct TaskCompletionOverlay: View {
    let points: Int
    @Binding var isShowing: Bool

    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0

    var body: some View {
        if isShowing {
            VStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.green)

                Text("+\(points) pts")
                    .font(.title2.bold())
                    .foregroundColor(.green)
            }
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    scale = 1
                    opacity = 1
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        opacity = 0
                        scale = 1.2
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isShowing = false
                        scale = 0.5
                    }
                }
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isShowing = true

        var body: some View {
            TaskCompletionOverlay(points: 10, isShowing: $isShowing)
        }
    }

    return PreviewWrapper()
}
