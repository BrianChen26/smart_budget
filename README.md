# Smart Budget App

Smart Budget is a Flutter-based budgeting app that helps you manage your monthly expenses with a clean UI and real-time tracking using Firebase.

---

## Features

- Add and delete expenses
- Visual budget usage bar
- Set your own monthly budget
- Data stored and synced via Firebase
- Persistent budget settings using SharedPreferences

---
## Setup Instructions

### 1. Clone the repository
```bash
git clone https://github.com/BrianChen26/smart_budget.git
cd smart_budget
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Firebase Setup
This project uses Firebase but does not include sensitive API keys. To run the app:

Android:
Place your google-services.json file in android/app/

iOS:
Place your GoogleService-Info.plist in ios/Runner/

Dart config:
Generate firebase_options.dart via:

```bash
flutterfire configure
```

### 4. Running the App
```bash
flutter run -d chrome
```

Or on other devices (macOS, Android, etc.):
```bash
flutter run
```

## Contribution
Pull requests are welcome! Make sure to test your changes and follow clean Flutter coding practices.

## License
https://choosealicense.com/licenses/mit/