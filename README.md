# musikano

A classical Indian music practice companion — digital instruments (Tabla, Tanpura, Swar Mandal, Manjeera) that sync around rhythmic cycles called **taals**.


# Music Learning App

A music learning app I made for a friend. Inspired by other paid apps but made it free.

## Why?

My friend wanted to learn music but didn't want to pay for expensive apps. So I tried to replicate those apps and make something that works. Got some help from AI assisted coding agents like opencode.

## What it does

- Learn music notes
- Practice exercises
- Basic music theory
- Simple interactive lessons

## Built with

- Flutter
- Dart
- just_audio (for sounds)
- 



## Project structure

```
lib/
  main.dart                          # Entry point → ProviderScope → MusikanoApp
  app.dart                           # MaterialApp.router with themed routing
  core/
    theme/                           # AppColors ThemeExtension, light/dark themes
    router/app_router.dart           # GoRouter with slide transitions (/, /taal/:id, /settings, /premium)
    audio/audio_engine.dart          # just_audio wrapper singleton
    constants/                       # AppStrings, taal seed data
    widgets/                         # Reusable UI components
  domain/
    models/                          # Taal, InstrumentConfig, AppSettings
    repositories/                    # Abstract repository interfaces
  data/
    repositories/                    # Concrete implementations (seed data, SharedPreferences)
  features/
    taal_list/presentation/          # Taal list with search, tabs, favourites
    taal_detail/presentation/        # Practice screen with instruments
    settings/presentation/           # App settings with persistence
    premium/presentation/            # Coming-soon placeholder
  providers/                         # Riverpod providers (@riverpod → codegen)
```

## How to add new taals

Add a `Taal` entry in `lib/data/repositories/taal_repository_impl.dart`:

```dart
Taal(id: 'my_taal', name: 'My Taal', beatCount: 8, bol: 'Dha Dha Ghe Na', variationCount: 1),
```

## How to add new instrument patterns

1. Place audio files in `assets/audio/{instrument}/`.
2. Update the instrument card's pattern selector logic to serve the new pattern names.
3. Register the asset path in `AudioEngine` when real audio is ready.

## How to swap in real audio files

Replace the placeholder MP3s under `assets/audio/` with real WAV/OGG loops. Update `AudioEngine` to load from the correct asset paths. See TODOs in `lib/core/audio/audio_engine.dart`.

## Developer commands

| Command | Purpose |
|---|---|
| `flutter run` | Run on device/emulator |
| `flutter analyze` | Static analysis |
| `dart format .` | Format all Dart code |
| `dart run build_runner build` | Regenerate `.g.dart` files after `@riverpod` edits |
| `flutter test` | Run tests |
