import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            Text(String(localized: "profile.title"))
                .navigationTitle(String(localized: "profile.title"))
        }
    }
}

#Preview {
    ProfileView()
}
