# Social Login App

Embark on a secure and user-friendly authentication journey with our Android Social Log-in App. Powered by Flutter and Firebase, it seamlessly integrates OAUTH 2.0 for Google and Facebook sign-ins, offering a versatile yet straightforward experience.

## Setup

1. Clone the repo using the command : `git clone https://github.com/aakash2khot/Social_Login.git`
2. Make sure that flutter is installed in your system, Android studio or any other editor is installed, Vscode for plugins (mostly to resolve dependencies and installations in pubsec.yml), mu development environment -- Flutter 3.16.2, Dart 3.2.2, openjdk version 16.0.1
3. One has to generate SHA keys, for secure authentication and communication, ensuring a trusted connection between the app and Firebase services. One can watch this video and follow for SHA keys: [Click Here!](https://www.youtube.com/watch?v=wGOTwojezy8)
4. Configure firebase for android, one can use [this link](https://firebase.google.com/docs/auth/flutter/start) for documentaion to get started. Note that google-services.json file in the android folder of the project file. In the same link, authentication docmentation is also given. One can use [this link](https://medium.com/flutter-community/flutter-implementing-google-sign-in-71888bca24ed) for article on google sign in implementation and follow [this link](https://www.youtube.com/watch?v=AG_hO03Vyto) for Facebook setup.
5. To install dependencies after cloning: `flutter pub get`
6. To run the app: `flutter run`
