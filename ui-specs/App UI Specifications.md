# UI Specification Document

This document outlines the UI specifications for our app, serving as a guide for the UI designer in developing the app's user interface.

## Authentication Screens

### Phone Number Input Screen (/auth/phone)
- **Number Input Box**: Includes a dropdown for country code selection.
- **Next Button**: A button to navigate to the code verification page.
- **Error Display**: A snackbar or any error message display to indicate incorrect code input.

### Code Verification Screen (/auth/phone/code_verification)
- **Information Text**: Displays the phone number that will receive the verification code, with a message such as "You'll receive a verification code on +91......".
- **Code Input Box**: An input field to enter the received code.
- **Verify Button**: A button to submit and verify the entered code.
- **Text Button**: A button to resend the verification code. This button will be disabled until the countdown is over.
- **Countdown Text**: Displays countdown in `MM:SS` format. For example, `01:22`.

## Match Screens

### Find Match Screen (/match/find)
- **Header**
  - **Dating Preferences**: An icon to show the dating preferences page.
- **Find Match Button**: This button will have the following states:
  - **Enabled**: Button can be clicked to find a match.
  - **Disabled with Countdown**: Displays a countdown in `{0-9}{0-9}d HH:MM:SS` format. On click, it will show a message that the account is in cooldown until the countdown is over. For example, `2d 10:22:3` or `5:22:00`.
  - **Disabled without Countdown**: On click, it will show a message informing the user why the button is disabled if not in a cooldown period.
- **Message Display**: A snackbar or any message display.
- **Match Count Display**: Shows the number of matches left before the account enters the cooldown period again.

### Dating Preferences Screen (/match/preferences)
Take inspiration from Hinge's dating preferences page.

#### Dating Attributes
- **Age Range**: Slider-based age range selector (similar to Hinge's age range selector).
- **Location**: User dating location selector (similar to Hinge's neighborhood selector).
- **Minimum Height**: Set the minimum height required for the date.
- **Interested Gender**: Gender the user wants to date. Gender should be inclusive for catering LGBTQ+ community along with heterosexuals. Take inspiration from more in-depth gender selection in Gender identity in hinge. A user can select upto 3 genders.
- **Dating Intentions**:
  - Short term
  - Long term
  - Short term but open to long term
  - Long term but open to short term
- **Body Type**: This will be a multi-select option.
  - For females, we will show male body types:
    - Athletic/Muscular
    - Lean
    - Normal
    - Tall and Slim
    - Plus
    - Bodybuilder
  - For males, we will show female body types:
    - Thin

## Account Screens

### My Account Screen (/account)
Take inspiration from Hinge's My Profile option.
- **Blocked Users**: Option to block users through phone number to prevent accidentally getting matched with known users like family members.

### Edit Profile Screen (/account/profile/edit)
- **Update Profile Button**: Button to show updated profile.
- **Add/Remove/Update Photo/Video**: Up to 9 photos/videos.
- **Select Profile Picture**: Image selection.
- **Edit Biography**
- **Select Interested Tags**: Maximum 10 tags, inspired by Bumble.
- **Add/Remove Prompts**: Inspired by Hinge. Prompts will be predefined, and the user will write answers for them.
- **Select attributes**: Select Pronouns, Gender, Sexuality, Interested Gender, Name, Age, Height, Location, Work, Job Title, College, Education Level, Religion, Hometown, Dating Intentions, and Other Dating Attributes, Take inspiration from Hinge.


### View Profile Screen (/account/profile)
Hinge's profile is the ideal inspiration for design.
- **Display Only Certain Attributes**: 
  - Dating intentions
  - Location

### Settings Screen (/account/settings)
- **Help & Contact Us**
- **Log Out**

## Chat Screens

### Chats Screen (/chats)
- **Chat List**: Similar to WhatsApp, with profile picture, name, latest message, a bubble indicating unread messages, and last message time.

### Chat Screen (/chats/chat)
- **Tabs**: For viewing chats and the profile of the user.
- **Profile Exposure Option**: If the profile is not exposed, only non-photo/video contents will be shown. Option to expose profile images.
- **Breakup Option**
- **Chat Block**: After 3 days, the chat will be blocked.
  - **Input Option**: Removed.
  - **Prompt**: A message at the bottom of the chat with two buttons: Breakup and Move Forward.
  - **Move Forward Dialog**: A message stating "Moving forward will drop all ongoing matches on each user's side."
  - **Countdown**: 1-day countdown to choose, otherwise it will automatically break up.

## Dating Room Screens

### Dating Rooms Search Screen (/rooms/search)
- **Header**
  - **Location Selector Icon**: To select location and show current location.
  - **QR Scanner**
- **Search Box**
- **Dating Room Cards**: On click, move to room screen.
  - **Banner Image**
  - **Room Name**
  - **Room Time Period**: (Start - End), end is optional.
  - **Location**: Can also be the distance of the dating room from the selected location.
  - **Number of Users Present**
  - **Ratings**
  - **Join Room Button**: On click, show an input box either in bottom sheet or dialog for accepting the entry code.

### About Dating Room Screen (/rooms/room)
- **Header**
  - **QR Code Button**: If the user has joined the room.
  - **Share Link Button**
- **Image Carousel**
- **Details from Dating Room Card**
- **Room Details**: Long text, T&C, Dos and Don'ts.
- **Ratings**

### Dating Room Find Match Screen (/rooms/room/match)
- **Header**
  - **Room Name**
  - **Open Room Screen Button**
- **Matches**: Similar to Hinge.

### My Dating Rooms Screen (/rooms/my)
- **My Dating Room Cards**
  - **All Details from Dating Room Card**
  - **Rate Room Button**: If rated, show rating.
  - **Room Click**: User will go to `/rooms/room/match` screen.

This detailed UI specification should guide the UI designer in developing the user interface of our app effectively.

## Components
### Bottom bar
Icon to navigate to these screens.
* /match/find
* /rooms/search
* /rooms/my
* /chats
* /account

### Gender selection
The dating app's gender selection process aims to be inclusive while maintaining a user-friendly interface. Genders are organized hierarchically under umbrella terms to avoid overwhelming users and to ensure a smooth experience for all, including heterosexual users and those uninterested in gender variations. Users can choose their own gender and the genders they are interested in, with options to expand their selections if desired.

#### Own Gender Selection

##### Default View:

* Display three umbrella terms: Male, Female, Non-binary.
* If any gender is selected from expanded view which is not in the three umbrella terms, then gender will be shown with selected highlight.
* A single text button labeled "See All Genders" will be present, allowing users to view and select from all available genders.

##### Expanded View:

* Clicking "See All Genders" or an umbrella term will reveal a list of sub-genders under each term.
* Users can select one gender from the expanded list.


#### Interested Genders Selection
##### Default View:

* Display three default genders: Male, Female, Non-binary.
* If any gender is selected from expanded view which is not in the three umbrella terms, then genders will be shown with selected highlight.
* A text button labeled "See More Genders" will be present, allowing users to view and select from all available genders.
##### Expanded View:

* Clicking "See More Genders" or an umbrella term will reveal a list of sub-genders under each term.
* Users can select up to three genders from the expanded list.