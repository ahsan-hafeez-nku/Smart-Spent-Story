# Smart Spent Story

> A production-grade personal finance management application built with **Flutter**, following **Clean Architecture** and **BLoC** state management.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Tech Stack](#2-tech-stack)
3. [Clean Architecture Explanation](#3-clean-architecture-explanation)
4. [Complete Project Folder Structure](#4-complete-project-folder-structure)
5. [Core Layer Explanation](#5-core-layer-explanation)
6. [Feature Module Architecture](#6-feature-module-architecture)
7. [BLoC Pattern Guide](#7-bloc-pattern-guide)
8. [Model and Entity Guidelines](#8-model-and-entity-guidelines)
9. [Dependency Injection Setup](#9-dependency-injection-setup)
10. [Navigation Architecture](#10-navigation-architecture)
11. [API Layer Architecture](#11-api-layer-architecture)
12. [Utility Layer](#12-utility-layer)
13. [Extensions Layer](#13-extensions-layer)
14. [Theme System](#14-theme-system)
15. [Example Feature Implementation](#15-example-feature-implementation)
16. [Development Workflow](#16-development-workflow)
17. [Best Practices](#17-best-practices)
18. [Recommended Packages](#18-recommended-packages)
19. [Coding Standards](#19-coding-standards)
20. [Scalability Strategy](#20-scalability-strategy)

---

## 1. Project Overview

### Purpose

**Smart Spent Story** is a modern personal finance tracker that empowers users to take control of their spending habits. The app provides a seamless experience for logging income and expenses, categorizing transactions, tracking budgets, viewing analytics, managing upcoming bills, and receiving AI-powered financial insights — all in a beautifully crafted mobile interface.

### Main Features

| Feature               | Description                                                                                                                                                                                                                                               |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Onboarding**        | Multi-step walkthrough introducing the app ("Track Every Penny")                                                                                                                                                                                          |
| **Authentication**    | Sign-up, sign-in, and session management                                                                                                                                                                                                                  |
| **Dashboard**         | Central hub displaying total balance, income/expense summaries, AI insights, spending breakdown by category, upcoming bills, and recent transactions                                                                                                      |
| **Add Transaction**   | Expense/Income toggle with custom numpad for amount entry, category selection, and notes                                                                                                                                                                  |
| **Analytics**         | Average monthly income/expenses with trend percentages, income vs. expenses chart, spending by category donut/bar chart, and savings trend line chart                                                                                                     |
| **Profile**           | User information, premium membership badge, lifetime stats (months tracked, transactions, money saved), personal information management, notification preferences, linked bank accounts, security settings (PIN/biometrics), help & support, and sign-out |
| **Upcoming Bills**    | List of recurring bills with amounts and due dates (rent, electricity, internet)                                                                                                                                                                          |
| **AI Insights**       | Intelligent spending alerts ("You spent 35% more on dining") and positive reinforcement ("Savings up 12%")                                                                                                                                                |
| **Categories**        | Housing, Food, Transport, Entertainment, Health, Other                                                                                                                                                                                                    |
| **Bottom Navigation** | Persistent tab bar: Dashboard, Analytics, Add Transaction, Budgets, Profile                                                                                                                                                                               |

### User Flow

```
┌─────────────┐     ┌──────────────┐     ┌───────────────┐
│  Splash /   │────▶│  Onboarding  │────▶│ Authentication│
│  App Start  │     │  (3 steps)   │     │ (Login/SignUp)│
└─────────────┘     └──────────────┘     └───────┬───────┘
                                                  │
                                                  ▼
                                        ┌─────────────────┐
                                        │    Dashboard     │
                                        │  (Main Screen)   │
                                        └────────┬────────┘
                                                 │
                    ┌────────────┬───────────────┼───────────────┬──────────┐
                    ▼            ▼               ▼               ▼          ▼
              ┌──────────┐ ┌──────────┐ ┌──────────────┐ ┌──────────┐ ┌────────┐
              │Analytics │ │  Budget  │ │Add Transaction│ │  Bills   │ │Profile │
              └──────────┘ └──────────┘ └──────────────┘ └──────────┘ └────────┘
```

---

## 2. Tech Stack

| Technology               | Purpose                                                 | Package                               |
| ------------------------ | ------------------------------------------------------- | ------------------------------------- |
| **Flutter**              | Cross-platform UI framework                             | `flutter`                             |
| **flutter_bloc**         | State management (BLoC pattern)                         | `flutter_bloc`                        |
| **Equatable**            | Value equality for entities, models, states, and events | `equatable`                           |
| **Dio**                  | HTTP client for API communication                       | `dio`                                 |
| **GetIt**                | Service locator for dependency injection                | `get_it`                              |
| **injectable**           | Code generation for DI annotations                      | `injectable` + `injectable_generator` |
| **GoRouter**             | Declarative routing and navigation                      | `go_router`                           |
| **Hive**                 | Lightweight, fast local NoSQL storage                   | `hive` + `hive_flutter`               |
| **SharedPreferences**    | Simple key-value persistent storage                     | `shared_preferences`                  |
| **dartz**                | Functional programming (Either type for error handling) | `dartz`                               |
| **fl_chart**             | Beautiful chart rendering (line, bar, pie)              | `fl_chart`                            |
| **intl**                 | Internationalization, date/currency formatting          | `intl`                                |
| **cached_network_image** | Image caching and loading                               | `cached_network_image`                |
| **flutter_svg**          | SVG asset rendering                                     | `flutter_svg`                         |
| **google_fonts**         | Custom typography                                       | `google_fonts`                        |
| **flutter_screenutil**   | Responsive design and scaling                           | `flutter_screenutil`                  |
| **logger**               | Pretty console logging                                  | `logger`                              |

---

## 3. Clean Architecture Explanation

Clean Architecture enforces a strict separation of concerns across three concentric layers. Each layer depends only inward — never outward.

```
┌───────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                      │
│  ┌──────────────────────────────────────────────────────┐ │
│  │   Pages / Widgets / BLoC (Events, States, Bloc)      │ │
│  └──────────────────────┬───────────────────────────────┘ │
│                         │ depends on                       │
│  ┌──────────────────────▼───────────────────────────────┐ │
│  │                   DOMAIN LAYER                        │ │
│  │   Entities / Repository Contracts / Use Cases         │ │
│  └──────────────────────┬───────────────────────────────┘ │
│                         │ depends on                       │
│  ┌──────────────────────▼───────────────────────────────┐ │
│  │                    DATA LAYER                         │ │
│  │   Models / Data Sources / Repository Implementations  │ │
│  └──────────────────────────────────────────────────────┘ │
└───────────────────────────────────────────────────────────┘
```

### Presentation Layer

Responsible for UI rendering and user interaction. Contains **Pages** (full screens), **Widgets** (reusable UI components), and **BLoC** classes (business logic). This layer dispatches events to the BLoC and reacts to state changes by rebuilding the UI.

### Domain Layer

The heart of the application. Contains **Entities** (pure business objects), **Repository abstractions** (interfaces/contracts), and **Use Cases** (single-responsibility business rules). This layer has **zero dependencies** on Flutter, external packages, or any other layer — it is pure Dart.

### Data Layer

Handles data retrieval and persistence. Contains **Models** (serializable data objects that extend entities), **Data Sources** (remote API calls and local database operations), and **Repository Implementations** (concrete implementations of domain repository contracts that coordinate between data sources).

### Dependency Rule

> **Inner layers never know about outer layers.**
>
> - Domain does NOT import from Data or Presentation.
> - Data depends on Domain (implements repository contracts).
> - Presentation depends on Domain (uses entities and use cases).

---

## 4. Complete Project Folder Structure

```
lib/
│
├── core/
│   ├── configs/
│   │   ├── app_config.dart
│   │   └── env_config.dart
│   │
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_fonts.dart
│   │   ├── app_strings.dart
│   │   ├── app_assets.dart
│   │   ├── app_spacing.dart
│   │   └── api_constants.dart
│   │
│   ├── extensions/
│   │   ├── context_extensions.dart
│   │   ├── string_extensions.dart
│   │   ├── datetime_extensions.dart
│   │   ├── num_extensions.dart
│   │   └── widget_extensions.dart
│   │
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   ├── debouncer.dart
│   │   ├── logger.dart
│   │   └── typedefs.dart
│   │
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── api_endpoints.dart
│   │   ├── dio_provider.dart
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart
│   │       ├── logging_interceptor.dart
│   │       └── error_interceptor.dart
│   │
│   ├── error/
│   │   ├── failures.dart
│   │   └── exceptions.dart
│   │
│   ├── usecase/
│   │   └── usecase.dart
│   │
│   └── dependency_injection/
│       ├── service_locator.dart
│       ├── auth_injection.dart
│       ├── dashboard_injection.dart
│       ├── transaction_injection.dart
│       ├── analytics_injection.dart
│       └── profile_injection.dart
│
├── features/
│   ├── splash/
│   │   └── presentation/
│   │       └── pages/
│   │           └── splash_page.dart
│   │
│   ├── onboarding/
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── onboarding_bloc.dart
│   │       │   ├── onboarding_event.dart
│   │       │   └── onboarding_state.dart
│   │       ├── pages/
│   │       │   └── onboarding_page.dart
│   │       └── widgets/
│   │           ├── onboarding_step_widget.dart
│   │           └── onboarding_indicator.dart
│   │
│   ├── authentication/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── auth_response_model.dart
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   └── auth_local_datasource.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       ├── register_usecase.dart
│   │   │       ├── logout_usecase.dart
│   │   │       └── get_cached_user_usecase.dart
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── register_page.dart
│   │       └── widgets/
│   │           ├── auth_text_field.dart
│   │           └── social_login_button.dart
│   │
│   ├── dashboard/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── balance_model.dart
│   │   │   │   ├── spending_category_model.dart
│   │   │   │   ├── upcoming_bill_model.dart
│   │   │   │   └── ai_insight_model.dart
│   │   │   ├── datasources/
│   │   │   │   ├── dashboard_remote_datasource.dart
│   │   │   │   └── dashboard_local_datasource.dart
│   │   │   └── repositories/
│   │   │       └── dashboard_repository_impl.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── balance_entity.dart
│   │   │   │   ├── spending_category_entity.dart
│   │   │   │   ├── upcoming_bill_entity.dart
│   │   │   │   └── ai_insight_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── dashboard_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_balance_usecase.dart
│   │   │       ├── get_spending_categories_usecase.dart
│   │   │       ├── get_upcoming_bills_usecase.dart
│   │   │       └── get_ai_insights_usecase.dart
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── dashboard_bloc.dart
│   │       │   ├── dashboard_event.dart
│   │       │   └── dashboard_state.dart
│   │       ├── pages/
│   │       │   └── dashboard_page.dart
│   │       └── widgets/
│   │           ├── balance_card.dart
│   │           ├── ai_insights_card.dart
│   │           ├── spending_category_list.dart
│   │           ├── upcoming_bills_card.dart
│   │           └── recent_transactions_list.dart
│   │
│   ├── transaction/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── transaction_model.dart
│   │   │   ├── datasources/
│   │   │   │   ├── transaction_remote_datasource.dart
│   │   │   │   └── transaction_local_datasource.dart
│   │   │   └── repositories/
│   │   │       └── transaction_repository_impl.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── transaction_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── transaction_repository.dart
│   │   │   └── usecases/
│   │   │       ├── add_transaction_usecase.dart
│   │   │       ├── get_transactions_usecase.dart
│   │   │       ├── delete_transaction_usecase.dart
│   │   │       └── update_transaction_usecase.dart
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── transaction_bloc.dart
│   │       │   ├── transaction_event.dart
│   │       │   └── transaction_state.dart
│   │       ├── pages/
│   │       │   ├── add_transaction_page.dart
│   │       │   └── transaction_list_page.dart
│   │       └── widgets/
│   │           ├── amount_input_pad.dart
│   │           ├── category_selector.dart
│   │           ├── transaction_type_toggle.dart
│   │           └── transaction_tile.dart
│   │
│   ├── analytics/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── analytics_summary_model.dart
│   │   │   │   ├── category_spending_model.dart
│   │   │   │   └── savings_trend_model.dart
│   │   │   ├── datasources/
│   │   │   │   └── analytics_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── analytics_repository_impl.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── analytics_summary_entity.dart
│   │   │   │   ├── category_spending_entity.dart
│   │   │   │   └── savings_trend_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── analytics_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_analytics_summary_usecase.dart
│   │   │       ├── get_category_spending_usecase.dart
│   │   │       └── get_savings_trend_usecase.dart
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── analytics_bloc.dart
│   │       │   ├── analytics_event.dart
│   │       │   └── analytics_state.dart
│   │       ├── pages/
│   │       │   └── analytics_page.dart
│   │       └── widgets/
│   │           ├── income_expense_chart.dart
│   │           ├── category_spending_chart.dart
│   │           ├── savings_trend_chart.dart
│   │           └── summary_stat_card.dart
│   │
│   └── profile/
│       ├── data/
│       │   ├── models/
│       │   │   └── profile_model.dart
│       │   ├── datasources/
│       │   │   ├── profile_remote_datasource.dart
│       │   │   └── profile_local_datasource.dart
│       │   └── repositories/
│       │       └── profile_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── profile_entity.dart
│       │   ├── repositories/
│       │   │   └── profile_repository.dart
│       │   └── usecases/
│       │       ├── get_profile_usecase.dart
│       │       └── update_profile_usecase.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── profile_bloc.dart
│           │   ├── profile_event.dart
│           │   └── profile_state.dart
│           ├── pages/
│           │   ├── profile_page.dart
│           │   ├── personal_info_page.dart
│           │   ├── notification_settings_page.dart
│           │   ├── bank_accounts_page.dart
│           │   ├── security_page.dart
│           │   └── help_support_page.dart
│           └── widgets/
│               ├── profile_header.dart
│               ├── profile_stats_row.dart
│               └── profile_menu_item.dart
│
├── shared/
│   ├── widgets/
│   │   ├── custom_button.dart
│   │   ├── custom_text_field.dart
│   │   ├── loading_indicator.dart
│   │   ├── error_widget.dart
│   │   ├── empty_state_widget.dart
│   │   └── shimmer_loading.dart
│   │
│   └── components/
│       ├── bottom_nav_bar.dart
│       ├── app_bar_widget.dart
│       └── category_icon.dart
│
├── routes/
│   ├── app_router.dart
│   └── route_names.dart
│
├── main.dart
│
└── app.dart
```

---

## 5. Core Layer Explanation

The `core/` directory contains all cross-cutting, feature-agnostic code shared across the entire application.

### `configs/`

Application-level configuration including environment toggling (development, staging, production), base URLs, and feature flags.

```dart
// lib/core/configs/env_config.dart
enum Environment { development, staging, production }

class EnvConfig {
  final Environment environment;
  final String baseUrl;
  final String apiKey;

  const EnvConfig({
    required this.environment,
    required this.baseUrl,
    required this.apiKey,
  });

  static const EnvConfig development = EnvConfig(
    environment: Environment.development,
    baseUrl: 'https://dev-api.smartspent.com/v1',
    apiKey: 'dev-api-key',
  );

  static const EnvConfig production = EnvConfig(
    environment: Environment.production,
    baseUrl: 'https://api.smartspent.com/v1',
    apiKey: 'prod-api-key',
  );

  bool get isDevelopment => environment == Environment.development;
}
```

### `constants/`

Centralized constants for colors, fonts, spacing, strings, and asset paths. Any magic value used in more than one place lives here.

```dart
// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF03DAC5);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFE53935);
  static const Color income = Color(0xFF4CAF50);
  static const Color expense = Color(0xFFE53935);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
}
```

### `extensions/`

Dart extension methods on core types (`BuildContext`, `String`, `DateTime`, `num`) to reduce boilerplate and improve readability throughout the codebase.

### `utils/`

Stateless helper functions and classes — validators (email, password, amount), currency/date formatters, a debouncer for search input, a logger wrapper, and common typedefs.

### `network/`

Complete Dio HTTP setup including the base `ApiClient`, endpoint constants, a `DioProvider` factory, and interceptors for authentication token injection, request/response logging, and global error transformation.

### `error/`

A unified error handling strategy. `Failures` are domain-level error representations (used with `Either` from dartz). `Exceptions` are data-level errors thrown by data sources and caught by repositories.

```dart
// lib/core/error/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
```

```dart
// lib/core/error/exceptions.dart
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});
}
```

### `dependency_injection/`

GetIt service locator setup. The main `service_locator.dart` file initializes all feature-specific injections. Each feature has its own injection file to keep registration modular.

### `usecase/`

The base `UseCase` abstract class that all use cases implement.

```dart
// lib/core/usecase/usecase.dart
import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
```

---

## 6. Feature Module Architecture

Each feature is self-contained and follows the same three-layer structure. This guarantees consistency, testability, and the ability to develop features in parallel.

### `data/`

The outermost layer of a feature. Knows about the external world (APIs, databases, caches).

| Component           | Responsibility                                                                                                                                                                                |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`models/`**       | Data transfer objects (DTOs) that extend domain entities. Include `fromJson()`, `toJson()`, and `toEntity()` methods for serialization.                                                       |
| **`datasources/`**  | Interface and implementation for remote (API) and local (Hive/SharedPreferences) data access.                                                                                                 |
| **`repositories/`** | Concrete implementations of domain repository contracts. Coordinates between remote and local data sources, handles caching strategy, and transforms exceptions into failures using `Either`. |

### `domain/`

The innermost layer. Pure Dart — no Flutter imports, no package dependencies beyond `equatable` and `dartz`.

| Component           | Responsibility                                                                                                        |
| ------------------- | --------------------------------------------------------------------------------------------------------------------- |
| **`entities/`**     | Core business objects. Extend `Equatable` for value equality. Contain only fields and no logic beyond getters.        |
| **`repositories/`** | Abstract classes (contracts) defining data operations the domain expects.                                             |
| **`usecases/`**     | Single-responsibility classes representing one business action. Accept parameters and return `Either<Failure, Type>`. |

### `presentation/`

The UI layer. Depends on the domain layer via BLoC.

| Component      | Responsibility                                                                                                             |
| -------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **`bloc/`**    | Contains the BLoC class, its events, and its states. Receives events from the UI, invokes use cases, and emits new states. |
| **`pages/`**   | Full-screen widgets representing a route. Use `BlocProvider` and `BlocBuilder`/`BlocListener`.                             |
| **`widgets/`** | Smaller, reusable UI components specific to the feature.                                                                   |

---

## 7. BLoC Pattern Guide

### Structure

Every BLoC consists of exactly three files:

```
feature/
  presentation/
    bloc/
      feature_bloc.dart    ← BLoC class
      feature_event.dart   ← Events (inputs)
      feature_state.dart   ← States (outputs)
```

### Events

Events represent user actions or system triggers. They are **immutable** and extend `Equatable`.

```dart
// lib/features/authentication/presentation/bloc/auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthRegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthCheckStatusRequested extends AuthEvent {
  const AuthCheckStatusRequested();
}
```

### States

States represent the UI output. They are **immutable** and extend `Equatable`. Use a sealed class or distinct subclasses to represent each possible state.

```dart
// lib/features/authentication/presentation/bloc/auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
```

### BLoC

The BLoC class maps events to states using `on<Event>` handlers. It depends only on use cases (injected via constructor).

```dart
// lib/features/authentication/presentation/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_spent_story/features/authentication/domain/usecases/login_usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/usecases/register_usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/usecases/get_cached_user_usecase.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCachedUserUseCase getCachedUserUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _getCachedUserUseCase = getCachedUserUseCase,
        super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatusRequested>(_onCheckStatus);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _registerUseCase(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _logoutUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onCheckStatus(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _getCachedUserUseCase(const NoParams());

    result.fold(
      (_) => emit(const AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }
}
```

### BLoC Usage in UI

```dart
// In a page widget
BlocProvider(
  create: (_) => sl<AuthBloc>()..add(const AuthCheckStatusRequested()),
  child: BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthAuthenticated) {
        context.go(RouteNames.dashboard);
      }
      if (state is AuthFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
    builder: (context, state) {
      if (state is AuthLoading) {
        return const LoadingIndicator();
      }
      return const LoginForm();
    },
  ),
);
```

---

## 8. Model and Entity Guidelines

### Entity (Domain Layer)

Entities are **pure business objects**. They live in the domain layer, use `Equatable` for value equality, and contain no serialization logic.

```dart
// lib/features/authentication/domain/entities/user_entity.dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final bool isPremium;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.isPremium,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, avatarUrl, isPremium, createdAt];
}
```

### Model (Data Layer)

Models **extend** entities and add serialization/deserialization capabilities (`fromJson`, `toJson`) and a `toEntity()` mapper.

```dart
// lib/features/authentication/data/models/user_model.dart
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatarUrl,
    required super.isPremium,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
      isPremium: json['is_premium'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'is_premium': isPremium,
      'created_at': createdAt.toIso8601String(),
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      isPremium: isPremium,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      avatarUrl: entity.avatarUrl,
      isPremium: entity.isPremium,
      createdAt: entity.createdAt,
    );
  }
}
```

### Mapping Flow

```
API Response (JSON)
       │
       ▼
  UserModel.fromJson(json)     ← Data Layer
       │
       ▼
  UserModel.toEntity()         ← Maps to Domain
       │
       ▼
  UserEntity                   ← Domain Layer (used by BLoC & UI)
```

> **Rule:** The Presentation and Domain layers never see `UserModel`. They always work with `UserEntity`.

---

## 9. Dependency Injection Setup

### Service Locator with GetIt

```dart
// lib/core/dependency_injection/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spent_story/core/network/dio_provider.dart';
import 'package:smart_spent_story/core/dependency_injection/auth_injection.dart';
import 'package:smart_spent_story/core/dependency_injection/dashboard_injection.dart';
import 'package:smart_spent_story/core/dependency_injection/transaction_injection.dart';
import 'package:smart_spent_story/core/dependency_injection/analytics_injection.dart';
import 'package:smart_spent_story/core/dependency_injection/profile_injection.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // ── External ──────────────────────────────────────
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Dio>(() => DioProvider.createDio());

  // ── Features ──────────────────────────────────────
  initAuthInjection();
  initDashboardInjection();
  initTransactionInjection();
  initAnalyticsInjection();
  initProfileInjection();
}
```

### Feature-Specific Injection Example

```dart
// lib/core/dependency_injection/auth_injection.dart
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';
import 'package:smart_spent_story/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:smart_spent_story/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:smart_spent_story/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:smart_spent_story/features/authentication/domain/repositories/auth_repository.dart';
import 'package:smart_spent_story/features/authentication/domain/usecases/login_usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/usecases/register_usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/usecases/get_cached_user_usecase.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_bloc.dart';

void initAuthInjection() {
  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      getCachedUserUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sharedPreferences: sl()),
  );
}
```

### Initialization in `main.dart`

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';
import 'package:smart_spent_story/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const SmartSpentApp());
}
```

---

## 10. Navigation Architecture

### GoRouter Setup

```dart
// lib/routes/route_names.dart
abstract final class RouteNames {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String analytics = '/analytics';
  static const String addTransaction = '/add-transaction';
  static const String transactionList = '/transactions';
  static const String profile = '/profile';
  static const String personalInfo = '/profile/personal-info';
  static const String notificationSettings = '/profile/notifications';
  static const String bankAccounts = '/profile/bank-accounts';
  static const String security = '/profile/security';
  static const String helpSupport = '/profile/help-support';
}
```

```dart
// lib/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_state.dart';
import 'package:smart_spent_story/routes/route_names.dart';

// Import all pages...

class AppRouter {
  final AuthBloc _authBloc;

  AppRouter({required AuthBloc authBloc}) : _authBloc = authBloc;

  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = _authBloc.state is AuthAuthenticated;
      final isAuthRoute = state.matchedLocation == RouteNames.login ||
          state.matchedLocation == RouteNames.register;
      final isOnboarding = state.matchedLocation == RouteNames.onboarding;
      final isSplash = state.matchedLocation == RouteNames.splash;

      if (isSplash || isOnboarding) return null;

      if (!isAuthenticated && !isAuthRoute) {
        return RouteNames.login;
      }

      if (isAuthenticated && isAuthRoute) {
        return RouteNames.dashboard;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegisterPage(),
      ),

      // Shell route for bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardPage(),
            ),
          ),
          GoRoute(
            path: RouteNames.analytics,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AnalyticsPage(),
            ),
          ),
          GoRoute(
            path: RouteNames.addTransaction,
            builder: (context, state) => const AddTransactionPage(),
          ),
          GoRoute(
            path: RouteNames.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfilePage(),
            ),
            routes: [
              GoRoute(
                path: 'personal-info',
                builder: (context, state) => const PersonalInfoPage(),
              ),
              GoRoute(
                path: 'notifications',
                builder: (context, state) => const NotificationSettingsPage(),
              ),
              GoRoute(
                path: 'bank-accounts',
                builder: (context, state) => const BankAccountsPage(),
              ),
              GoRoute(
                path: 'security',
                builder: (context, state) => const SecurityPage(),
              ),
              GoRoute(
                path: 'help-support',
                builder: (context, state) => const HelpSupportPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
```

### MainShell (Bottom Navigation)

```dart
// Used as the ShellRoute builder
class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _calculateIndex(GoRouterState.of(context).matchedLocation),
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }

  int _calculateIndex(String location) {
    if (location.startsWith(RouteNames.dashboard)) return 0;
    if (location.startsWith(RouteNames.analytics)) return 1;
    if (location.startsWith(RouteNames.addTransaction)) return 2;
    if (location.startsWith(RouteNames.profile)) return 3;
    return 0;
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0: context.go(RouteNames.dashboard);
      case 1: context.go(RouteNames.analytics);
      case 2: context.go(RouteNames.addTransaction);
      case 3: context.go(RouteNames.profile);
    }
  }
}
```

---

## 11. API Layer Architecture

### Dio Provider

```dart
// lib/core/network/dio_provider.dart
import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/configs/env_config.dart';
import 'package:smart_spent_story/core/network/interceptors/auth_interceptor.dart';
import 'package:smart_spent_story/core/network/interceptors/logging_interceptor.dart';
import 'package:smart_spent_story/core/network/interceptors/error_interceptor.dart';

class DioProvider {
  static Dio createDio({EnvConfig config = EnvConfig.development}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    return dio;
  }
}
```

### Auth Interceptor

```dart
// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final prefs = sl<SharedPreferences>();
    final token = prefs.getString('access_token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired — trigger refresh or logout
    }
    handler.next(err);
  }
}
```

### Error Interceptor

```dart
// lib/core/network/interceptors/error_interceptor.dart
import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const NetworkException(
          message: 'Connection timed out. Please try again.',
        );
      case DioExceptionType.connectionError:
        throw const NetworkException(
          message: 'No internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final data = err.response?.data;
        final message = data is Map ? data['message'] as String? : null;

        throw ServerException(
          message: message ?? 'Something went wrong.',
          statusCode: statusCode,
        );
      default:
        throw ServerException(
          message: err.message ?? 'An unexpected error occurred.',
        );
    }
  }
}
```

### API Client

```dart
// lib/core/network/api_client.dart
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  const ApiClient({required Dio dio}) : _dio = dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
  }) async {
    return _dio.post(path, data: data);
  }

  Future<Response> put(
    String path, {
    dynamic data,
  }) async {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return _dio.delete(path);
  }
}
```

### API Endpoints

```dart
// lib/core/network/api_endpoints.dart
abstract final class ApiEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Dashboard
  static const String balance = '/dashboard/balance';
  static const String spendingCategories = '/dashboard/spending-categories';
  static const String upcomingBills = '/dashboard/upcoming-bills';
  static const String aiInsights = '/dashboard/ai-insights';

  // Transactions
  static const String transactions = '/transactions';
  static String transactionById(String id) => '/transactions/$id';

  // Analytics
  static const String analyticsSummary = '/analytics/summary';
  static const String categorySpending = '/analytics/category-spending';
  static const String savingsTrend = '/analytics/savings-trend';

  // Profile
  static const String profile = '/profile';
  static const String updateProfile = '/profile/update';
}
```

---

## 12. Utility Layer

### Debouncer

Throttles rapid user input (e.g., search fields) to avoid excessive API calls.

```dart
// lib/core/utils/debouncer.dart
import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
```

### Validators

Centralized input validation logic used by forms across the app.

```dart
// lib/core/utils/validators.dart
abstract final class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Must contain an uppercase letter';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Must contain a number';
    return null;
  }

  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.isEmpty) return 'Amount is required';
    final amount = double.tryParse(value);
    if (amount == null) return 'Enter a valid amount';
    if (amount <= 0) return 'Amount must be greater than zero';
    return null;
  }
}
```

### Formatters

Consistent formatting for currency, dates, and percentages.

```dart
// lib/core/utils/formatters.dart
import 'package:intl/intl.dart';

abstract final class Formatters {
  static final _currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static final _compactCurrencyFormat = NumberFormat.compactCurrency(
    symbol: '\$',
    decimalDigits: 1,
  );

  static String currency(double amount) => _currencyFormat.format(amount);

  static String compactCurrency(double amount) =>
      _compactCurrencyFormat.format(amount);

  static String date(DateTime date) => DateFormat('MMM d, yyyy').format(date);

  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(date);
  }

  static String percentage(double value) => '${value.toStringAsFixed(0)}%';
}
```

### Logger

```dart
// lib/core/utils/logger.dart
import 'package:logger/logger.dart' as pkg;

final logger = pkg.Logger(
  printer: pkg.PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
  ),
);
```

### Typedefs

Common type aliases to reduce verbosity.

```dart
// lib/core/utils/typedefs.dart
import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = ResultFuture<void>;
typedef DataMap = Map<String, dynamic>;
```

---

## 13. Extensions Layer

### BuildContext Extensions

```dart
// lib/core/extensions/context_extensions.dart
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
```

### String Extensions

```dart
// lib/core/extensions/string_extensions.dart
extension StringExtensions on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get initials => split(' ')
      .where((w) => w.isNotEmpty)
      .take(2)
      .map((w) => w[0].toUpperCase())
      .join();

  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}...';
}
```

### DateTime Extensions

```dart
// lib/core/extensions/datetime_extensions.dart
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get formatted => DateFormat('MMM d, yyyy').format(this);

  String get timeFormatted => DateFormat('h:mm a').format(this);

  String get dayMonth => DateFormat('MMM d').format(this);

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  String get relativeLabel {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    return formatted;
  }

  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}
