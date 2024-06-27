# Sahara EMS

Sahara EMS is a social application designed for students to interact, post events, and organize events within their university. This app aims to foster a vibrant university community by providing a platform for students to share and participate in various events.

## Features

- **User Authentication**: Secure sign-in and sign-up using Firebase Authentication.
- **Event Posting**: Create and post events that other students can view and join.
- **Event Management**: Organize and manage events, including details such as time, location, and description.
- **Social Interaction**: Like, comment, and interact with posts and events.
- **Notifications**: Receive real-time updates and notifications about events and interactions.

## Tech Stack

- **Frontend**: Flutter
- **Backend**: Firebase
    - **Authentication**
    - **Cloud Firestore** (for database)
    - **Cloud Storage** (for media and file storage)
    - **Cloud Messaging** (for notifications)

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Firebase CLI: [Installation Guide](https://firebase.google.com/docs/cli#install_the_firebase_cli)

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/ahsan668/sahara-ems.git
   cd sahara-ems
Set Up Firebase

Go to the Firebase Console.
Create a new project.
Add an Android/iOS app to your project and follow the steps to register your app.
Download the google-services.json (for Android) or GoogleService-Info.plist (for iOS) and place it in the appropriate directory:
android/app/ (for google-services.json)
ios/Runner/ (for GoogleService-Info.plist)
Enable Firebase Authentication and set up sign-in methods.
Set up Firestore and Cloud Storage.
Install Dependencies

bash
Copy code
flutter pub get
Run the App

bash
Copy code
flutter run
Project Structure

bash
Copy code
sahara-ems/
├── android/
├── ios/
├── lib/
│   ├── models/
│   ├── screens/
│   ├── services/
│   ├── widgets/
│   ├── main.dart
├── assets/
├── test/
├── pubspec.yaml
models/: Data models used in the app.
screens/: Different screens and pages of the app.
services/: Firebase and other backend services.
widgets/: Reusable UI components.
main.dart: Entry point of the application.
Contributing

Contributions are welcome! Please follow these steps:

Fork the repository.
Create a new branch (git checkout -b feature/your-feature).
Commit your changes (git commit -am 'Add some feature').
Push to the branch (git push origin feature/your-feature).
Create a new Pull Request.
License

This project is licensed under the MIT License - see the LICENSE file for details.

Contact

If you have any questions or feedback, feel free to contact:

Email: Ahxan668@gmail.com
GitHub: ahsan668 #sahara_ems
