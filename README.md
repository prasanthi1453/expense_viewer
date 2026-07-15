# Expense Viewer

Expense Viewer is an iOS app built with SwiftUI that fetches and displays a list of expenses. The app uses a small layered structure with networking, data mapping, domain models, and presentation logic separated into feature folders.

## Features

- Displays expense title, amount, and date.
- Fetches expense data through a reusable network layer.
- Maps JSON data into Swift domain models.
- Sorts expenses by newest date first.
- Handles loading, empty, loaded, and error states.
- Includes unit tests with mock expense data.

## Project Structure

```text
Expense Viewer/
├── App/
│   └── ExpenseViewerApp.swift
├── Core/
│   └── NetWork/
│       ├── APIClient.swift
│       ├── APIError.swift
│       ├── Endpoint.swift
│       ├── HTTPMethod.swift
│       ├── NetworkReachability.swift
│       └── URLRequestBuilder.swift
├── Features/
│   └── Expensive/
│       ├── Data/
│       │   ├── Mapper/
│       │   ├── Services/
│       │   └── Transformer/
│       ├── Domain/
│       │   └── Models/
│       └── Presentation/
│           ├── ViewModel/
│           └── Views/
└── Expense ViewerTests/
    └── Expense_ViewerTests.swift
```

## Requirements

- Xcode 16 or later
- iOS simulator or device supported by the project target
- Swift 5.9 or later

## Running the App

1. Open `Expense Viewer.xcodeproj` in Xcode.
2. Select the `Expense Viewer` scheme.
3. Choose an iOS simulator.
4. Press `Cmd + R` to build and run.

## Running Tests

In Xcode:

1. Select the `Expense Viewer` scheme.
2. Press `Cmd + U`.

The unit tests cover:

- Mapping dummy JSON into `Expense` models.
- Loading expenses in `ExpenseViewModel`.
- Sorting expenses by newest date first.
- Empty state handling.
- Error state handling.

## Sample Expense JSON

```json
[
  {
    "id": "1",
    "title": "Flight to SF",
    "amount": 230.50,
    "date": "2021-07-03T01:50:00+01:00"
  },
  {
    "id": "2",
    "title": "Hotel",
    "amount": 550.00,
    "date": "2021-08-03T01:50:00+01:00"
  }
]
```

## Architecture

The app follows a simple SwiftUI architecture:

- `Core/NetWork`: reusable networking components.
- `Data`: API endpoint, service, mapper, and Objective-C transformer.
- `Domain`: `Expense` model.
- `Presentation`: SwiftUI views and `ExpenseViewModel`.

`ExpenseViewModel` depends on `ExpenseServiceProtocol`, which allows tests to use a mock service without making real network requests.
