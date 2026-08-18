# Firebase Authentication Setup Guide

## SHA Keys for Firebase Configuration

### Debug SHA Keys (Development)
- **Package Name:** `com.example.mobile_shop`
- **SHA-1 Fingerprint:** `09:C8:48:91:29:B6:30:E2:82:AD:98:1A:DF:2E:49:B9:86:A3:D8:2E`
- **SHA-256 Fingerprint:** `BA:2A:E0:21:B1:6A:C5:46:6B:C8:3E:06:0A:49:EB:EA:7E:B2:B6:01:40:D7:52:34:5B:59:76:29:01:18:F3:80`

### Firebase Setup Steps:

1. **Go to Firebase Console** - https://console.firebase.google.com

2. **Select your project** or create a new one

3. **Add Firebase to Android App:**
   - Project Settings > Add App > Android
   - Package name: `com.example.mobile_shop`
   - App nickname: `Mobile Shop (Debug)`
   
4. **Register App with SHA Keys:**
   - Paste the SHA-1 fingerprint: `09:C8:48:91:29:B6:30:E2:82:AD:98:1A:DF:2E:49:B9:86:A3:D8:2E`
   - Paste the SHA-256 fingerprint: `BA:2A:E0:21:B1:6A:C5:46:6B:C8:3E:06:0A:49:EB:EA:7E:B2:B6:01:40:D7:52:34:5B:59:76:29:01:18:F3:80`
   
5. **Download `google-services.json`**
   - Save to: `android/app/google-services.json`
   - This file is already added to your gradle configuration

6. **Enable Authentication Methods in Firebase:**
   - Go to Authentication > Sign-in method
   - Enable: Email/Password
   - Optional: Enable Google Sign-In, Phone Authentication, etc.

7. **Enable Firestore Database:**
   - Go to Firestore Database
   - Create Database in test mode (for development)
   - Location: Choose nearest to you

8. **Set Firestore Security Rules:**
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }
    // Admin rules can be added as needed
  }
}
```

9. **Test Authentication:**
   - Run the app: `flutter run`
   - Login screen should show
   - Click "Don't have account? Create new"
   - Create an account
   - Should redirect to home screen if admin, or staff dashboard if employee

## Troubleshooting:

### SHA Key Mismatch Error:
- Verify SHA keys match in Firebase Console
- Delete and reinstall the app

### Google Services JSON Not Found:
- Make sure `google-services.json` is in `android/app/` directory
- Run `flutter clean` then `flutter run`

### Authentication Not Working:
- Check Firebase Console for authentication errors
- Verify email/password is enabled in Auth methods
- Check Firestore rules are not blocking access

## For Release Build:
When ready for release, you'll need:
1. Create a release keystore
2. Get SHA-1 from release keystore
3. Add release SHA-1 to Firebase Console as another app or SHA fingerprint
