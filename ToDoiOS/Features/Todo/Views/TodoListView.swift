import SwiftUI

struct TodoListView: View {
    var body: some View {
        NavigationStack {
            Text("Todo List")
                .navigationTitle("Tasks")
        }
    }
}

#Preview {
    TodoListView()
}
