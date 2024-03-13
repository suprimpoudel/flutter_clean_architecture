# Flutter Clean Architecture Theme using BLOC Pattern

This Flutter project serves as a theme for implementing Clean Architecture with the BLOC pattern. It aims to provide developers with a structured and organized approach to building Flutter applications, making it easier to maintain and scale their projects.

## Overview

Clean Architecture separates the concerns of an application into distinct layers, each with its own responsibility. The layers typically include Presentation, Domain, and Data layers, which promote separation of concerns and maintainability. The BLOC pattern complements Clean Architecture by handling the business logic and state management.

## Features

- Clean Architecture directory structure
- BLOC pattern for state management
- Separation of concerns for improved maintainability
- Easy-to-follow template for new projects

## Packages Used

- [flutter_bloc](https://pub.dev/packages/flutter_bloc): For implementing BLOC pattern in Flutter applications.
- [equatable](https://pub.dev/packages/equatable): For creating value equality for Dart objects.
- [get_it](https://pub.dev/packages/get_it): For dependency injection in Dart and Flutter projects.
- [dio](https://pub.dev/packages/dio): For making HTTP requests in Dart projects.
- [json_serializable](https://pub.dev/packages/json_serializable): For generating code for JSON serialization and deserialization.
- [build_runner](https://pub.dev/packages/build_runner): For generating code during the build process.
- [sqflite](https://pub.dev/packages/sqflite): For getting data from local storage.

## Plugins Used

To generate the Clean Architecture directories, we used the following plugin:

- [flutter_clean_architecture](https://plugins.jetbrains.com/plugin/13470-clean-architecture-for-flutter): A Flutter plugin for generating Clean Architecture directory structure automatically.

## Getting Started

To use this theme in your Flutter project, follow these steps:

1. Install Flutter if you haven't already. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
2. Create a new Flutter project.
3. Add the necessary dependencies to your `pubspec.yaml` file.
4. Use the flutter_clean_architecture plugin to generate the Clean Architecture directories.
5. Start building your application by following the Clean Architecture principles and utilizing the BLOC pattern.

## Structure

The project follows a structured directory layout based on Clean Architecture principles:

```
  data/
    data_sources/
    models/
    repositories/
  domain/
    entities/
    repositories/
    use_cases/
  presentation/
    manager/
    pages/
    widgets/
  utilities/
    constants/
    helpers/
```

## Contributions

Contributions to this project are welcome! If you have any suggestions, ideas, or improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.