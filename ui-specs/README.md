# Flutter App Design Documentation

## Introduction
This project is flutter based mobile application of dating app. The app features a clean UI and leverages the Bloc pattern for state management to ensure scalable and maintainable codebase.

The main highlight of the design documentation are:
1. Code should follow separation of concern strategy.
2. External services like firebase should not directly be inducted in service, rather it should use adapter pattern.
3. Code should follow Flutter [coding style guide](https://dart.dev/effective-dart/style).
4. All custom written functionalities should be tested.
5. Data source and repository should be separate. No repository should make direct network or db requests.

### Note
1. All time and datetime on server are in UTC timezone, they are needed to specifically converted to IST when receiving or sending data to server. Suggestion create a custom DateTime, Time class which handles this problem.

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
1. ### PairChatWidget
    * It's a stateful widget, accepts [MatchedPairChatHeader](#matchedpairchatheader) and build the entire chat screen.
    * MatchedPairChatHeader is referenced as model here, but Combined with MatchedPairChatHeaderOperator it can also send messages and update user presence, update typing status and others.
    * Based on MatchedPairActivity the screen should be able to freeze and take inputs from user. Although this will be managed by MatchedPairActivityBloc.

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
    #### Objectives
    1. Fetch user dating profile.
    2. Create user dating profile.
    3. Updating user dating profile.
    4. Set user dating preferences.
    #### Property
    - [DatingProfile?](#datingprofile) profile
    - `Map<String, List<String>>?` createDatingProfileFieldErrors: The property contains all the field errors returned by the server when trying to create dating profile. You must set it null before new creation request and again set it null after successful creation request.
    - `Map<int, DatingProfile>` cachedDatingProfiles: These are cached profiles. Children ProfileDisplayBloc will use this property.

    #### States
    1. InitializedUserDatingProfileState
    2. FetchingDatingProfileUserDatingProfileState
    3. FetchedDatingProfileUserDatingProfileState(DatingProfile profile)
    4. ErrorFetchingUserDatingProfileState
    5. CreatingUserDatingProfileState
    6. **ErrorCreatingUserDatingProfileState({Map<String, List<String>>? fieldErrors, String? detail})**: fieldErrors contains error by each input field. You have to take these errors and show them beneath each field.
    7. CreatedDatingProfileState(DatingProfile profile, [List<[DatingProfileContentMedia](#datingprofilecontentmedia)> medias])
    8. UpdatingDatingPreferencesUserDatingProfileState
    9. ErrorUpdatingDatingPreferencesUserDatingProfileState({Map<String, List<String>>? fieldErrors, String? detail})
    10. ShowDatingPreferencesUserDatingProfileState([DatingPreferences](#datingpreferences) datingPreferences)

    #### Events
    1. FetchUserDatingProfileEvent
    2. CreateUserDatingProfileEvent(DatingProfile profile, [List<[DatingProfileContentMedia](#datingprofilecontentmedia)> medias]): Create dating profile on server. The medias provided will be passed at it is to state.
    3. UpdateDatingPreferencesUserDatingProfileEvent([DatingPreferences](#datingpreferences) datingPreferences)
    4. SetDatingProfileContentMediasUserDatingProfileEvent(List<[DatingProfileContentMedia](#datingprofilecontentmedia)> medias)

    #### Methods
    1. `void setUpdatedDatingProfile(DatingProfile profile)`: Set new dating profile as property.
    2. `void updateDatingProfileUsingDatingPreferences(DatingPreferences datingPreferences)`: Update the original dating profile by merging values from new dating preferences and then set the new dating profile value.
    3. `void cacheDatingProfile(DatingProfile)`: add DatingProfile to cachedDatingProfiles
    4. `void removeDatingProfileFromCache(int profileId)`
    5. `DatingProfile? getDatingProfileFromCache(int profileId)`
    
    
3. ### ContentMediaBloc
    This is a local bloc.
    #### Objectives
    1. Add/remove/update media in dating profile.

    #### States
    1. InitializedContentMediaState
    5. AddingMediasContentMediaState
    6. ErrorAddingMediasContentMediaState({Map<String, List<String>>? fieldErrors, String? detail})
    7. AddedMediasContentMediaState(List<[DatingProfileContentMedia](#datingprofilecontentmedia)> medias)
    8. UpdatingMediaContentMediaState
    9. ErrorUpdateMediaContentMediaState({Map<String, List<String>>? fieldErrors, String? detail})
    10. UpdatedMediaContentMediaState([DatingProfileContentMedia](#datingprofilecontentmedia) media)
    11. UpdatingMediaPositionsContentMediaState
    12. ErrorUpdatingMediaPositionsContentMediaState({Map<String, List<String>>? fieldErrors, String? detail})
    13. UpdatedMediaPositionsContentMediaState(List<[DatingProfileContentMedia](#datingprofilecontentmedia)> medias)

    #### Events
    1. AddMediasContentMediaEvent(List<[DatingProfileContentMedia](#datingprofilecontentmedia)> medias)
    2. UpdateMediaContentMediaEvent([DatingProfileContentMedia](#datingprofilecontentmedia) media)
    3. UpdateMediaPositionsContentMediaEvent(List<[DatingProfileContentMediaPositionUpdate](#datingprofilecontentmediapositionupdate)> newPositions)

    #### Methods
    1. `Future<List<DatingProfileContentMedia>> addContentMediasInProfile(List<DatingProfileContentMedia> medias)`

4. ### TextPromptBloc
    This is a local bloc.
    #### Objectives
    1. Add/Remove/Update text-prompt
    2. Fetch all text prompt
    3. Fetch all text prompt answered by current user

    #### Properties
    1. List<[TextPrompt](#textprompt)>? textPrompts;

    #### States
    1. InitializedTextPromptState.
    2. FetchingPromptTextPromptState.
    3. ErrorFetchingPromptTextPromptState([String? detail])
    4. ShowPromptTextPromptState(List<[TextPrompt](#textprompt)> prompts)
    5. FetchAnsweredPromptTextPromptState
    6. FetchedAnsweredPromptTextPromptState(List<[DatingProfileTextPrompt](#datingprofiletextprompt)> prompt)
    7. AddingPromptAnswerTextPromptState.
    8. ErrorAddingPromptAnswerTextPromptState({Map<String, List<String>>? fieldErrors, String? detail})
    9. AddedPromptAnswerTextPromptState(DatingProfileTextPrompt prompt)
    10. UpdatingPromptAnswerTextPromptState
    12. ErrorUpdatingPromptAnswerTextPromptState({Map<String, List<String>>? fieldErrors, String? detail})
    13. UpdatedPromptAnswerTextPromptState(DatingProfileTextPrompt prompt)   
    11. RemovingPromptAnswerTextPromptState
    12. ErrorRemovingPromptAnswerTextPromptState([String? detail])
    13. RemovedPromptAnswerTextPromptState(int promptId)

    #### Events
    1. FetchAllPromptTextPromptEvent
    2. FetchAllAnsweredPromptTextPromptEvent
    3. AddPromptAnswerTextPromptEvent([DatingProfileTextPrompt](#datingprofiletextprompt) prompt)
    4. UpdatePromptAnswerTextPromptEvent([DatingProfileTextPrompt](#datingprofiletextprompt) prompt)
    5. RemovePromptAnswerTextPromptEvent(int promptId)

    #### Methods



4. ### AssessmentQuestionBloc
    #### Objectives
    1. Fetch all assessment question
    2. Fetch answered assessment question
    3. Answer assessment question
    4. Update assessment question answer

    #### Properties
    - List<[DatingProfileAssessmentQuestion](#assessmentquestion)> unAnsweredAssessmentQuestions: Plain assessment questions are transformed into DatingProfileAssessmentQuestions. The read property will only return un-answered questions
    #### States
    1. InitializedAssessmentQuestionEvent
    2. FetchingAssessmentQuestionState
    3. ErrorFetchingAssessmentQuestionState([String? detail])
    4. FetchedAllAnsweredAssessmentQuestionState([DatingProfileAssessmentQuestion](#datingprofileassessmentquestion))
    5. FetchedAllUnAnsweredAssessmentQuestionState([AssessmentQuestion](#assessmentquestion))
    6. ErrorAnsweringAssessmentQuestionState({Map<String, List<String>>? fieldErrors, String? detail})
    7. ErrorUpdatingAnswerOfAssessmentQuestionState({Map<String, List<String>>? fieldErrors, String? detail})
    8. CreatedAnswerAssessmentQuestionState([DatingProfileAssessmentQuestion](#datingprofileassessmentquestion))
    9. UpdatedAnswerAssessmentQuestionState([DatingProfileAssessmentQuestion](#datingprofileassessmentquestion))

    #### Events
    1. FetchAllUnAnsweredAssessmentQuestionEvent
    2. FetchAllAnsweredAssessmentQuestionEvent
    3. AnswerAssessmentQuestionEvent([DatingProfileAssessmentQuestion](#datingprofileassessmentquestion))
    4. UpdateAnswerOfAssessmentQuestionEvent([DatingProfileAssessmentQuestion](#datingprofileassessmentquestion))

<!-- 4. ### DatingRoomBloc -->
<!-- 5. ### SearchDatingRoomsBloc -->

7. ### ProfileDisplayCubit
    These is a small local cubit used for displaying profiles. It Works in accordance with UserDatingProfileBloc.
    ```dart
    class ProfileDisplayCubit extends Cubit<DatingProfile?> {
        final UserDatingProfileBloc userDatingProfileBloc;
        ProfileDisplayCubit({@required this.userDatingProfileBloc, @required DatingProfile profile}) {
            // Run function for fetching the profile and show state accordingly
        }
    }
    ```



3. ### RotaryMatchingBloc
    #### Objectives
    1. Fetch current matching status of the user.
    2. Join pool for matching

    #### Properties
    1. [RotaryMatchingStatus](#rotarymatchingstatus) currentMatchingStatus
    #### States
    1. InitializedRotaryMatchingState
    2. FetchingMatchingStatusRotaryMatchingState
    3. FetchedMatchingStatusRotaryMatchingState([RotaryMatchingStatus](#rotarymatchingstatus))
    4. JoiningPoolRotaryMatchingState
    5. JoinedPoolRotaryMatchingState

    #### Events
    1. FetchMatchingStatusRotaryMatchingEvent
    2. JoinPoolRotaryMatchingEvent



7. ### ProfileBlockListBloc

6. ### MatchedPairsBloc

    #### Objectives
    1. Fetch chat service token.
    2. Fetch all chat pairs with latest message and unread mark.
    3. Create Phoenix sockets for each pair and bind listeners.
    4. Provide way for listening Chat headers state change from outside the bloc.

    #### Properties
    - `Map<String, MatchedPairChatHeader>` chatHeaderRecord;    
    #### States
    1. **ShowAllMatchedPairState(String roomId, List<MatchedPairChatHeader> chatHeaders)**
    2. FetchingAllChatPairsMatchedPairsState

    #### Events
    1. FetchChatServiceChatTokenMatchedPairsEvent
    2. **FetchAllChatPairsMatchedPairsEvent**: 
        1. Pull all matched chat pairs.
        2. Create sockets for each non-existing pair record.
        2. Pull archived messages of each new pair until latest stored message.
        3. Store these new message in db.
        4. Bind on message handler for each new socket.


7. ### MatchedPairActivityBloc
    #### Objectives
    1. Fetch all activities of the pair
    2. Create new activity on the pair
    #### Properties
    - [MatchedPairActivity?](#matchedpairactivity) latestActivity;
    - List<[MatchedPairActivity](#matchedpairactivity)> activities;
    #### States
    1. InitializedMatchedPairActivityState(([MatchedPairActivity?](#matchedpairactivity)) latestActivity)
    2. FetchingAllMatchedPairActivityState
    3. FetchedAllMatchedPairActivityState[MatchedPairActivity](#matchedpairactivity) latestActivity, (List<[MatchedPairActivity](#matchedpairactivity)> activities)
    4. CreatingMatchedPairActivityState
    5. ErrorFetchingAllMatchedPairActivityState([String? detail])
    6. ErrorCreatingMatchedPairActivity({Map<String, List<String>>? fieldErrors, String? detail})

    #### Events
    1. FetchAllMatchedPairActivityEvent
    2. CreateMatchedPairActivityEvent([MatchedPairActivity](#matchedpairactivity))




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


### ChatServiceColdStorage
  Check [GPT Chat](https://chatgpt.com/share/769daa75-9823-4198-a5de-3499477a8cc5) for implementation idea.
  #### Objectives & Features
  1. Store chats of users
  2. Provide query methods
  3. Provides behavior based stream reaction for getting alert about commits in db.


## Repositories

### AuthenticationRepository

```dart
class AuthenticationRepository {
    // Make authorized request to backend for refreshing the jwt
    // Update the stored jwt in cookie and shared pref
    // API: `POST: /account/auth/token/refresh/`
    Future<String> refreshBackendToken(String refreshToken);

    // idToken is unique identification token retrieved from firebase after authentication.
    // API: `POST: /account/auth/login/phone/`
    Future<BackendLoginResponse> loginOnBackend(String idToken);

    // API: `DELETE: /account/auth/logout`
    Future<void> logoutFromBackend();

    // API: `POST: /account/device/token/`
    Future<void> setDeviceToken(String deviceToken);
}
```

### DatingProfileRepository

```dart
class DatingProfileRepository {

    // API `GET: /account/profile/`
    Future<DatingProfile> getMyDatingProfile();
    // POST /account/profile/
    Future<DatingProfile> createDatingProfile(DatingProfile)
}
```

### BackendUtilityRepository

```dart
class BackendUtilityRepository {

    // API `GET: /common/interest-tags`
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
    #### Methods
    ```dart
    /// Factory method
    DatingProfile fromDatingPreferences(DatingProfile profile, DatingPreferences datingPreferences) {
        /// Create new instance of DatingProfile. Copy values from provided profile argument and updating dating preferences values.
    }
    ```
4. ### InterestTag
    ```dart
    class InterestTag {
        final int id;
        final String tag;
        final String? icon;
        final String category;
        final DateTime created;
    }
    ```
5. ### CreateDatingProfile
    See schema from POST /account/profile/

6. ### UpdateDatingProfile
    See schema from PATCH /account/profile/

7. ### DatingPreferences
   See schema from GET /account/profile/dating-preferences/
   #### Methods
   ```dart
   // Factory method
   DatingPreferences fromDatingProfile(DatingProfile profile) {
        // Create an instance by taking values from DatingProfile
   }
   ```

6. ### DatingProfileContentMedia
    See schema from GET /account/profile/media/

7. ### DatingProfileContentMediaPositionUpdate
    ```dart
    class DatingProfileContentMediaPositionUpdate {
        final int media;
        final int position;

    }
    ```
8. ### TextPrompt
    See schema from GET /common/text-prompt/
9. ### DatingProfileTextPrompt
    See schema from GET /account/profile/text-prompt/
10. ### AssessmentQuestion
    See schema from GET /common/assessment-question/
11. ### DatingProfileAssessmentQuestion
    See schema from GET /account/profile/assessment-question/
12. ### RotaryMatchingStatus
    See schema from GET /match/status/
13. ### MatchedPair
    See schema fom GET /match/pair/
14. ### MatchedPairActivity
    See schema from GET /match/pair/activity/
15. ### MatchedPairChatHeader 
    ```dart
    class RepresentationalChatHeader {
        final MatchedPair pair;
        final PhoenixSocket socket;
        final bool isOnline;
        final String? latestMessage;
        final bool hasUnreadMessages;
        final int unreadMessagesCount;


    }
    class MatchedPairChatHeader extends RepresentationalChatHeader {
        final PhoenixSocket socket;

        // Streams and latest values which Chat widget will use for updating it's state
    }
    ```

16. ### MessagePayload
    ```dart
    class MessageContent {}

    class TextMessageContent extends MessageContent {
        final String text;
    }

    class MediaMessageContent extends MessageContent {
        // "image" | "video" | "audio"
        final String contentType;
        final String url;
        final String? text;
    }

    class EmojiMessageContent extends MessageContent {
        final String unicode;
    }

    class MessagePayload {
        // "text" | "media" | "emoji"
        final String type;
        final String messageId;
        final DateTime createdAt;
        final MessageContent content;
        // Id of the message for which the user has replied or sent reaction.
        final String? targetMessageId;
        final int authorId;

    }
    ```
17. ### ChatMessageModel
    ```dart
    class ChatMessageModel {
        final String messageId;
        final String pairId;
        final int authorId;
        // Id of message on sariska server
        final int remoteId;
        final DateTime createdAt;
        // "delivered" | "error" | "seen" | "sending" | "sent"
        final String status;
        // Only "text" | "media" message content will be stored as separate row.
        final MessageContent content;
        final String? targetMessageId;
        final String? reactionUnicode;
    }
    ```

## Appendix

### Packages
- easy_loading_button
- pinput: OTP input
- tutorial_coach_mark
- persistent_bottom_nav_bar: fixed bottom bar
- location
- bloc
- flutter_bloc
- flutter_osm_plugin
- debounce_throttle: limiting autocomplete search request