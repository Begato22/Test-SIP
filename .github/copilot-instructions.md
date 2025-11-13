# Flutter Project AI Assistant Instructions

## Project Overview
This is a Flutter mobile application project targeting multiple platforms (iOS, Android, Windows). The project uses Material Design and follows Flutter's widget-based architecture.

## Key Files and Directories
- `lib/main.dart`: Entry point and main UI logic
- `test/widget_test.dart`: Widget testing examples
- `pubspec.yaml`: Dependencies and asset configuration
- `android/`, `ios/`, `windows/`: Platform-specific configurations

## Development Workflow

### Hot Reload Development
The project is configured for Flutter's hot reload feature:
- State changes (like `_counter` in `_MyHomePageState`) should use `setState()`
- Widget rebuilds are optimized - prefer `const` constructors where possible
- Theme changes can be tested live (see `colorScheme` in `MyApp`)

### Testing
Tests are written using `flutter_test`:
```dart
testWidgets('test name', (WidgetTester tester) async {
  await tester.pumpWidget(widget);  // Render widget
  await tester.tap(find.byType(Button));  // Interact
  await tester.pump();  // Update frame
  expect(find.text('expected'), findsOneWidget);  // Assert
});
```

### Project Configuration
- SDK: ^3.9.2 (Dart)
- Key dependencies:
  - `flutter_lints`: Code quality rules
  - `cupertino_icons`: iOS-style icons

## Patterns and Conventions
1. State Management:
   - Uses `StatefulWidget` with local state management
   - State updates trigger UI rebuilds through `setState()`

2. Widget Structure:
   - Material Design components (`Scaffold`, `AppBar`, etc.)
   - Consistent use of `const` constructors
   - Widget tree follows nested structure with clear parent-child relationships

3. Theme Configuration:
   - Centralized in `MaterialApp` widget
   - Uses `ColorScheme` for consistent theming

## Common Operations
```bash
# Run the app with hot reload
flutter run

# Run tests
flutter test

# Update dependencies
flutter pub get

# Build release version
flutter build <platform>  # ios, android, windows
```