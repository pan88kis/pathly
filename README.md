# Pathly 🖊️

**Pathly** is a mobile app that lets you record finger traces on your screen and replay them in real time as an animated guide — like a GPS for drawing figures.

---

## What it does

Pathly has two core modes :

### 🔴 Record mode
- Activate recording
- A **3-second countdown** gives you time to get ready
- The app captures every point your finger traces on the screen
- The trace is saved locally on your device

### ▶️ Replay mode
- Choose a saved trace
- The path animates in **real time** on screen, stroke by stroke
- Follow the guide with your finger simultaneously
- Perfect for practicing figures, shapes, letters, or any custom path

---

## Use case — figure game

> You see a figure to reproduce. You watch the correct trace play back live. You follow it with your finger. You get better with every attempt.

---

## Tech stack

| Layer | Tool |
|---|---|
| Framework | [Flutter](https://flutter.dev/) |
| Language | Dart |
| Drawing | `CustomPaint` + `GestureDetector` |
| Local storage | `Hive` or `sqflite` |
| Overlay (Android) | `flutter_overlay_window` |
| IDE | VS Code + Flutter extension |
| Version control | Git + GitHub |
| AI assistant | Claude (Anthropic) |

---

## Platform support

| Platform | Status |
|---|---|
| Android | ✅ Full support (including overlay) |
| iOS | ✅ Support (in-app replay mode) |

> **Note :** iOS does not allow overlays on top of other apps due to Apple's sandbox restrictions. The replay guide runs inside the Pathly app itself on iOS.

---

## Project structure

```
pathly/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── record_screen.dart
│   │   └── replay_screen.dart
│   ├── models/
│   │   └── trace_model.dart
│   └── widgets/
│       └── drawing_canvas.dart
├── android/
├── ios/
├── pubspec.yaml
└── README.md
```

---

## Getting started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- VS Code with the Flutter & Dart extensions
- A physical device (recommended for touch testing) or an emulator

### Run the app
```bash
git clone https://github.com/YOUR_USERNAME/pathly.git
cd pathly
flutter pub get
flutter run
```

---

## Roadmap

- [x] Project setup
- [ ] Record screen with 3s countdown
- [ ] Finger trace capture and storage
- [ ] Replay animation engine
- [ ] Android overlay support
- [ ] Figure library (shapes, letters, patterns)
- [ ] Score / accuracy system
- [ ] iOS widget for guided replay

---

## License

MIT License — feel free to use, modify and share.