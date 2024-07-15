# Authentication

## PhoneAuthenticationActivity
```dart
enum PhoneAuthenticationVisibleInputScreen {
    PhoneNumberInputScreen,
    CodeInputScreen
}

class PhoneAuthenticationActivity extends StatefulWidget {

    String? _phoneNumber;
    String? _verificationId;


    Future<void> _signInWithVerificationId(String verificationId) async {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode); 

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
        
    }

    Future<void> sendIdTokenForLoginOnBackend(User? user) async {
        if (user != null) {
            String idToken = await user.getIdToken();
            
        }
    }


}
```

## Phone number Input
- Firebase phone authentication system
- No backend connection
- Validate phone number format. Firebase accepts phone number with country code.
- Moves to code verification screen on next click.



#### OnNext Click
- Firebase phone authentication function will be called to send the code for verification.

```dart
await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: '+44 7123 123 456',
  verificationCompleted: (PhoneAuthCredential credential) {
    // emt
  },
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: (String verificationId, int? resendToken) {
    // Show code verification page.
  },
  codeAutoRetrievalTimeout: (String verificationId) {},
);
```


## Code verification

- Button `Verify Code`


## Firebase phone auth module

### verifyPhoneNumber

#### Arguments
- **phoneNumber**
- **verificationCompleted**: Callback to trigger post successful authentication functions. `NOTE: callback will be triggered by auto otp capturing system. In-case we implement custom otp verification this callback will not run`.
- **verificationFailed**: Callback for handling authentication errors. Similar to verificationCompleted, manual signIn will not trigger the callback.
- **codeSent**: Callback function triggered when the verification code has been sent. Provides "PhoneAuthCredential" and "resendToken". 
- **codeAutoRetrievalTimeout**: Callback function triggered when the automatic sms code retrieval times out. VerificationId that can still be used to manually verify the code.

#### codeSent
- Show OTP screen 

```dart
// Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode); 

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
```

```dart



enum InitializationScreen {
    SplashScreen,
    AuthenticationScreen,
    HomeScreen
}

class InitializationChangeNotifier extends ChangeNotifier {

}
```