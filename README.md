# Bowling Assistant App

## 1. Project Description

The Bowling Assistant App is a Flutter-based mobile application designed to help bowling enthusiasts record and analyze their bowling performance. The app allows you to record your bowling throws, and then uses computer vision model to extract useful data.
---

## 2. Integrations

The project integrates the following technologies and services:

### 2.1 Firebase

**Firebase Core**
- Initializes Firebase and connects the app to the Firebase project

**Firebase Authentication**
- Manages user authentication
- Controls access to user-specific data via an authentication gate

**Cloud Firestore**
- Stores structured application data such as users and throw data

### 2.2 Camera Plugin
- Accesses the device camera in mobile version
- Used for recording bowling attempts

---

## 3. Running the Project in Debug Mode

### 3.1 Prerequisites

Ensure the following are installed on your system:
- Flutter SDK
- Dart SDK (included with Flutter)
- Android Studio (if you want to run the mobile version)
- Android emulator (if you want to run the mobile version)

### 3.2 Setup Steps

1. Clone backend repository
2. Navigate to the backend root directory 
3. Launch backend:
   ```
   uvicorn app.main:app --reload #for web
   ```
   or
   ```
   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 #for android emulator on the same network
   ```
4. Clone the project repository
5. Navigate to the project root directory
6. Install dependencies:
   ```
   flutter pub get
   ```
7. In lib/config/api_confid.dart choose the url default value (web vs mobile)
8. Run the following command from the project root:
   ```
   flutter run
   ```

## 4. Operating the App

### 4.1 Authentication
- to log in you can create a new account
- test account, already with some data loaded:
   ```
   email: 123@gmail.com
   password: 123123
   ```
### 4.2 Main Screens

**Home Screen**
- Entry point after authentication
- All other screens are accessible from here

**Recorded Throws**
- List of recorded throws, each one can be entered to see full data

**Record Screen**
- Records bowling attempts using the camera
- After recording video is sent to backend, response is saved as ThrowData
- Only available on android

**Import Video**
- Button on the home screen that lets you analyze a video saved on your device
- Imported video is sent to backend, response is saved as ThrowData

**Stats Screen**
- Screen with aggregated data from all the throws

**Settings Screen**
- Light mode toggle

---

## 5. Firestore Schema

### 5.1 Collections Overview

```
users
throws
```

---

### 5.2 `users` Collection

Document ID: `userId`

| Field | Type | Description |
|-----|------|-------------|
| email | string | User email address |

---

### 5.3 `throws` Collection

Document ID: `throwID`

| Field | Type | Description |
|-----|------|-------------|
| userId | string | Reference to the owning user |
| createdAt | datetime | Session creation time |
| other data | map | other throw data like speed and angle, etc. |

---


