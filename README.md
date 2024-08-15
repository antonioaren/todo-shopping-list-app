# todo_shopping_list_app

## Why I am doing this

This is an application to learn how Flutter works and also to understand what should be the best arquitecture. As bigger is the app, more important is the arquitecture you follow. I will do a presentation discussing about what we should do if we use this to develop. This example has started as a counter, then I add a feat to retreave a random word and so on. All of this if for understanding but the aim of this is to create a shopping list where you can share with your family and have a real time feedback about what has been bought by other person in your family group.

(I will improve this readme.)

## Arquitecture

I will like to try this:

```bash
lib/
├── core/
│   ├── utils/            # Utility classes/functions (e.g., constants, helpers)
│   └── exceptions/       # Custom exceptions
├── data/
│   ├── models/           # Data models
│   ├── repositories/     # Data repository interfaces and implementations
│   ├── data_sources/     # Remote and local data sources (APIs, databases)
│   └── services/         # External services (e.g., network service)
├── domain/
│   ├── entities/         # Business entities (core models)
│   ├── use_cases/        # Business logic use cases
│   └── repositories/     # Abstract repository interfaces
├── presentation/
│   ├── screens/          # Screens (UI)
│   ├── widgets/          # Reusable widgets
│   ├── blocs/            # BLoCs, Cubits, or StateNotifiers
│   ├── providers/        # Providers for state management
│   └── routes/           # Route management
└── main.dart             # Entry point of the application
```

## About Flutter

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
