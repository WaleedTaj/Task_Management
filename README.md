# Task Management App 📋

## Overview

The Task Management App is a simple yet powerful tool for managing daily tasks, designed using Flutter with Firebase integration. The app enables users to create, update, and delete tasks, with features like authentication, and real-time database sync using Cloud Firestore.

## Features 🌟

- **Firebase Authentication**: Sign in using email/password or Google Sign-In 🔑
- **Task CRUD Operations**: Create, read, update, and delete tasks efficiently 📝
- **Delete the Task**: Swipe left and right to delete tasks 🗑️
- **Real-Time Sync**: Tasks are stored and synced in real-time with Firestore ⏲️
- **Responsive Design**: Adapts to different screen sizes, ensuring a seamless experience across devices 📱
- **Custom Animations**: Smooth transitions and interactive animations, improving the user experience ✨

## Screenshots 📸

Here are some visual representations of the app:

<img src="https://github.com/WaleedTaj/Task_Management/blob/master/images/Screenshot_1.jpeg" width="200"/> <img src="https://github.com/WaleedTaj/Task_Management/blob/master/images/Screenshot_2.jpeg" width="200"/> <img src="https://github.com/WaleedTaj/Task_Management/blob/master/images/Screenshot_3.jpeg" width="200"/> <img src="https://github.com/WaleedTaj/Task_Management/blob/master/images/Screenshot_4.jpeg" width="200"/> <img src="https://github.com/WaleedTaj/Task_Management/blob/master/images/Screenshot_5.jpeg" width="200"/>

### Installation 🚀

Follow these steps to set up the app locally:

1. Clone this repository:
   ```bash
   git clone https://github.com/WaleedTaj/Task_Management.git
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Set up Firebase**:
- Create a Firebase project and enable Firestore and Authentication.
- Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) and add them to the respective folders.
3. **Run the App**:
   ```bash
   flutter run
   
## Usage 📱

- **Task Management**: Add, edit, and delete tasks in real-time with Firebase Cloud Firestore.
- **Delete the Task**: Swipe left and right to delete tasks.
- **Sign-In**: Authenticate using email/password or Google sign-in.

## Technology Used 💻

- **Flutter**: Framework for building the app UI and animations.
- **Dart**: Programming language for the app code.
- **Firebase**:
  - `firebase_core`: Initialize Firebase in your Flutter app.
  - `cloud_firestore`: Real-time database for task management.
  - `firebase_auth`: User authentication (email/password and Google sign-in).
- **Icons Plus**: Provides additional icons for the app.
- **Msh Checkbox**: Custom checkbox widget for enhanced UI.
- **UUID**: Generates unique identifiers for tasks.
- **Animation Widgets**: Utilizes widgets like `AnimatedList`, `FadeTransition`, `SlideTransition`, and `ScaleTransition` for animations.
- **PageRouteBuilder & Hero**: Implements smooth screen transitions and shared element animations.

## Customization ✨

You can further customize the app by:

- Adding new categories for tasks.
- Implementing custom notifications for task reminders.
- Improving UI/UX by tweaking animations and adding themes.

## Contributing 🤝

Feel free to fork the repository and submit pull requests for improvements and bug fixes.

## Author 💡

Developed by WaleedTaj, showcasing Flutter and Firebase integration skills with an emphasis on task management and user-friendly design.
