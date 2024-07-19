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

### 1. Main Activity `activity:main`
- Main activity will implement guard methods during build for checking a valid [Dating Profile](#2-dating-profile), re-init Initialization Activity on failed.
    - In case of intent launch
- Use page view to show pages:
    1. Find Match
    2. Dating rooms
    3. Chats
    4. Profile
- These four pages will be accessible directly through bottom bar.
- if number of active `profile.current_active_chats` > 0, then `Chats` page will load by default, otherwise `Find Match` will load.


```dart
class MainActivity {
    final DatingProfile? profile;
}
```

### 2. Initialization Activity `activity:initialization`
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




### 3. Phone Number Authentication `activity:phone_auth`
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

### 4. Create Dating Profile `activity:create_profile`

- Store [CreateDatingProfileModel](#4-create-dating-profile) as state.
- Use `PageView` widget for building multi-page form.
- Each page will have save button for updating `createProfileModel` state.
- Page will have back navigation button according to need.

Pages:

#### Profile Essential Page
Default loaded when using create dating profile activity.
- Save button will update the `createProfileModel` and navigate to next page.

Included fields:
    - Name
    - DOB
    - about
    - age range


#### Gender
User select their gender.
- This page is re-usable. Edit profile will also implement this.
- A compact view presenting only three genders `Man, Women, Non-binary`.
- Each gender will have a clickable subtext which will show all sub-genders within this.
- Sub-gender is only for namesake, matching will happen through `Male, Female, Non-binary`.


#### Sub gender selection page
- Dynamically (using pageController) added page for selection of sub-gender.
- Implement a back navigation button that pops the current page. Ensure that the page is removed from the PageController’s stack, so when the user navigates from the gender page to the next page, they won’t return to this page.
- Show [ListRadioSelectionWidget](#3-listradioselectionwidget)
- no next button.
- `onChange` will update the gender in through callback [CreateDatingProfileModel](#4-create-dating-profile)

##### Interested Gender
- Four checkbox `Men, Woman, Non-binary, Everyone`.
- Men and Women can be selected together, Non-binary and Everyone will be single selects.


#### 4b. Medias
- 6 squares for uploading media (image | video).
- First media should be image.
- Picked square will have a cross button on top for removing the image, and on click the square will prompt for media picking.
- Min 2 media is required.
- If any media is left to upload, show `Upload` button, after upload show Next button.
- On upload set `media.uploaded` to true for each media.
- Call `setState` for state update only after uploading all the medias.

##### hasUnUploadedMedia
```dart
bool hasUnUploadedMedia(List<DatingAccountContentMediaModel> medias) {
    return medias.any((media) => !media.uploaded);
}
```


#### 4c. Select Interest Tags.
- Fetch all available interests with categories.
- Render [TagSelectionWidget](#2-tagselectionwidget).
- Min. 3 amd maximum 8 tag can be selected.
- Next button will block the back navigation button (it will set state `freezeNavigation` to true) and then call the function to create the profile (Show loading within the button).
- After completion reinstate the `InitializationActivity` by pop and replace in Navigation.



### Find Match Page

### Dating Rooms Page

### Dating Room Activity

### Dating Room Matching Page

### Chats Page

### Profile Page

### Payment activity

## Widgets

### 1. TimerWaitedTextButton
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

### 2. TagSelectionWidget
- Collection of selectable chips grouped in categories.
- Each tag will contain category as Full Name, all tags must be grouped by category during presentation.
- Each tag can be selected and un-selected.
- It should show number of selected tags.

```dart
class TagSelectionWidget extends StatefulWidget {
    final List<String> selectedTags;
    final List<InterestTagModel> tags;
    // Minimum number of tags user must select.
    int minSelectedTags = 0;
    // If defined, user should not cross the upper bound of selected tags.
    int? maxSelectedTags;
    final VoidCallback onCancel;
    // Send updated selected tags
    final Function(List<String> selectedTags) onSave;
}
```

### 3. ListRadioSelectionWidget
```dart
class ListRadioSelectionWidget {
    final List<String> titles;
    final String? selectedTitle;
    final Function(String title) onChange;

}
```


## Blocs

### 1. Initialization Bloc

- onCheckAuthenticationStatus
    1. emit `InitializationStateCheckingAuthenticationStatus`
    2. [Check user](#getcurrentuser-1), if doesn't exist emit `InitializationStateAuthenticationStatusFailed`.
    4. return `onFetchDatingProfile`.

- onFetchDatingProfile
    1. emit `InitializationStateFetchingDatingProfile`.
    2. if dating profile doesn't exist emit `InitializationStateFetchingDatingProfileFailed`.
    3. Send updated device token (of FCM) to backend, without awaiting [setDeviceToken](#setdevicetoken). 
    4. emit `InitializationStateFinished`.

#### Initialization States

- InitializationStateCheckingAuthenticationStatus
- InitializationStateAuthenticationStatusFailed
- InitializationStateFetchingDatingProfile
- InitializationStateFetchingDatingProfileFailed
- InitializationStateFinished
    ```dart
    InitializationStateFinished({
        // Backend logged in user
        final User user,
        // Dating profile of user
        final DatingProfileModel profile
    });
    ```
- InitializationStateErrorState (String message)


#### Initialization Events

- InitializationEventCheckAuthenticationStatus
- InitializationEventFetchDatingProfile




## Repositories

### 1. Account Repository

#### 1a. getCurrentUser
Fetch current user from backend.

```
GET: /account/user/me/
```
Returns [User](#user).

#### 1b. getMyDatingProfile
Fetch dating profile of current user.
```
GET: /account/
```
Returns [Dating Profile](#dating-profile).

#### 1c. createDatingProfile
```
POST: /account/
Body: CreateDatingProfileModel
```
Returns [Dating Profile](#2-dating-profile)
#### 1c. setDeviceToken
```
POST: /account/device
```
Returns `void`.

### 2. Authentication Repository

#### 2a. loginWithPhone
login on the backend using phone number authentication.

```
POST: /account/auth/login/phone/
```

Returns [User](#user).

#### 2b. refreshToken
refresh access JWT token.
```
POST /account/auth/token/refresh/
```

Returns `String`.


## Models

### 1. User

```dart
class User {
    final String id;
    final String phoneNumber;
}
```

### 2. Dating Profile
```dart
class DatingProfileModel extends CreateDatingProfileModel {
    final User user;
}
```

### 3. Interest Tag
```dart
class InterestTagModel {
    final String tag;
    final String? icon;
    final String category;
}
```

### RangeDataType
- Range depicts `[1,3]` mathematical notation.
```dart
class RangeDataType<T> {
    final T lower;
    final T upper;
}
```

### 4. Create Dating Profile
```dart

class DatingAccountContentMediaModel {
    final String contentType;
    final String url;
    final String? caption;
    // createdAt is undefined when user picked the media but hasn't saved it yet.
    final DateTime? createdAt;
    // Default value of uploaded will be true.
    // Only if user has picked the file and not uploaded the media yet, it will be false.
    final bool uploaded;
}

class CreateDatingProfileModel {
    String name;
    Date dob;
    // Max 500 chars
    String bio;
    // The properties below will be set in stages
    String? gender;
    // Selected sub-gender
    String? subGender;

    List<String>? interestGenders;

    // The first image will by default become avatar.
    String? avatar;

    // The first media should be image.
    List<DatingAccountContentMediaModel>? medias;
    List<InterestTagModel>? interestTags;
}
```

## Modules

### 1. Firebase Manager

#### phoneAuthCredentialToUser
Convert Firebase `PhoneAuthCredential` class to [User](#user) model.
```dart
static User phoneAuthCredentialToUser(PhoneAuthCredential credential);
```

#### firebaseUserToUser
Convert firebase user to [User](#user) model.


### Authentication adapter
Responsible for authentication executions.


#### refreshBackendToken
Refresh backend access token and store it into shared prefs.



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

### 2. Notification Manager Module
- Manage find match notifications
- New chat message notifications
- Dating room find match notification
- Alert notification.

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

### Deep links
- Link for joining dating room.
- Link for opening dating room.
- Link for opening chat.
- Link for payment activity.