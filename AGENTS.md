# musikano — Agent guide

Flutter 3.29.2 / Dart 3.7.2 app: "Classical Indian Music Practice Companion".

## Dev commands

| Command | Purpose |
|---|---|
| `flutter run` | Run on device/emulator |
| `flutter run -d chrome` | Run as web app |
| `flutter analyze` | Static analysis (currently 0 errors) |
| `dart format .` | Format all Dart code |
| `dart run build_runner build --delete-conflicting-outputs` | Regenerate `*.g.dart` (riverpod_generator) |
| `dart run build_runner watch` | Watch mode for codegen |
| `flutter test` | Run tests (currently 0 exist) |
| `flutter build web --no-tree-shake-icons` | Build web (fastest build for validation) |

Always run build_runner after editing any `@riverpod`-annotated provider. Generated `.g.dart` files are **not** committed.

## Architecture

- **Clean Architecture:** `domain/` (models + abstract repos), `data/` (repo implementations), `features/` (presentation).
- **State management:** Riverpod 2 with `riverpod_annotation` (`@riverpod` → codegen). Providers in `lib/providers/` + co-located under `features/`.
- **Routing:** `go_router` in `lib/core/router/app_router.dart`. Routes: `/` (list), `/taal/:id` (detail), `/settings`, `/premium`. Slide transitions via `CustomTransitionPage`.
- **Entrypoint:** `lib/main.dart` → `ProviderScope` → `MusikanoApp` (`lib/app.dart`).
- **Theme:** Material 3 with custom `AppColors` ThemeExtension in `lib/core/theme/`. ThemeMode from settings provider (system/light/dark).
- **Audio:** `just_audio` singleton in `lib/core/audio/audio_engine.dart` — real engine with play/stop, volume, speed, mute, beat pulse streams, sync start. Placeholder MP3s in `assets/audio/`.
- **Assets:** Audio MP3s under `assets/audio/{tabla,tanpura,swar_mandal}/`.

## Current project state

- **Tests:** None exist (`test/` is empty).
- **`flutter analyze` passes** with 0 errors, 0 warnings, 3 info-level deprecation notices.
- **Audio engine:** Placeholder-only; most methods are TODOs.
- **No CI, no pre-commit hooks, no git repo.**

## Conventions

- `flutter_lints ^5.0.0` — inherits `package:flutter_lints/flutter.yaml`.
- Feature-first layout: `lib/features/{feature}/presentation/{screen, widgets/}`.
- Common widgets in `lib/core/widgets/`.
- All user-facing strings in `lib/core/constants/strings.dart`.
- `const` constructors everywhere possible.
- No business logic in UI layer; use repository pattern.

## Known caveats

- Import paths break easily when moving files — verify relative imports after refactors.
- Always regenerate codegen after provider edits: `dart run build_runner build --delete-conflicting-outputs`.
- The `android/app/build.gradle.kts` release build uses **debug signing** — change before shipping.
- Riverpod 3.x will remove `AllTaalsRef`/`AppSettingsRef`/etc. in favor of `Ref` — migrate when upgrading.
