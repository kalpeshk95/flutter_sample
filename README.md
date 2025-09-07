# 📱 Flutter Sample

<div align="center">
  
[![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue?style=flat-square&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.3.0-blue?style=flat-square&logo=dart)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

</div>

A beautifully structured Flutter application that simulates an investment portfolio management interface. Built using the **latest Flutter practices** and **clean architecture**, this project uses **dummy data** to showcase powerful features and optimized UI patterns.

> 🔧 **Note:** All data shown in this application is **simulated/dummy data** for demonstration purposes only. No real financial data or transactions are involved.
> 
> Developed with scalability and maintainability in mind — perfect for learning, showcasing, or expanding further!

---

## ✨ Features

### 📊 Portfolio Management
- ✅ Real-time summary of Current Value, Investment & Profit/Loss (using simulated data)
- 📱 Responsive design that works on mobile and tablet
- 💾 All data is locally generated and simulated for demonstration

### 🔍 Search & Filter
- 🔍 Instant search across all holdings
- 🎚️ Advanced filtering options
- 🔄 Pull-to-refresh to update holdings

### 🛠️ Technical Highlights
- 🏗️ Modular MVVM architecture using `Provider`
- 🚀 Optimized performance with minimized widget rebuilds
- 🌓 Built-in support for both light and dark themes
- 🌐 Clean API layer with Dio for network calls
- 🔒 Secure storage for sensitive data

---

## 🌓 Screenshots

### Light Theme

| Feature | Screenshot |
|---------|------------|
| **Portfolio** | ![Light Portfolio](screenshots/portfolio.png) |
| **Stock Details** | ![Light Stock Details](screenshots/stock_details.png) |
| **Watchlist** | ![Light Watchlist](screenshots/watchlist.png) |
| **Sorting Options** | ![Light Sorting](screenshots/sorting.png) |

### Dark Theme

| Feature | Screenshot |
|---------|------------|
| **Portfolio** | ![Dark Portfolio](screenshots/dark_portfolio.png) |
| **Stock Details** | ![Dark Stock Details](screenshots/dark_stock_details.png) |
| **Watchlist** | ![Dark Watchlist](screenshots/dark_watchlist.png) |
| **Sorting Options** | ![Dark Sorting](screenshots/dark_sorting.png) |

*Note: All data shown in screenshots is simulated for demonstration purposes. The app features a complete light/dark theme system that respects the device's theme settings.*

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.19.0)
- Dart SDK (>=3.3.0)
- Android Studio / VS Code with Flutter extensions
- Android Emulator or physical device

### 📦 Clone the Repository

```bash
git clone https://github.com/kalpeshk95/flutter_sample.git
cd flutter_sample
```

### 🧰 Install Dependencies

```bash
flutter pub get
```

### ▶️ Run the App

#### For Development
```bash
# Run in debug mode
flutter run

# Run with flavor (development/staging/production)
flutter run --flavor development

# Run with specific device
flutter run -d <device_id>
```

#### For Release
```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

---

## 🏗️ Project Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern with **Clean Architecture** principles, ensuring separation of concerns and testability.

### 📁 Directory Structure

```
lib/
├── core/                     # Core functionality
│   ├── di/                  # Dependency injection setup
│   ├── network/             # Network layer (Dio, interceptors)
│   ├── theme/               # App theming and styling
│   └── utils/               # Utility classes and extensions
│
├── data/                    # Data layer
│   ├── models/              # Data models (Freezed)
│   ├── repositories/        # Repository implementations
│   └── sources/             # Local and remote data sources
│
├── domain/                  # Business logic layer
│   ├── entities/            # Business entities
│   ├── repositories/        # Repository interfaces
│   └── usecases/            # Business use cases
│
├── presentation/            # UI Layer
│   ├── screens/             # Feature screens
│   │   └── watchlist/       # Watchlist feature
│   │       ├── widgets/     # Reusable widgets
│   │       ├── watchlist_screen.dart
│   │       └── watchlist_vm.dart
│   └── shared/              # Shared UI components
│
├── routing/                 # Navigation and routing
└── main.dart                # App entry point
```

### 🧩 Key Components

- **Models**: Data classes representing API responses and business entities
- **Repositories**: Abstract the data sources and handle data operations
- **ViewModels**: Manage UI state and business logic
- **Widgets**: Reusable UI components
- **Services**: Handle app-wide functionality (e.g., API calls, local storage)

---

## 📦 Dependencies

### Core
| Package | Version | Purpose |
|---------|---------|----------|
| `flutter` | 3.5.4 | Flutter framework |
| `dart` | ^3.5.4 | Dart SDK |

### State Management & Dependency Injection
| Package | Version | Purpose |
|---------|---------|----------|
| `provider` | ^6.1.4 | State management |
| `get_it` | ^8.0.3 | Service locator for dependency injection |

### Navigation
| Package | Version | Purpose |
|---------|---------|----------|
| `go_router` | ^14.6.2 | Declarative routing solution |

### Network & Data
| Package | Version | Purpose |
|---------|---------|----------|
| `dio` | ^5.7.0 | HTTP client |
| `json_annotation` | ^4.9.0 | JSON serialization annotations |
| `json_serializable` | ^6.8.0 | Code generation for JSON serialization |
| `freezed` | ^2.5.7 | Code generation for immutable classes |
| `freezed_annotation` | ^2.4.4 | Annotations for freezed |

### UI Components
| Package | Version | Purpose |
|---------|---------|----------|
| `shimmer_animation` | ^2.2.2 | Shimmer loading effect |
| `intl` | ^0.20.2 | Internationalization and localization |

### Utilities
| Package | Version | Purpose |
|---------|---------|----------|
| `logger` | ^2.4.0 | Simple logging utility |
| `connectivity_plus` | ^6.1.3 | Network connectivity status |

### Development Dependencies
| Package | Version | Purpose |
|---------|---------|----------|
| `build_runner` | ^2.4.13 | Code generation |
| `flutter_lints` | ^4.0.0 | Flutter lint rules |

*Note: The app uses mock data for demonstration purposes, with a clean architecture that allows for easy integration with real APIs.*

---

## 🚀 Deployment

### Android
1. Update the version in `pubspec.yaml`
2. Generate a release build:
   ```bash
   flutter build appbundle --release
   ```
3. Upload the generated bundle to Google Play Console

### iOS
1. Update the version in `pubspec.yaml` and `ios/Runner.xcodeproj`
2. Generate an archive:
   ```bash
   flutter build ipa --release
   ```
3. Distribute via TestFlight or App Store Connect

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

1. **Report bugs**: File an issue if you find any bugs
2. **Suggest features**: Open an issue to discuss new features
3. **Submit fixes**: Send a pull request to fix issues
4. **Improve documentation**: Help us improve the documentation

### Contribution Guidelines

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

Please ensure your code follows our coding standards and includes appropriate tests.

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) for the awesome framework
- [Dart](https://dart.dev/) for the powerful language
- All the open-source packages that made this project possible

## 📚 Additional Resources

If you're new to Flutter, here are some resources to help you get started:

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

## 📬 Contact

For any questions or feedback, please open an issue or contact us at [kulyekalpesh@gmail.com](mailto:kulyekalpesh@gmail.com).

---

<div align="center">
  Made with ❤️ using Flutter
</div>

- [🚀 Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [🍳 Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [📘 Flutter Documentation](https://docs.flutter.dev/): Full API reference and guides

