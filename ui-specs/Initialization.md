# Initialization

1. Check firebase user authentication status.
    - If account does not exists, show AuthenticationActivity.
2. Send an un-awaited request updating firebase notification device token.
2. Check if dating account exists:
    - if not then navigate to CreateProfileActivity.
3. Start MainActivity

* Initialization should not happen every time user opens the app. For e.g a user may send the app in background and then comes back, it will re-initialize everything creating a bad UX.
* Instead, the app will cache the initialization details in shared_prefs with caching time and caching validity.

```dart
class SharedPreferencesRecords {
    // JWT of the user
    String jwt;
    bool appTourCompleted = false;

}
```