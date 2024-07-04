# UI Specification Document

This document details the UI specifications for our app, serving as a guide for the UI designer in developing the app's user interface.

## Authentication Screens

### Phone Number Input Screen (/phone_input)
- **Number Input Box**: Includes a dropdown for country code selection.
- **Next Button**: A button to navigate to the code verification page.
- **Error Display**: Snackbar or any error message display to indicate incorrect code input.

### Code Verification Screen (/phone_code_verification)
- **Information Text**: Displays the phone number that will receive the verification code, with a message such as "You'll receive a verification code on +91......".
- **Code Input Box**: An input field to enter the received code.
- **Verify Button**: A button to submit and verify the entered code.
- **Text Button**: A button to resend the verification code. This button will be disabled until the countdown is over.
- **Countdown Text**: Displays countdown in `MM:SS` format. For example, `01:22`.

### Find Match Screen (/find_match)
- **Header**
  - **Dating Preferences**: An icon to show the dating preferences page.
- **Find Match Button**: This button will have the following states:
  - **Enabled**: Button can be clicked to find a match.
  - **Disabled with Countdown**: Displays a countdown in `{0-9}{0-9}d HH:MM:SS` format. On click, it will show a message that the account is in cool down until the countdown is over. For example, `2d 10:22:3` or `5:22:00`.
  - **Disabled without Countdown**: On click, it will show a message informing the user why the button is disabled if not in a cool down period.
- **Message Display**: Snackbar or any message display.
- **Match Count Display**: Shows the number of matches left before the account enters the cool down period again.

## Splash Screen
- **Splash Screen**: Displays while loading the app's resources at the start. It can be an animation or a video suited to our app. Sites like Pexels provide good stock videos.

## Components

### Bottom Bar
Create a bottom bar to provide navigation to the following screens:
- /find_match
- /dating_rooms
- /chats
- /my_dating_rooms
- /profile