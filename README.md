# Flutter Security Client

Stupid simple Security Client for storing encrypted data locally.

## About

This project uses SQLite as the database for the encrypted keys and, for the encryption part, it uses the SQLCipher layer through the sqflite lib.

## Getting Started

An instance of SecurityClient can be created easily by passing just two params to its static constructor:

**Package isn't available through pub.dev yet.**

```dart
final SecurityClient securityClient = await SecurityClient.create("<db-name>", "<db-password>");

// e.g.
final SecurityClient securityClient = await SecurityClient.create("my-cool-database", "1234567890");
```

Multiple instances can be created at once since each client will use a separate database file for each one.

## API

For more information regarding all the available methods, the documentation can be found [here](https://htmlpreview.github.io/?https://github.com/bfpimentel/flutter-security/blob/chore/dart_docs/doc/api/index.html/index.html).

## Demo

The root of the repository contains a demonstration of SecurityClient's simplicity.

To run the demo, you **must** pass an environment variable called `GLOBAL_SECURITY_CLIENT_PASSWORD` with any text value.

The demo project is using Redux for state management.

## Contributing

The SecurityClient development files is located in the [security](security/) folder of this repository.

There aren't any special processes to this step, so to start contributing:
1. Have Flutter installed;
2. Clone the project;
3. Install the dependencies with `flutter pub get`.
