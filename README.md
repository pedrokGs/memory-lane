# MemoryLane

MemoryLane is a Flutter-based mobile application designed to help users **capture, organize, and revisit their memories** with ease. It integrates authentication, cloud storage, and location-based features to provide a seamless experience.

---

## Features

- **User Authentication**
  - Email/password login & registration using Firebase Auth
  - Validation for empty fields and email format
  - Loading & error feedback

- **Memory Management**
  - Create, update, and delete memories
  - Each memory includes title, description, category, photo URL, latitude, longitude, and timestamp

- **Data Integrity & Security**
  - Secure Firebase integration
  - Data consistency with Firestore

- **Additional Features**
  - Camera & gallery integration
  - Geolocation support
  - UI/UX refinement with prioritized design improvements

---

## Project Structure

- `lib/` – Main Flutter application code
- `assets/` – Images, icons, and other static resources
- `test/` – Unit and widget tests
- `android/` – Native Android integration
- `firebase.json` – Firebase project configuration
- `pubspec.yaml` – Dependencies and metadata

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/pedrokGs/memory_lane.git
   ```
2. Navigate to the project folder:
   ```bash
   cd memory_lane
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Configure Firebase:
   - Add your `google-services.json` and/or iOS configuration files
5. Run the app:
   ```bash
   flutter run
   ```

---

## Roadmap

Based on our [Trello Board](https://trello.com/b/3JiwZ7N7/memorylane):

- [x] Project setup (Flutter, Firebase)
- [x] Basic authentication screen
- [x] User Provider implementation
- [ ] Memory model & provider
- [ ] Camera & gallery integration
- [ ] Geolocation and map details
- [ ] UI/UX refinement
- [ ] Testing & code review automation

---

## License

This project is licensed under the [MIT License](LICENSE).