```

### Num Extensions

```dart
// lib/core/extensions/num_extensions.dart
import 'package:flutter/material.dart';

extension NumExtensions on num {
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  Duration get milliseconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());
}
```

---

## 14. Theme System

### AppColors

```dart
// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark = Color(0xFF4A42DB);

  // Secondary
  static const Color secondary = Color(0xFF03DAC5);

  // Backgrounds
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // Semantic
  static const Color income = Color(0xFF4CAF50);
  static const Color expense = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF29B6F6);
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF4CAF50);

  // Borders and Dividers
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);

  // Category Colors
  static const Color housing = Color(0xFF6C63FF);
  static const Color food = Color(0xFFFF6B6B);
  static const Color transport = Color(0xFF4ECDC4);
  static const Color entertainment = Color(0xFFFFE66D);
  static const Color health = Color(0xFF95E1D3);
  static const Color other = Color(0xFFA8A8A8);
}
```

### AppFonts

```dart
// lib/core/constants/app_fonts.dart
import 'package:flutter/material.dart';

abstract final class AppFonts {
  static const String fontFamily = 'Inter';

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const double heading1 = 32;
  static const double heading2 = 24;
  static const double heading3 = 20;
  static const double body1 = 16;
  static const double body2 = 14;
  static const double caption = 12;
  static const double overline = 10;
}
```

### ThemeData Setup

```dart
// lib/core/configs/app_config.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineMedium: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineSmall: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: const TextStyle(color: AppColors.textHint),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showUnselectedLabels: true,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
    );
  }
}
```

---

## 15. Example Feature Implementation

Full implementation of the **Authentication** feature following every layer of Clean Architecture.

### 15.1 Entity

```dart
// lib/features/authentication/domain/entities/user_entity.dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final bool isPremium;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.isPremium,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, avatarUrl, isPremium, createdAt];
}
```

### 15.2 Model

```dart
// lib/features/authentication/data/models/user_model.dart
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatarUrl,
    required super.isPremium,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
      isPremium: json['is_premium'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'is_premium': isPremium,
      'created_at': createdAt.toIso8601String(),
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      isPremium: isPremium,
      createdAt: createdAt,
    );
  }
}
```

### 15.3 Repository Contract (Domain)

```dart
// lib/features/authentication/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity>> getCachedUser();
}
```

### 15.4 Data Sources

```dart
// lib/features/authentication/data/datasources/auth_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:smart_spent_story/core/network/api_endpoints.dart';
import 'package:smart_spent_story/features/authentication/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio _dio;

  const AuthRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.register,
      data: {'name': name, 'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await _dio.post(ApiEndpoints.logout);
  }
}
```

```dart
// lib/features/authentication/data/datasources/auth_local_datasource.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spent_story/features/authentication/data/models/user_model.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';

