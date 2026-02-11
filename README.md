# Smart Expense Tracker Pro 🚀

A production-grade, offline-first, and intelligence-driven Flutter application for comprehensive personal finance management.

---

## ✨ Key Features

### 📱 Modern Unified Transactions (NEW)
- **Seamless Integration**: Single chronological view combining income and expenses naturally
- **Multi-View Interface**: Five comprehensive views for different financial perspectives:
  - **Daily View**: Chronological transactions grouped by date
  - **Calendar View**: Month grid with income/expense indicators per day
  - **Monthly View**: Year summary with expandable monthly breakdowns
  - **Total View**: Overall financial overview with budget status and comparisons
  - **Notes View**: Transactions with notes only, grouped by date
- **Power User Controls**: Instant filtering between All/Income/Expenses with segmented controls
- **Smart Navigation**: Month-by-month browsing with Previous/Next controls
- **Real-time Summary**: Sticky financial overview showing Income/Expenses/Net balance
- **Premium Design**: Dark-first fintech aesthetic with clear visual hierarchy
- **Advanced Search**: Real-time search across categories, sources, and notes
- **Daily Usage Optimized**: Designed for heavy, real-world money tracking

### 🛡️ Daily Spend Guard (NEW)
- **Real-time Protection**: Know exactly how much you can spend TODAY with instant updates
- **Smart Daily Limits**: Automatically calculated from monthly budget or 30-day average
- **Emotional Clarity**: Color-coded status (🟢 Safe / 🟡 Caution / 🔴 Exceeded) for instant understanding
- **Zero Setup**: Works automatically with your existing budget and expenses

### 🧠 AI Spending Intelligence

- **Anomaly Detection**: Automatically identifies unusual spending patterns using statistical Z-Score analysis.
- **Budget Burn Prediction**: Predicts when you will reach your budget limit based on current velocity.
- **Category Dominance**: Real-time insights into which categories are consuming your wealth.

### 🔍 OCR & Quick Entry

- **One-Tap Scanning**: High-accuracy OCR powered by Google ML Kit to extract amounts and tax from receipts.
- **Grocery Sessions**: A dedicated mode for bulk-adding grocery items with real-time budget tracking.

### 📊 Elite Analytics

- **Dynamic Visualizations**: Interactive charts powered by `fl_chart` with smooth transitions.
- **Spending Trends**: Compare current spending against historical data.

### 🛡️ Privacy & Reliability

- **Offline-First**: Powered by Hive for instantaneous data access without internet.
- **Biometric Security**: Secure your financial data with FaceID/Fingerprint.
- **Automated Backups**: Background tasks handle recurring expenses and data integrity.

---

## 🛠 Tech Stack

- **Core**: [Flutter](https://flutter.dev) (Latest Stable)
- **Architecture**: Clean Architecture (Feature-driven)
- **State Management**: [Riverpod 3.x](https://riverpod.dev) with Code Generation
- **Local Storage**: [Hive](https://pub.dev/packages/hive) (Fast NoSQL)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router) (Declarative Routing)
- **AI/ML**: Google ML Kit (Text Recognition)
- **Visuals**: `fl_chart`, `google_fonts`, `flutter_animate`

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.10.4)
- Dart SDK

### Setup Instructions

1.  **Clone & Fetch Dependencies**:

    ```bash
    git clone https://github.com/dipakrana844/expense_app.git
    cd expense_app
    flutter pub get
    ```

2.  **Generate Core Logic (Crucial)**:
    This project uses `freezed`, `hive`, and `riverpod_generator`. You MUST run the build runner to generate models and adapters.

    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  **Run Application**:
    ```bash
    flutter run
    ```

---

## 📂 Project Structure

```text
lib/
├── core/               # Shared utilities, routing, and global services
├── features/
│   ├── transactions/     # NEW: Unified income/expense tracking (default home screen)
│   ├── daily_spend_guard/ # NEW: Real-time daily spending protection
│   ├── expenses/       # Core CRUD and recurring logic
│   ├── income/         # Income tracking and management
│   ├── spending_intelligence/ # AI engine and insight logic
│   ├── ocr/            # Receipt scanning functionality
│   ├── grocery/        # specialized bulk entry mode
│   ├── analytics/      # fl_chart implementations
│   ├── budget/         # Limit monitoring and alerts
│   └── settings/       # App config and security
└── main.dart           # DI initialization and app entry
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
