# Calley Mobile App - Flutter Machine Test

[![Flutter Version](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev)
[![Company](https://img.shields.io/badge/Company-C%20S%20Tech%20Infosolutions-orange.svg)](https://csquaretech.com)

Machine test submission for the **Flutter Developer** role at **C S Tech Infosolutions Private Limited**.

---

## 📱 Project Overview

**Calley** is an automated calling dialer application that empowers call centers and agents to streamline their calling workflow, track real-time dispositions, and monitor call progress seamlessly across devices.

This mobile application strictly adheres to the official **Figma designs** and integrates with the **Calley Mock REST APIs**.

---

## ✨ Features & Screen Flow

The application implements all 9 screens demonstrated in the official machine test specification:

1. **Choose Your Language (`/language`)**
   - Multilingual support (English, Hindi, Bengali, Kannada, Punjabi, Tamil, Telugu, French, Spanish) with native greetings.
   - Clean radio selection with persistent language state.

2. **User Registration (`/register`)**
   - Calley brand identity & logo.
   - Name, Email, Password, and Mobile Number (+91 prefix) validation.
   - Checkbox for Terms and Conditions agreement.
   - Integrates with `POST /api/auth/register`.

3. **WhatsApp / Email OTP Verification (`/otp`)**
   - 6-digit auto-advancing OTP digit input fields.
   - 30-second resend countdown timer.
   - Integrates with `POST /api/auth/send-otp` and `POST /api/auth/verify-otp`.

4. **User Login (`/login`)**
   - Email & Password authentication with visibility toggle.
   - "Forgot Password?" dialog.
   - Integrates with `POST /api/auth/login`.

5. **Getting Started / Tutorial (`/tutorial`)**
   - User profile badge (`Calley Personal`).
   - "2 MINUTE CHALLENGE" video preview banner linking directly to tutorial.
   - WhatsApp quick support integration (`https://wa.me/917676286822`).

6. **Settings & Calling Lists (`/settings`)**
   - Full user profile card (Avatar, Name, Email, Phone, Subscription).
   - Profile Settings: App Language change, Password reset.
   - Calling Lists manager with live **Refresh** button querying `GET /api/list?userId={id}`.

7. **Interactive Dashboard (`/dashboard`)**
   - Active Calling List badge ("Test List" - 50 CALLS).
   - **Interactive Animated Donut Chart** built with pure Flutter `CustomPainter`:
     - **Blue Segment**: Called / Done Calls (23)
     - **Yellow Segment**: Pending Calls (27)
     - **Purple Segment**: Rescheduled / Schedule Calls (11)
   - 3 Stat Summary Cards with left accent indicator bars.
   - One-tap "Start Calling Now" primary action button.
   - Custom styled bottom navigation bar.

8. **Navigation Drawer (Side Menu)**
   - Header with user name, email, and subscription plan.
   - Navigation links: Getting Started, Sync Data, Gamification, Send Logs, Settings, Help, Cancel Subscription.
   - App Info: About Us, Privacy Policy, Version 1.01.52, Share App.
   - Secure Logout flow with dialog confirmation.

9. **Calling Queue & Feedback Dispositions (`/calling-queue`)**
   - Tabbed queue view (All, Pending, Done, Scheduled).
   - Contact cards with Title, Full Name, Company, Phone, Address, and Status badge.
   - Phone dialer launch via `tel:` URL scheme.
   - Disposition modal to log call feedback: *Very positive*, *Satisfied*, *Needs follow-up*, *Neutral*, *Negative*.

---

## 🛠️ Tech Stack & Architecture

- **Architecture:** Clean MVVM / Provider Architecture
- **State Management:** `provider: ^6.1.1`
- **Networking:** `http: ^1.2.0` with SSL bypass & intelligent mock fallback ensuring zero crashes
- **Local Persistence:** `shared_preferences: ^2.2.2`
- **Calling / External URLs:** `url_launcher: ^6.2.5`
- **Charts:** Zero external bloat — custom animated `CustomPainter` donut chart

---

## 🔌 API Integration

Base URL: `https://mock-api.calleyacd.com`

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/api/auth/register` | `POST` | Registers a new user |
| `/api/auth/login` | `POST` | Authenticates existing user |
| `/api/auth/send-otp` | `POST` | Triggers OTP dispatch |
| `/api/auth/verify-otp` | `POST` | Validates 6-digit OTP |
| `/api/list?userId={id}` | `GET` | Fetches calling lists assigned to user |
| `/api/list/{listId}` | `GET` | Fetches detailed call records & metrics |

*Note: The app contains an automatic mock fallback service so it functions reliably even when the mock server has network hiccups or certificate mismatches.*

---

## 🚀 How to Run the Project

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android Device or Emulator

### Steps
1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd calley_app
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```
4. Build Debug APK:
   ```bash
   flutter build apk --debug
   ```
   The APK will be located at: `build/app/outputs/flutter-apk/app-debug.apk`

---

## 📬 Candidate Deliverables Checklist

- [x] Complete Flutter Source Code matching Figma designs
- [x] API Integration with Postman collection
- [x] Interactive Dashboard with animated Donut Chart & statistics
- [x] Call Dispositions & Phone dialer action
- [x] GitHub Repository with access granted to `info@cstech.in`
- [x] Debug APK built and ready to test
- [x] Screen recording of the application running on device / emulator
