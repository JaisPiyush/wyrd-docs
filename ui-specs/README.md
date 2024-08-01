# Flutter App Design Documentation

## Introduction

This project is flutter based mobile application of dating app. The app features a clean UI and leverages the Bloc pattern for state management to ensure scalable and maintainable codebase.

The main highlight of the design documentation are:

1. Code should follow separation of concern strategy.
2. External services like firebase should not directly be inducted in service, rather it should use adapter pattern.
3. Code should follow Flutter [coding style guide](https://dart.dev/effective-dart/style).
4. All custom written functionalities should be tested.
5. Data source and repository should be separate. No repository should make direct network or db requests.

## Objectives

The primary objective of this document is to develop a flutter dating app that allows users to:

- Find a live date.
- Find dating rooms.
- Join dating rooms and find matches.
- Chat with dates.

## Features

1. ### User Authentication
   - login using phone number
2. ### Find match
   - create/edit dating profile
   - view number of matches left and matching quota.
   - info button to now details about matches left, matching quota and cool down period.
   - set dating preferences
   - find matches
3. ### Dating rooms
   - find dating rooms based on
     - location (dating rooms can be location restrictive or open to all)
     - start and end date (dating room can have not defined end date)
     - by QR code or room id.
   - join dating rooms: dating rooms can be either public or private, only public dating rooms can be searched, private rooms can only be joined by joining code.
     - join by scanning a qr code: User will redirect to dating room and can join the room without entering joining code by clicking join button.
     - join by entering joining code: User will enter joining code.
   - view all the joined dating rooms which are active.
4. ### Dating room
   - view dating room details if not joined.
   - dating room matching page if joined the room.
   - button to view dating room details if joined the room.
   - button to share, leave the dating room.
5. ### Profile
   - view/edit current profile.
   - Help center and tips for using app.
6. ### Settings
   - logout
   - view app version
   - block list
   - phone number
   - legals
7. ### Block list
   - view blocked numbers
   - add/ remove number from block list
8. ### Chats
   - view open chats (matched pairs).
   - leave chat and end match pair.
   - convert chat to relationship.
   - expose profile & view matches profile.

## Activities

## Pages

1. ### locationPermission

   Requests Permissions for location access for matching algorithm.

   -Routing

   - Route: '/locationPermission'
   - onNextCallBack: ''
   - onRejectCallBack:''

2. ### enterBasicDetails

   <!-- #### accountSetupPage1 -->

   Enter User basic details such as name and date of birth

   -Routing

   - Route:'/enterBasicDetails'
   - navigate to:'/accountSetupPage2'

   -Actions

   - Enter name in Textfield and date of birth
   - Storing the State of the Textfield(Persistent).

3. ### selectGender

   <!-- #### accountSetupPage1 -->

   allow user to select gender in details.

   -Routing

   - Route:'/gender'
   - navigate to:'/genderConfirmation'
   - onPop:'/enterPBasicDetails'

   -Actions

   - Choose Gender From given options(Men,women,other).
   - After Selection, allow user to Select Gender in detail.
   - open a bottom-sheet Displaying Details of particular Gender.

## Widgets

## Modules

## blocs

1. ### LocationPermissionBloc

   -Events

   - RequestLocationPermission: Request Location Access

   -States

   - LocationPermissionGranted: State when permission is Granted.
   - LocationPermissionDenied: State when Permission is Denied.

2. ### AccountSetupPage1Bloc

   -Events

   - EventName: Event to capture Profile Name
   - EnterDOB: Event to capture DOB
   - SaveDetails: Event to Save the State in Datatype- Profile.

   -States

   - AccountSetupPage1BlocSuccess: State for account saving details successfully.
   - AccountSetupPage1BlocFailure: State for Failed cases(Internet Connection issues ,etc.).

### FirebasePhoneAuthenticationModule

```dart
class FirebasePhoneAuthenticationModule {
    // Retrieve [FirebaseUser] from [PhoneAuthCredential]
    FirebaseUser phoneAuthCredentialToFirebaseUser(PhoneAuthCredential credential);


    // Method for phone number authentication. The method also supports automatic code retrieval and authentication.
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

    // Manually singIn with phone number and sms code.
    Future<T> signInWithPhoneNumber<T>(
        String verificationId,
        String smsCode,
        // Authenticate the user on backend.
        // If the callback is not provided, the functional will only sign in with phone number authentication service.
        [Future<T> Function(FirebaseUser user) onSignInComplete]
    ) async {
        // Some code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        await auth.signInWithCredential(credential);
        FirebaseUser firebaseUser = phoneAuthCredentialToFirebaseUser(credential);
        // Some code
        if (onSignInComplete) {
            return await onSignInComplete(firebaseUser);
        }
    }

}
```

**Firebase Phone auth exceptions**
| code | description |
|------|-------------|
|'invalid-phone-number'| Phone number was incorrect|

### AuthenticationAPIModule

```dart
class AuthenticationAPIModule {
    // login wyrd backend using [FirebaseUser]
    // store the jwt returned by backend.
    Future<void> loginWithFirebaseUser(FirebaseUser user) async {
        final String idToken = await user.getIdToken();
        // Implement backend login and return jwt
    }

    // Fetch logged in user from backend.
    Future<User> getUser();
}
```

## Repositories

### AuthenticationRepository

```dart
class AuthenticationRepository {

    /*
    * Return logged in [User] model.
    *
    * Get [FirebaseUser] via `Firebase.instance.currentUser`
    * If jwt doesn't exists, then call @method loginWithFirebaseUser
    * Fetch current user from backend
    *
    * Errors:
    *   - firebase user is not logged in
    *   - login error from backend
    *   - unauthorized server request to backend (401)
    *
    */
    Future<User> getCurrentUser();

    // Make authorized request to backend for refreshing the jwt
    // Update the stored jwt in cookie and shared pref
    Future<void> refreshBackendToken();


}
```

## Models

## Appendix

### Packages

- easy_loading_button
- pinput: OTP input
- tutorial_coach_mark
- persistent_bottom_nav_bar: fixed bottom bar
- latlong2
- bloc
- flutter_bloc
- flutter_osm_plugin: location picking with Ola
