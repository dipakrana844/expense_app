# Smart Expense Tracker Pro

A production-grade, offline-first Flutter application for tracking personal finances.

## Architecture

- **Clean Architecture** (Feature-based)
- **State Management**: Riverpod 3.x
- **Navigation**: GoRouter (ShellRoute)
- **Database**: Hive (Offline-first)
- **Background Tasks**: Workmanager (Daily recurring expenses)
- **Charts**: fl_chart
- **Security**: local_auth (Biometrics)

## Setup Instructions

1.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Generate Code (Crucial)**:
    This project uses `freezed`, `hive`, and `riverpod`. You MUST run the build runner to generate the necessary files (Models, Adapters).
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  **Run the App**:
    ```bash
    flutter run
    ```

## Features Implemented

1.  **Smart Scheduling**: Recurring expenses are handled by `Workmanager` in the background (Daily check).
2.  **Analytics**: Interactive charts using `fl_chart`.
3.  **Budgeting**: Set monthly limits and get visual alerts (80% / 100% usage).
4.  **Exports**: Export data to CSV and share.
5.  **Security**: App Lock with Biometrics.

## Project Structure

- `lib/core`: Shared utilities, Router, Theme, Services (Background, Export, Security).
- `lib/features`:
    - `expenses`: Main CRUD, Listing, Scheduling.
    - `analytics`: Visualization and Stats.
    - `budget`: Logic for monitoring limits.
    - `settings`: App configuration.
