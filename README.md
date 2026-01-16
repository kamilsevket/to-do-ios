# To-Do iOS

A modern, gamified to-do app built with SwiftUI and iOS 17+ features.

## Features

- **Task Management**: Create, complete, and organize your tasks
- **Gamification**: Earn points and level up by completing tasks
- **Achievements**: Unlock badges and track your progress
- **Streaks**: Maintain daily streaks for bonus motivation
- **Localization**: English and Turkish language support (planned)

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Architecture

- **SwiftUI**: Modern declarative UI framework
- **SwiftData**: Persistent data storage
- **MVVM**: Clean architecture pattern
- **@Observable**: iOS 17+ observation framework

## Project Structure

```
ToDoiOS/
├── App/
│   ├── ToDoiOSApp.swift
│   └── ContentView.swift
├── Features/
│   ├── Todo/
│   │   ├── Models/
│   │   ├── ViewModels/
│   │   └── Views/
│   ├── Gamification/
│   │   ├── Models/
│   │   ├── ViewModels/
│   │   └── Views/
│   └── Profile/
│       ├── Models/
│       ├── ViewModels/
│       └── Views/
├── Resources/
│   └── Assets.xcassets/
└── Tests/
    └── UnitTests/
```

## Getting Started

1. Clone the repository
2. Open `ToDoiOS.xcodeproj` in Xcode 15+
3. Build and run on iOS 17+ simulator or device

## Gamification System

### Points
- Low priority tasks: 10 points
- Medium priority tasks: 25 points
- High priority tasks: 50 points

### Achievements
- **First Steps**: Complete your first task
- **Getting Started**: Complete 10 tasks
- **Task Master**: Complete 50 tasks
- **Centurion**: Complete 100 tasks
- **Week Warrior**: Maintain a 7-day streak
- **Monthly Champion**: Maintain a 30-day streak
- **Rising Star**: Reach level 5
- **Expert**: Reach level 10

## License

MIT License
