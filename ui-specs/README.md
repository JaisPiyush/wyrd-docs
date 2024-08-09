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

## Architecture

1. Global blocs wrapping MaterialApp.
    - AuthenticationBloc
    - UserDatingProfileBloc
    - RotaryMatchingAndMatchedPairBloc
    - DatingRoomBloc
2. **Activity**: A sequence of pages focused on particular task will be called an Activity.
    - CreateProfileActivity
    - MainActivity
    - ProfileActivity
    - DatingRoomActivity
    - ChatActivity
3. Local blocs will exists on Activity or Page levels.
    - SearchDatingRoomsBloc
    - MatchedPairChatBloc
    - UserBlockListBloc



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
1. ### InitializationActivity

    **route**: /

    #### Responsibilities
    1. Check user is logged in, If not then start PhoneAuthenticationActivity.
    2. Check user has a dating profile, If not then start CreateDatingProfileActivity.
    3. Check user's dating profile completion score is above 60%, If not then start EditDatingProfileActivity.
    4. If user was directed through a deeplink then push the deeplink navigation.
    5. Start MainActivity.

    #### Blocs used
    - AuthenticationBloc
    - UserDatingProfileBloc

    The InitializationActivity widget will be `Splash` screen from Figma.

    #### Implementation
    - MultiBlocListener with all the bloc initializations and trigger navigation as required by states.
    - For states:
        - AuthenticationStateUserIsUnauthorized, it will navigate to [PhoneAuthenticationActivity](#phoneauthenticationactivity).
        - AuthenticationStateAuthenticationCompleted, it will add `UserDatingProfileEventCheckDatingProfileStatus` event.
        - 

2. ### PhoneAuthenticationActivity
    **route**: /auth
    - PhoneActivity widget will be `walkthought` screen from Figma.
    It contains 2 pages:
    - PhoneNumberInputPage.
    - PhoneVerificationCodeInputPage.
3. ### CreateDatingProfileActivity
4. ### MainActivity
5. ### DatingRoomsActivity
6. ### ProfileActivity



## Pages

1. ### PhoneNumberInputPage
    **route**: /auth/phone
    The widget will be `Signup` page from figma.

    #### Responsibilities
    1. It will take phone number from user and validate the format of the phone number.
    2. On next click it will fire bloc event for phone number authentication.

    #### Implementation
    The next button will be wrapped in a `BlocConsumer` widget, which will:

    1. Listen for `PhoneNumberAuthenticationFailedAuthenticationState` and display a snackbar.
    2. In the builder, show a loading animation when in the `SendingVerificationCodeAuthenticationState` state; otherwise, display the normal button.
    3. On the next button click, add the `SendVerificationCodeToPhoneNumberAuthenticationEvent` event to the authentication bloc, with a callback to navigate to the `VerificationCodeInputPage`.

    #### Blocs
    - AuthenticationBloc

2. ### VerificationCodeInputPage
    **route**: /auth/code

    #### Route arguments
    1. String phoneNumber.
    2. String verificationId.

    #### Responsibilities
    1. It will accept the code input.
    2. Upon completing the input or by a manual click, it will automatically trigger the code verification event in the bloc.

    #### Implementation
    The widget will be the `verification` screen from Figma.

    1. **Main Body:**
    - The main body will be wrapped within a `BlocConsumer` of the `AuthenticationBloc`.
    - It will listen for the `ePhoneNumberAuthenticationFailedAuthenticationStat` state and display a snackbar when this state occurs.

    2. **Timer:**
    - The timer will be wrapped within a `BlocSelector` of the `AuthenticationBloc`.
    - It will listen for the `WaitingForCodeInputAuthenticationState` state and render the time.
    - When the timer reaches zero, it will display a text button labeled 'resend'.

    3. **Button:**
    - The button will be wrapped within a `BlocConsumer` of the `AuthenticationBloc`.
    - It will listen for the following states:
        - `PhoneNumberAuthenticationFailedAuthenticationState` to show a snackbar.
        - `AuthenticationCompletedAuthenticationState` to navigate back to `InitializationActivity`.

    4. **On Click:**
    - On click, the button will trigger the `VerifyCodeAuthenticationEvent` event in the `AuthenticationBloc`.
    - It will also start displaying a loading animation.


## Widgets


## Bloc

1. ### AuthenticationBloc
    ### Responsibilities
    1. Check user login status.
    2. Perform phone number authentication and log in the user on the backend.
    3. Send the notification device token to the backend.
    4. Retrieve and refresh the JWT token based on its expiry status.

    ### Properties
    - **String? jwt:** JWT token, either loaded from shared preferences or fetched from the backend.
    - **[UserModel?](#usermodel) user:** Backend logged-in user.

    ### States
    1. **InitializationAuthenticationState**
    2. **CheckingAuthenticationStatusAuthenticationState:** Bloc is checking user authentication status; show loading screen.
    3. **UserIsUnauthorizedAuthenticationState:** Bloc has found the user to be unauthorized; the activity will redirect to the login page.
    4. **AuthenticationCompletedAuthenticationState:** Bloc approves the user's login status.
    5. **SendingVerificationCodeAuthenticationState:** Bloc is requesting Firebase for a phone number authentication code (intentionally add a 5-second delay to show a small loading screen before moving to the next page for better UX).
    6. **WaitingForCodeInputAuthenticationState(Duration secondsLeft):** While sending the code for verification, the bloc sets a duration timer to update the countdown UI. When secondsLeft reaches 0, the UI should show a resend button. Use the [CountdownTimerController](#countdowntimercontroller) for creating a streaming ticker.
    7. **WaitingForCodeVerificationAuthenticationState:** Bloc has sent the OTP code for verification and is waiting for a response.
    8. **PhoneNumberAuthenticationFailedAuthenticationState(String phoneNumber, [Exception e]):** Authentication of the phone number has failed.
    9. **PhoneNumberAuthenticatedLogInBackendAuthenticationState:** Phone authentication is complete, and the bloc has requested login on the backend.
    10. **RefreshingJWTCredentialsAuthenticationState:** Bloc is refreshing the JWT token.

    ### Events
    1. **CheckAuthenticationStatusAuthenticationEvent**
    2. **SendVerificationCodeToPhoneNumberAuthenticationEvent(String phoneNumber, Function(String verificationId) onCodeSent):** The event will call the Firebase function for phone number authentication and trigger the onCodeSent callback as soon as the code is sent.
    3. **VerifyCodeAuthenticationEvent(String verificationId, String smsCode):** Send the verification code for manual verification.

    #### Events
2. ### UserDatingProfileBloc
    #### Property
    - [DatingProfile](#datingprofile) profile: Dating profile of the current user.
    #### States
    1. InitializationUserDatingProfileState.
    2. FetchingDatingProfileUserDatingProfileState.
    3. FetchedDatingProfileUserDatingProfileState(DatingProfile profile).
    4. DatingProfileFetchingFailedUserDatingProfileState(String? msg).
    5. FetchingPublicDatingProfileUserDatingProfileState.
    6. FetchedPublicDatingProfileUserDatingProfileState(DatingProfile profile).
    7. PublicDatingProfileFetchingFailedUserDatingProfileState(String? msg).
    #### Events
    1. **FetchDatingProfileUserDatingProfileEvent**: Fetch dating profile of the currently logged in user.
    2. **FetchPublicDatingProfileUserDatingProfileEvent(int id)**: Fetch user's detail associated with the `id`. The event will be called when user wanted to view profile of other user.
    3. **CreateDatingProfileUserDatingProfileEvent
3. ### RotaryMatchingAndMatchedPairsBloc
4. ### DatingRoomBloc
5. ### SearchDatingRoomsBloc
6. ### MatchedPairChatBloc
7. ### UserBlocListBloc




## Modules

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
        Future<void> Function(UserModel user, Map<String, dynamic> metadata) verificationCompleted,
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



### CountdownTimerController
Create and control stream of countdown duration. The reason for creating this separate countdown timer controller is to handle countdown process during different states of app.

For e.g a countdown timer, for resend button activation in OTP code verification, will be paused when the app goes into background and will resume from same time after app again comes back into foreground.

```dart
class CountdownTimerController {
    final DateTime endTime;
    final Function(Duration durationLeft) onTick;
    const CountdownTimerController(this.endTime, this.onTick);

    StreamSubscription<Duration> _subscription;
    StreamController<Duration> _controller;

    StreamSubscription<Duration> get subscription => _subscription;
    StreamSubscription<Duration> get controller => _controller;

    pause() {}
    resume() {}
    close() {}

}
```

## Repositories

### AuthenticationRepository

```dart
class AuthenticationRepository {
    // Make authorized request to backend for refreshing the jwt
    // Update the stored jwt in cookie and shared pref
    // API: `POST: /account/auth/token/refresh`
    Future<String> refreshBackendToken(String refreshToken);

    // idToken is unique identification token retrieved from firebase after authentication.
    // API: `POST: /account/auth/login/phone`
    Future<BackendLoginResponse> loginOnBackend(String idToken);

    // API: `DELETE: /account/auth/logout`
    Future<void> logoutFromBackend();

    // API: `POST: /account/device/token`
    Future<void> setDeviceToken(String deviceToken);
}
```

### DatingProfileRepository

```dart
class DatingProfileRepository {

    // API `GET: /account/profile`
    Future<DatingProfile> getMyDatingProfile();
}
```

### BackendUtilityRepository

```dart
class BackendUtilityRepository {

    // API `GET: /account/interest-tags`
    Future<List<InterestTag>> getAllInterestTags();
}
```


## Models

1. ### UserModel
    See User schema from openAPI preview.
2. ### BackendLoginResponse
    See response of `POST: /account/auth/login/phone`.
3. ### DatingProfile
    See ReadDatingProfile schema.
4. ### InterestTag
    See ReadInterestTag schema.




## Appendix

### Packages
- easy_loading_button
- pinput: OTP input
- tutorial_coach_mark
- persistent_bottom_nav_bar: fixed bottom bar
- latlong2
- bloc
- flutter_bloc
- flutter_osm_plugin
- debounce_throttle: limiting autocomplete search request