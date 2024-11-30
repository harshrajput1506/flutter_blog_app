# Flutter Blog App with Firebase (Blogography)

A Flutter application that displays a list of blog posts fetched from Firebase Cloud Firestore. Users can navigate to specific blog posts using deep links.

---

## **Features**

- Fetches blog posts dynamically from Firestore.
- Displays blog posts with:
  - Featured image.
  - Title and summary.
  - "Read More" button to view full content.
- Deep linking to navigate directly to specific blog posts.
- Responsive and visually appealing UI.
- Smooth scrolling and transitions.

---


## **Download the App**

You can download the latest APK file for the Blogography app here:

[![Download APK](https://img.shields.io/badge/Download-APK-blue?style=for-the-badge&logo=google-drive)](https://drive.google.com/file/d/1hQmEGSRzmg-lfegNL_2XgIYgUcU0R1Vx/view?usp=sharing)

---

## **Setup Instructions**

1. **Clone the Repository**
   ```bash
   git clone https://github.com/harshrajput1506/flutter_blog_app
   cd flutter-blog-app
   ```

2. **Install Dependencies**
   Ensure Flutter and Dart are installed. Run the following command to install required packages:
   ```bash
   flutter pub get
   ```

3. **Setup Firebase**
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Enable **Firestore Database**.
   - Add your app to Firebase and download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files.
   - Place `google-services.json` in the `android/app/` directory.
   - Place `GoogleService-Info.plist` in the `ios/Runner/` directory.

4. **Run the App**
   Launch the app on your preferred emulator or device:
   ```bash
   flutter run
   ```

---

## **State Management**

This project uses **Bloc** for state management to manage blog post data efficiently and provide a reactive UI.

---

## **Assumptions and Additional Features**

### **Assumptions**
1. Blog posts in Firestore include the following fields:
   - `imageURL`: URL of the featured image.
   - `title`: Title of the blog post.
   - `summary`: A short description.
   - `content`: Full content of the blog post.
   - `deeplink`: Unique deep link for the blog post.

2. Users are expected to have Firebase set up and populated with data.

### **Additional Features**
- Error handling for Firebase connectivity issues.
- User-friendly transitions and animations.
- Clean and responsive UI design.

---

## **Showcase**

### **Screenshots**
| Blog List Page                          | Blog Details Page                       |
|-----------------------------------------|-----------------------------------------|
| ![Blog List](screenshots/blog_ss1.jpg) | ![Blog Details](screenshots/blog_ss2.jpg) |

### **Demo GIF**
![App Demo](screenshots/blog.gif)

---

## **Folder Structure**

The project follows a clean and modular structure for better scalability and maintainability:
```
lib/
│
├── core/              # Core utilities and shared resources
│
├── data/              # Data layer of the application
│   ├── data_source/   # Data sources, e.g., Firebase, REST APIs
│   │   └── firestore/ # Firestore-specific implementations
│   └── repositories/  # Abstract repositories (data fetching logic)
│
├── domain/            # Domain layer for business logic
│   ├── models/        # Data models (e.g., BlogPost)
│   └── repositories/  # Interfaces for repositories
│
├── presentation/      # UI and presentation layer
│   ├── bloc/          # State management (e.g., BLoC pattern)
│   ├── screens/       # UI screens (e.g., BlogListScreen, BlogDetailScreen)
│   └── widgets/       # Reusable UI components
│
└── main.dart          # Application entry point

```

---

## **Contribution Guidelines**

Contributions are welcome! If you'd like to contribute:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes and push them to your fork.
4. Submit a pull request.

---

## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

## **Contact**

For questions or suggestions:
- **Author**: [Harsh Rajput](https://github.com/harshrajput1506)
- **Email**: harshrajput2906@gmail.com