abstract class AuthLocalDatasource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getCachedUser();
  Future<void> clearCache();
  Future<void> cacheToken(String token);
  Future<String?> getToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences _prefs;

  static const String _userKey = 'cached_user';
  static const String _tokenKey = 'access_token';

  const AuthLocalDatasourceImpl({required SharedPreferences sharedPreferences})
      : _prefs = sharedPreferences;

  @override
  Future<void> cacheUser(UserModel user) async {
    await _prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel> getCachedUser() async {
    final jsonString = _prefs.getString(_userKey);
    if (jsonString == null) {
      throw const CacheException(message: 'No cached user found');
    }
    return UserModel.fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> clearCache() async {
    await _prefs.remove(_userKey);
    await _prefs.remove(_tokenKey);
  }

  @override
  Future<void> cacheToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }
}
```

### 15.5 Repository Implementation

```dart
// lib/features/authentication/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/exceptions.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:smart_spent_story/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';
import 'package:smart_spent_story/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;

  const AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required AuthLocalDatasource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDatasource.login(
        email: email,
        password: password,
      );
      await _localDatasource.cacheUser(userModel);
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDatasource.register(
        name: name,
        email: email,
        password: password,
      );
      await _localDatasource.cacheUser(userModel);
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDatasource.logout();
      await _localDatasource.clearCache();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCachedUser() async {
    try {
      final userModel = await _localDatasource.getCachedUser();
      return Right(userModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
```

### 15.6 Use Cases

```dart
// lib/features/authentication/domain/usecases/login_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';
import 'package:smart_spent_story/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
```

```dart
// lib/features/authentication/domain/usecases/register_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';
import 'package:smart_spent_story/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUseCase extends UseCase<UserEntity, RegisterParams> {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    return _repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
```

```dart
// lib/features/authentication/domain/usecases/logout_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/repositories/auth_repository.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _repository.logout();
  }
}
```

```dart
// lib/features/authentication/domain/usecases/get_cached_user_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:smart_spent_story/core/error/failures.dart';
import 'package:smart_spent_story/core/usecase/usecase.dart';
import 'package:smart_spent_story/features/authentication/domain/entities/user_entity.dart';
import 'package:smart_spent_story/features/authentication/domain/repositories/auth_repository.dart';

class GetCachedUserUseCase extends UseCase<UserEntity, NoParams> {
  final AuthRepository _repository;

  GetCachedUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return _repository.getCachedUser();
  }
}
```

### 15.7 BLoC

The full `AuthBloc`, `AuthEvent`, and `AuthState` are provided in [Section 7](#7-bloc-pattern-guide) above.

### 15.8 UI Page

```dart
// lib/features/authentication/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';
import 'package:smart_spent_story/core/extensions/context_extensions.dart';
import 'package:smart_spent_story/core/extensions/num_extensions.dart';
import 'package:smart_spent_story/core/utils/validators.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_event.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_state.dart';
import 'package:smart_spent_story/routes/route_names.dart';
import 'package:smart_spent_story/shared/widgets/custom_button.dart';
import 'package:smart_spent_story/shared/widgets/custom_text_field.dart';
import 'package:smart_spent_story/shared/widgets/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            AuthLoginRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                context.go(RouteNames.dashboard);
              }
              if (state is AuthFailure) {
                context.showSnackBar(state.message, isError: true);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      60.verticalSpace,
                      Text(
                        'Welcome Back',
                        style: context.textTheme.headlineLarge,
                      ),
                      8.verticalSpace,
                      Text(
                        'Sign in to continue tracking your finances',
                        style: context.textTheme.bodyMedium,
                      ),
                      40.verticalSpace,
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                      ),
                      16.verticalSpace,
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Enter your password',
                        obscureText: true,
                        validator: Validators.password,
                      ),
                      8.verticalSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      24.verticalSpace,
                      if (state is AuthLoading)
                        const Center(child: LoadingIndicator())
                      else
                        CustomButton(
                          label: 'Sign In',
                          onPressed: () => _onLogin(context),
                        ),
                      24.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: context.textTheme.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: () => context.go(RouteNames.register),
                            child: Text(
                              'Sign Up',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

---

## 16. Development Workflow

Follow this step-by-step workflow when implementing **any new feature**:

### Step 1: Create Feature Directory

```
lib/features/your_feature/
  ├── data/
  │   ├── models/
  │   ├── datasources/
  │   └── repositories/
  ├── domain/
  │   ├── entities/
  │   ├── repositories/
  │   └── usecases/
  └── presentation/
      ├── bloc/
      ├── pages/
      └── widgets/
```

### Step 2: Create Entity

Define the core business object in `domain/entities/`. Extend `Equatable`. Include only the fields the domain logic needs.

### Step 3: Create Model

In `data/models/`, create a model that extends the entity. Add `fromJson()`, `toJson()`, `toEntity()`, and optionally `fromEntity()`.

### Step 4: Create Repository Contract

Define an abstract class in `domain/repositories/` with methods returning `Future<Either<Failure, Type>>`.

### Step 5: Create Data Sources

In `data/datasources/`, create abstract interfaces and their implementations for remote (API via Dio) and local (Hive/SharedPreferences) data access.

### Step 6: Create Repository Implementation

In `data/repositories/`, implement the domain contract. Coordinate between remote and local data sources. Catch exceptions and return `Left(Failure)` or `Right(data)`.

### Step 7: Create Use Cases

In `domain/usecases/`, create one class per business action. Extend `UseCase<ReturnType, Params>`. Inject the repository.

### Step 8: Create BLoC

In `presentation/bloc/`, create three files:

- `feature_event.dart` — all user actions as events
- `feature_state.dart` — all possible UI states
- `feature_bloc.dart` — map events to states via use cases

### Step 9: Create UI

In `presentation/pages/`, build the screen using `BlocProvider` and `BlocBuilder`/`BlocConsumer`. Extract reusable parts into `presentation/widgets/`.

### Step 10: Register Dependencies

Create a `core/dependency_injection/feature_injection.dart` file and register all classes (data source, repository, use cases, BLoC) with GetIt. Call the init function from `service_locator.dart`.

### Step 11: Add Routes

Register new routes in `app_router.dart` and add route constants to `route_names.dart`.

---

## 17. Best Practices

### Naming Conventions

| Type                  | Convention                        | Example                     |
| --------------------- | --------------------------------- | --------------------------- |
| Files                 | `snake_case`                      | `auth_repository_impl.dart` |
| Classes               | `PascalCase`                      | `AuthRepositoryImpl`        |
| Variables / Functions | `camelCase`                       | `getCachedUser()`           |
| Constants             | `camelCase`                       | `primaryColor`              |
| Private members       | `_camelCase`                      | `_remoteDatasource`         |
| BLoC events           | `PascalCase` with verb            | `AuthLoginRequested`        |
| BLoC states           | `PascalCase` with adjective       | `AuthAuthenticated`         |
| Enums                 | `PascalCase` / `camelCase` values | `TransactionType.expense`   |

### File Naming

- Entities: `user_entity.dart`
- Models: `user_model.dart`
- Repositories (abstract): `auth_repository.dart`
- Repositories (impl): `auth_repository_impl.dart`
- Use cases: `login_usecase.dart`
- BLoC: `auth_bloc.dart`, `auth_event.dart`, `auth_state.dart`
- Pages: `login_page.dart`
- Widgets: `balance_card.dart`

### BLoC Best Practices

1. **One BLoC per feature** — avoid monolithic BLoCs that manage unrelated state.
2. **Events are past-tense or imperative** — `AuthLoginRequested`, `TransactionAdded`.
3. **States are immutable** — always use `const` constructors with `Equatable`.
4. **Never access `BuildContext` inside a BLoC** — pass all needed data through events.
5. **Use `BlocListener` for side effects** — navigation, snackbars, dialogs.
6. **Use `BlocBuilder` for UI rebuilds** — with `buildWhen` for granular rebuilds.
7. **Close BLoCs** — use `BlocProvider` which auto-closes, or manually close in `dispose()`.

### Scalability Tips

- Keep features 100% isolated — no feature imports another feature directly.
- Shared logic belongs in `core/` or `shared/`.
- Use interfaces everywhere — swap implementations without touching consumers.
- Register BLoCs as `Factory` in GetIt (new instance per provider), use cases and repositories as `LazySingleton`.

---

## 18. Recommended Packages

```yaml
# pubspec.yaml
name: smart_spent_story
description: A smart personal finance tracker built with Clean Architecture.
publish_to: "none"
version: 1.0.0+1

environment:
  sdk: ^3.6.2

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.6
  equatable: ^2.0.7

  # Networking
  dio: ^5.7.0

  # Dependency Injection
  get_it: ^8.0.2

  # Navigation
  go_router: ^14.6.2

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.3.4

  # Functional Programming
  dartz: ^0.10.1

  # Charts
  fl_chart: ^0.70.2

  # UI & Styling
  google_fonts: ^6.2.1
  flutter_screenutil: ^5.9.3
  flutter_svg: ^2.0.16
  cached_network_image: ^3.4.1
  shimmer: ^3.0.0

  # Utilities
  intl: ^0.19.0
  logger: ^2.5.0
  connectivity_plus: ^6.1.1
  url_launcher: ^6.3.1

  # Icons
  cupertino_icons: ^1.0.8
  lucide_icons: ^0.257.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  bloc_test: ^9.1.7
  mocktail: ^1.0.4
  hive_generator: ^2.0.1
  build_runner: ^2.4.14

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/svgs/

  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
          weight: 400
        - asset: assets/fonts/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```

---

## 19. Coding Standards

### General Rules

1. **No magic numbers or strings** — extract into constants (`AppColors`, `AppStrings`, `AppSpacing`).
2. **Prefer `const` constructors** — always use `const` where the compiler allows it.
3. **Single Responsibility** — every class does exactly one thing.
4. **Favor composition over inheritance** — use mixins and interfaces.
5. **Immutable state** — all BLoC states, events, entities, and models are immutable.
6. **Explicit types** — avoid `dynamic`; declare types for function parameters and return values.
7. **Private by default** — prefix members with `_` unless they need to be public.
8. **Max file length ~300 lines** — if a file exceeds this, extract widgets or helpers.
9. **Consistent imports** — order: Dart SDK, Flutter SDK, packages, project files. Use relative imports within a feature, absolute imports across features.

### Error Handling

- **Data layer** throws `ServerException`, `CacheException`, `NetworkException`.
- **Repository** catches exceptions and returns `Either<Failure, T>`.
- **BLoC** folds `Either` and emits success or failure states.
- **UI** listens for failure states and displays user-friendly messages.

### Testing Strategy

| Layer        | Test Type                 | Tool                       |
| ------------ | ------------------------- | -------------------------- |
| Entities     | Unit test                 | `flutter_test`             |
| Models       | Unit test (serialization) | `flutter_test`             |
| Use Cases    | Unit test                 | `mocktail`, `flutter_test` |
| Repositories | Unit test                 | `mocktail`, `flutter_test` |
| BLoC         | BLoC test                 | `bloc_test`, `mocktail`    |
| Widgets      | Widget test               | `flutter_test`             |
| Full flows   | Integration test          | `integration_test`         |

---

## 20. Scalability Strategy

### Adding a New Feature

1. Create the feature folder under `lib/features/new_feature/`.
2. Follow the exact same `data/`, `domain/`, `presentation/` structure.
3. Create a new DI file `core/dependency_injection/new_feature_injection.dart`.
4. Call the init function from `service_locator.dart`.
5. Add routes to `app_router.dart`.
6. The rest of the app is **completely unaffected**.

### Why This Architecture Scales

| Concern                   | How It's Addressed                                                                             |
| ------------------------- | ---------------------------------------------------------------------------------------------- |
| **Feature isolation**     | Each feature is self-contained — adding or removing a feature never breaks another.            |
| **Testability**           | Every layer is independently testable with mocked dependencies.                                |
| **Team parallelism**      | Developers can work on separate features simultaneously without merge conflicts.               |
| **Backend changes**       | Only the data layer (models + data sources) changes. Domain and presentation remain untouched. |
| **State management swap** | BLoC can be replaced with Riverpod or Cubit by only modifying the presentation layer.          |
| **Dependency swapping**   | Changing from Dio to `http` or from Hive to `sqflite` only affects the data layer.             |
| **White-labeling**        | Theme system and constants layer make re-skinning trivial.                                     |
| **Modularization**        | Features can be extracted into standalone Dart packages for multi-app architectures.           |

### Horizontal Scaling Pattern

```
lib/features/
  ├── authentication/     ← Sprint 1
  ├── dashboard/          ← Sprint 1
  ├── transaction/        ← Sprint 2
  ├── analytics/          ← Sprint 2
  ├── profile/            ← Sprint 3
  ├── notifications/      ← Sprint 4 (future)
  ├── budgets/            ← Sprint 4 (future)
  ├── recurring_bills/    ← Sprint 5 (future)
  ├── goals/              ← Sprint 5 (future)
  └── export/             ← Sprint 6 (future)
```

Each new feature follows the identical architecture, making onboarding of new developers fast and predictable.

---

## App Entry Point

```dart
// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_spent_story/core/configs/app_config.dart';
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_event.dart';
import 'package:smart_spent_story/routes/app_router.dart';

class SmartSpentApp extends StatelessWidget {
  const SmartSpentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => sl<AuthBloc>()..add(const AuthCheckStatusRequested()),
          child: Builder(
            builder: (context) {
              final authBloc = context.read<AuthBloc>();
              final appRouter = AppRouter(authBloc: authBloc);

              return MaterialApp.router(
                title: 'Smart Spent Story',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                routerConfig: appRouter.router,
              );
            },
          ),
        );
      },
    );
  }
}
```

---

## License

This project is proprietary and confidential. Unauthorized copying, distribution, or modification is strictly prohibited.
