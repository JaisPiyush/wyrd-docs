# Flutter App Design Documentation

## Table of Contents
1. [Introduction](#introduction)
2. [Activities](#activities)
3. [Widgets](#widgets)
4. [Blocs](#blocs)
5. [Repositories](#repositories)
6. [Models](#models)
7. [Modules](#modules)
8. [Appendix](#appendix)

## Introduction
This project is flutter based mobile application of dating app. The app features a clean UI and leverages the Bloc pattern for state management to ensure scalable and maintainable codebase.

The main highlight of the design documentation are:
1. Code should follow separation of concern strategy.
2. External services like firebase should not directly be inducted in service, rather it should use adapter pattern.
3. Code should follow Flutter [coding style guide](https://dart.dev/effective-dart/style).
4. All custom written functionalities should be tested.

Code base uses following nomenclature for separating different type of Widgets.
1. Activity: 
    - A process or activity that the user will perform on the app. Such as authentication, finding match, finding rooms, etc. 
    - all routes of an Activity will begin with `activity:` prefix.
    - State of the activity will be cached by flutter's navigation.
2. Page:
    - Sub part of any activity. Multiple parts of profile creation form.
    - Page can be route enabled.
    - all routes of Page will be prefixed with `activity:{activity_id}:page:` if tightly tied with an activity or `page:` otherwise.
    - State of the page will be cached by flutter's navigation if route enabled otherwise manual state caching is required.
3. Widgets.

All Activities and pages except [InitializationActivity](#initialization-activity-activityinitialization) will be wrapped inside `PersistentTabView`.


## Activities

### Main Activity `activity:main`

### Initialization Activity `activity:initialization`
1. Check user authentication statue.
    - If un-authenticated, navigate (replace) to [Phone Number Authentication](#phone-number-authentication-activityphone_auth)
2. Check if dating profile exists:
    - if not, navigate (replace) to [Create Dating Profile](#create-dating-profile-activitycreate_profile)
3. Replace to [MainActivity](#main-activity-activitymain)

Initialization Activity is a Splash Screen.

- `InitializationStateCheckingAuthenticationStatus`, `InitializationStateFetchingDatingProfile` both state will show loading state. 
- `InitializationStateAuthenticationStatusFailed` will replace it with [Phone Number Authentication](#phone-number-authentication-activityphone_auth).
- `InitializationStateFetchingDatingProfileFailed` will replace it with [Create Dating Profile](#create-dating-profile-activitycreate_profile).
- `InitializationStateFinished` will replace it with [Main Activity](#main-activity-activitymain.)
- `InitializationStateErrorState` will show error on splash screen.




### Phone Number Authentication `activity:phone_auth`
- Take user's phone number.
- Take verification code.
- Show verification errors and re-start verification process.
- Sign in user on backend.
- Show loading.

```dart


class PhoneNumberAuthenticationActivity extends StatefulWidget  {

    const PhoneNumberAuthenticationActivity({
        String? phoneNumber,
        String? error
    });

    bool showLoadingIndicator;



}
x

class PhoneNumberAuthCodeVerificationPage {

    const PhoneNumberAuthCodeVerificationPage({
        String phoneNumber,
        String verificationId,
        int? resendToken
    });



    /*
    * Build Tree
    * - Pinput
    * - TimerWaitedTextButton(60s, 'Resend', onResendClick)
    *        - (timeLeft == 0)? ResendButton: Countdown timer
    * - ValueListenableBuilder (codeController)
    *       - (on valid code) FutureBuilder
    *                - loader
    *       - (on future complete)
    *               if future successfully logins
    *                   - navigate (replace) to `activity:initialization`
    *               if it throws error:
    *                   - pop until `activity:phone_auth`, replace it with new `activity:phone_auth` with phoneNumber and error parameters.
    */

}
```

### Create Dating Profile `activity:create_profile`

Pages:
1. [Profile Essential]

#### Profile Essential `activity:create_profile`
Default loaded when using create dating profile activity.

#### Images `activity:create_profile:page:images`

#### Select Interest Tags `page:select_interests`.
- Fetch all available interests with categories.
- 


## Widgets

### TimerWaitedTextButton
- Text button disabled until given time (in seconds) is up.

```dart
class TimerWaitedTextButton extends StatelessWidget {
    const TimerWaitedTextButton({
        @required Duration duration,
        @required String buttonText,
        @required VoidCallback onClick
    });

    // Build
    // FutureBuilder (Future.delayed)
    //   if (waiting)
    //      Show disabled TextButton
    //   else Show enabled TextButton
}
```

## Blocs

### Initialization Bloc

- onCheckAuthenticationStatus
    1. emit `InitializationStateCheckingAuthenticationStatus`
    2. Check Firebase user, if doesn't exist emit `InitializationStateAuthenticationStatusFailed`.
    3. Check backend user, if doesn't exist emit `InitializationStateAuthenticationStatusFailed`.
    4. return `onFetchDatingProfile`.

- onFetchDatingProfile
    1. emit `InitializationStateFetchingDatingProfile`.
    2. if dating profile doesn't exist emit `InitializationStateFetchingDatingProfileFailed`.
    3. emit `InitializationStateFinished`.

#### Initialization States

- InitializationStateCheckingAuthenticationStatus
- InitializationStateAuthenticationStatusFailed
- InitializationStateFetchingDatingProfile
- InitializationStateFetchingDatingProfileFailed
- InitializationStateFinished
- InitializationStateErrorState (String message)


#### Initialization Events

- InitializationEventCheckAuthenticationStatus
- InitializationEventFetchDatingProfile
- InitializationEventCompleteInitialization

## Repositories

### Account Repository

#### getCurrentUser
Fetch current user from backend.

```
GET: /account/user/me/
```

#### getMyDatingProfile
Fetch dating profile of current user.
```
GET: /account/
```

### Authentication Repository

#### loginWithPhone
login on the backend using phone number authentication.

```
POST: /account/auth/login/phone/
```

#### refreshToken
refresh access JWT token.
```
POST /account/auth/token/refresh/
```


## Models

### User

```dart
class User {
    final String id;
    final String phoneNumber;
}
```

## Modules

### Firebase Manager

#### phoneAuthCredentialToUser
Convert Firebase `PhoneAuthCredential` class to [User](#user) model.
```dart
static User phoneAuthCredentialToUser(PhoneAuthCredential credential);
```

#### firebaseUserToUser
Convert firebase user to [User](#user) model.


### Authentication adapter
Responsible for authentication executions.


#### getCurrentUser
```dart
// Check Firebase user using `Firebase.instance.currentUser`.
// If jwt doesn't exists, then call method to @method `loginWithFirebaseUser`
// Fetch current user from backend.
Future<User> getCurrentUser();
```

#### loginWithFirebaseUser
Login backend using firebase user.

```dart
Future<String> loginWithFirebaseUser(FirebaseUser user) async {
    final String = await user.getIdToken();

}
```

### Verify Phone Number
Method for phone number authentication. The method also supports automatic code retrieval and authentication.

```dart
Future<void> verifyPhoneNumber({
    String phoneNumber,
    // Trigger on successful verification of phone number.
    // The method will also handle signing in on the backend system.
    Future<void> Function(User user, Map<String, dynamic> metadata) verificationCompleted,
    // Trigger after authentication service has sent the sms code. The callback
    // will transition the page to code input page.
    VoidCallback(String verificationId, int? resendToken) codeSent,
    // Handle exception handling
    VoidCallback(Exception e) verificationFailed
});
```

#### Firebase Phone auth exceptions
| code | description |
|------|-------------|
|'invalid-phone-number'| Phone number was incorrect|

### Sign in with Phone number

Manually singIn with phone number and sms code. It can op

```dart
Future<User> signInWithPhoneNumber(
    String verificationId, 
    String smsCode,
    // Authenticate the user on backend.
    // If the callback is not provided, the functional will only sign in with phone number authentication service.
    [Future<User> Function(User user) onSignInComplete]
);
```

## Appendix

### Packages
- easy_loading_button: ^0.3.2
- pinput: ^5.0.0
- tutorial_coach_mark: ^1.2.11
- persistent_bottom_nav_bar: ^6.2.1

### Shared Preferences Record
```dart
class SharedPreferencesRecords {
    // Backend authentication jwt
    String jwt;
    // The user has completed app tour
    bool appTourCompleted = false;
}
```