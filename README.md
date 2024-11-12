# Flutter MVVM with GetX and Provider - Fake Store API Integration

This project demonstrates how to set up a Flutter application that interacts with the [Fake Store API](https://fakestoreapi.com/products) using the MVVM (Model-View-ViewModel) pattern. It leverages `GetX` for state management and dependency injection, along with `Provider` for additional state management. Additional features include cached images, bottom navigation bars, and image viewing.

## Features

- Fetches product data from [Fake Store API](https://fakestoreapi.com/products)
- Uses GetX and Provider for state management and dependency injection
- Displays images with caching and zooming capabilities
- Bottom navigation bar integration for easy navigation

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- An internet connection to access [Fake Store API](https://fakestoreapi.com/products)

### Installation

1. Clone the repository:
    ```bash
    git clone <your-repo-url>
    ```
   
2. Navigate to the project directory:
    ```bash
    cd <project-directory>
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

### Environment

This project uses Dart SDK version 3.5.3 or higher. Make sure your `pubspec.yaml` includes the following environment setting:

```yaml
environment:
  sdk: ^3.5.3
