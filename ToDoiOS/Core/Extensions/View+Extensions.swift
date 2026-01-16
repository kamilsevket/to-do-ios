import SwiftUI

extension View {
    func bounceEffect(_ trigger: Bool) -> some View {
        self
            .scaleEffect(trigger ? 1.2 : 1)
            .animation(.interpolatingSpring(stiffness: 300, damping: 10), value: trigger)
    }

    func shimmer(_ isActive: Bool) -> some View {
        self
            .overlay(
                GeometryReader { geo in
                    if isActive {
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.3), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: geo.size.width * 2)
                        .offset(x: -geo.size.width)
                        .animation(
                            .linear(duration: 1.5).repeatForever(autoreverses: false),
                            value: isActive
                        )
                    }
                }
                .mask(self)
            )
    }

    func confettiEffect(_ trigger: Bool) -> some View {
        self.modifier(ConfettiModifier(trigger: trigger))
    }
}

struct ConfettiModifier: ViewModifier {
    let trigger: Bool
    @State private var particles: [ConfettiParticle] = []

    func body(content: Content) -> some View {
        ZStack {
            content

            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: 8, height: 8)
                    .offset(x: particle.xPosition, y: particle.yPosition)
                    .opacity(particle.opacity)
            }
        }
        .onChange(of: trigger) { _, newValue in
            if newValue {
                generateConfetti()
            }
        }
    }

    private func generateConfetti() {
        let colors: [Color] = [.red, .blue, .green, .yellow, .purple]
        particles = (0..<30).map { _ in
            ConfettiParticle(
                xPosition: CGFloat.random(in: -100...100),
                yPosition: CGFloat.random(in: -200...0),
                color: colors.randomElement() ?? .blue,
                opacity: 1
            )
        }

        withAnimation(.easeOut(duration: 2)) {
            particles = particles.map { particle in
                var updated = particle
                updated.yPosition += 400
                updated.opacity = 0
                return updated
            }
        }
    }
}

struct ConfettiParticle: Identifiable {
    let id = UUID()
    var xPosition: CGFloat
    var yPosition: CGFloat
    var color: Color
    var opacity: Double
}
