# basalt

A new Flutter project.

### Source code of the basalt app for Android and IOS

[Source code](https://github.com/sylensa/basalt.git)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Tech Stack

Listed below are the tech stack used in the flutter application:

- [Rest Apis](http://api.marketstack.com/v1) - This provides the necessary endpoints for fetching data etc.
- Provider Architecture - Used for state management

## Running The App

#### `NB: This app is in null-safety. Therefore, to run the app with no dependency conflicts and issues, you need to install flutter sdk version between '>=2.18.1 <3.0.0' to run the app.`

.

##### Steps

1. Clone the repo
   With ssh

    ```sh
    git@github.com:sylensa/basalt.git
    ```

   With https

    ```sh
    https://github.com/sylensa/basalt.git
    ```

#### `NB: The most up to date branch is master`

2. Run: `flutter pub get` to get the packages and dependencies setup/installed
3. Run the app using `flutter run lib/main.dart` to run the app.

Useful Resources:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Flutter online documentation](https://flutter.dev/docs) - which offers tutorials,
  samples, guidance on mobile development, and a full API reference.

### Code Architecture

This codebase uses some 'form' of clean architecture which separates the three main layers namely:

1. The Model  - Usually made up of Api response classes models
2. The Controller - Implementation of the model and api calls
3. The View/UI - Business logic, UI widgets, integrations etc.


| Folder Name | Description |
| ----- | ------ |
| assets | Contains all assets used in the app. Assets can be grouped into fonts, images, icons etc.|
| android | Contains android specific files and configurations |
| ios | Contains ios specific files and configurations |
| lib | This is the main folder which usually contains shared code used on multiple platforms. Expanding further, lib contains the folders listed below:|

[` lib `](/lib)  Folder structure
| Folder Name | Description |
| ----- | ------ |
| Helper | Contains all configurations like button styles, text styles, global color declarations, enums, constants etc. used in the app.|
| Model | Usually made up of Api response classes models. used in the app.|
| View | UI widgets, integrations etc. used in the app|
| Controller | Implementation of the model and api calls and Business logic. used in the app.|
