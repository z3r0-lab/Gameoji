# Gameoji

Gameoji is an interactive mobile app where players guess video game characters based on emoji clues and now can also interact with them using AI-powered chat. Designed for gaming enthusiasts, it combines quick thinking, fandom knowledge, and engaging conversations into a fun and accessible experience.

## Installation and Launch Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/z3r0-lab/gameoji.git
   ```
2. **Open the project**
   - Open the project folder in **Xcode 15+**.

3. **Install dependencies**
   - Ensure you have **Firebase** SDK integrated via **CocoaPods**.
   - Run the following command inside the project directory:
     ```bash
     pod install
     ```
   - Open the `.xcworkspace` file.
   - Configure your Firebase project and replace the `GoogleService-Info.plist` file.

4. **Run the project**
   - Select a simulator or connect a device.
   - Press `Cmd + R` to build and run the application.

> **Requirements:** iOS 16.0+, Swift 5.9+, Xcode 15+

## Design and Development Process

The project followed an iterative design approach:

- **Conceptualization:** Define the core idea — emoji-based character guessing.
- **Wireframing:** Sketch primary user flows, onboarding, quiz mechanics, leaderboard, and chat interactions.
- **Development:**
  - **Frontend:** Built using **SwiftUI** and **MVVM architecture**.
  - **Backend:** Firebase Firestore for dynamic character and game data.
  - **AI Chat Integration:** LLM-based chat system connected for dynamic conversations with characters.

## Unique Approaches and Methodologies

- **Dynamic Data Loading:** Character and game data are pulled dynamically from Firestore.
- **Gradient UI Design:** Applied playful gradient backgrounds for a vibrant gaming experience.
- **Searchable Character List:** Implemented live search to allow users to quickly find characters.
- **AI Character Interaction:** Players can now chat with their favorite game characters, powered by a large language model.
- **Future Expandability:** The design allows easy addition of new games, characters, and chat features without major code changes.

## Development Trade-offs

- **SwiftUI over UIKit:** SwiftUI was chosen for faster prototyping, though it presented limitations in fine-grained UI customization compared to UIKit.
- **Firestore as Backend:** Chose Firestore for simplicity and scalability, but it requires internet connectivity for the dynamic content.
- **Single Platform (iOS):** Initially prioritized iOS only to focus on perfecting the core user experience.

## Known Issues

- **Offline Limitations:** App content does not cache aggressively yet, leading to reduced functionality when offline.
- **Limited Character Animation:** Current version uses static images; animated characters would enhance immersion.
- **LLM Chat Interaction:** Basic functionality implemented; further personalization and context handling improvements are planned.

## Technical Stack Justification

- **SwiftUI:** Enables rapid UI development with clean, declarative code.
- **MVVM Architecture:** Ensures separation of concerns and better testability.
- **Firebase Firestore:** Provides real-time database capabilities with minimal server maintenance.
- **Firebase Authentication (Optional):** Can easily be added for user accounts and game progress tracking.
- **CocoaPods:** Used for managing dependencies reliably and ensuring stable Firebase integration.
- **LLM API Integration:** Adds dynamic, interactive conversations to increase player engagement and uniqueness.

This combination of technologies was selected to balance development speed, scalability, and future feature expansion, including AI-powered NPC interactions.

---

**Gameoji** is constantly evolving — stay tuned for exciting updates with richer content, smarter interactions, and expanded universes!
