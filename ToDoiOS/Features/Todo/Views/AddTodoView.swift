import SwiftUI
import SwiftData

struct AddTodoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var description = ""
    @State private var priority: TodoItem.Priority = .medium
    @State private var dueDate = Date()
    @State private var hasDueDate = false

    var body: some View {
        NavigationStack {
            Form {
                Section(String(localized: "tasks.details")) {
                    TextField(String(localized: "tasks.title.placeholder"), text: $title)
                    TextField(String(localized: "tasks.description.placeholder"), text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section(String(localized: "priority.title")) {
                    Picker(String(localized: "priority.title"), selection: $priority) {
                        ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
                            HStack {
                                Text(priority.localizedName)
                                Text("+\(priority.points) pts")
                                    .foregroundColor(.secondary)
                            }
                            .tag(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section(String(localized: "duedate.title")) {
                    Toggle(String(localized: "duedate.set"), isOn: $hasDueDate)
                    if hasDueDate {
                        DatePicker(String(localized: "duedate.title"), selection: $dueDate, displayedComponents: .date)
                    }
                }
            }
            .navigationTitle(String(localized: "tasks.new"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(String(localized: "tasks.cancel"), action: { dismiss() })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(String(localized: "tasks.add"), action: { saveTodo() })
                        .disabled(title.isEmpty)
                }
            }
        }
    }

    private func saveTodo() {
        let todo = TodoItem(
            title: title,
            itemDescription: description,
            priority: priority,
            dueDate: hasDueDate ? dueDate : nil
        )
        modelContext.insert(todo)
        dismiss()
    }
}

#Preview {
    AddTodoView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
