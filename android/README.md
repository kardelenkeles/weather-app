
# Uplide Task Weather App

## Description

Uplide Task is a Flutter-based weather application that provides real-time weather information for various cities. The app features a modern and intuitive user interface, and it utilizes a robust architecture to ensure a seamless and efficient user experience.

## Features

- Display weather information for five cities on the homepage.
- Detailed weather information available for each city through clickable profiles.
- Real-time weather updates using the OpenWeather API.
- User profile management.
- Persistent storage of recently viewed weather data.
- State management using Provider.
- Dependency injection with GetIt.
- MVVM architecture for efficient data handling.
- Navigation between pages using AutoRoute.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK (>=3.4.3 <4.0.0)
- Dart SDK

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/your-repo/uplide_task.git
   cd uplide_task
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Setup environment variables:**
   Create a `.env` file in the root directory and add your OpenWeather API key:
   ```sh
   OPENWEATHER_API_KEY=your_api_key
   ```

### Running the App

To run the app on your local machine or connected device, use the following command:
```sh
flutter run
```

## Project Structure

The project follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model:** Contains data structures and business logic.
- **View:** Handles the UI and user interactions.
- **ViewModel:** Acts as a bridge between the Model and View, managing the data flow and state.

### Key Directories

- **lib:** Contains the main source code.
  - **models:** Data models.
  - **viewmodels:** ViewModel classes.
  - **views:** UI components.
  - **services:** Service classes for API calls and data handling.
  - **utils:** Utility functions and constants.
  - **di:** Dependency injection setup using GetIt.

## Dependencies

- **Flutter SDK**
- **cupertino_icons:** iOS style icons
- **flutter_dotenv:** Environment variables management
- **shared_preferences:** Local storage
- **auto_route:** Routing and navigation
- **get_it:** Dependency injection
- **provider:** State management
- **http:** HTTP requests
- **geolocator:** Location services
- **lottie:** Animations
- **flutter_weather_bg_null_safety:** Weather background animations
- **flutter_compass:** Compass functionality
- **fl_chart:** Charts and graphs

## Development Dependencies

- **flutter_test:** Testing framework
- **flutter_lints:** Linting rules
- **build_runner:** Code generation
- **auto_route_generator:** Route generation

## Assets

The following assets are included in the project:

- **.env:** Environment variables file
- **assets/gifs:** Animated GIFs
- **assets/icons:** Icon assets

## Versioning

Version: 1.0.0+1

For detailed information on versioning, refer to the following resources:
- [Android Versioning](https://developer.android.com/studio/publish/versioning)
- [iOS Versioning](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html)
- [Windows Versioning](https://flutter.dev/assets-and-images/#resolution-aware)

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Thanks to the Flutter community for their valuable resources and support.

---

For any questions or support, please contact [your-email@example.com].

## Installation

### Install dependencies

```sh
flutter pub get
```

### Setup environment variables
Create a `.env` file in the root directory and add your OpenWeather API key:

```sh
OPENWEATHER_API_KEY=your_api_key
```

## Running the App
To run the app on your local machine or connected device, use the following command:

```sh
flutter run
```

## Project Structure
The project follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model:** Contains data structures and business logic.
- **View:** Handles the UI and user interactions.
- **ViewModel:** Acts as a bridge between the Model and View, managing the data flow and state.

### Key Directories

- **lib:** Contains the main source code.
  - **models:** Data models.
  - **viewmodels:** ViewModel classes.
  - **views:** UI components.
  - **services:** Service classes for API calls and data handling.
  - **utils:** Utility functions and constants.
  - **di:** Dependency injection setup using GetIt.

## Dependencies

- **Flutter SDK**
- **cupertino_icons:** iOS style icons
- **flutter_dotenv:** Environment variables management
- **shared_preferences:** Local storage
- **auto_route:** Routing and navigation
- **get_it:** Dependency injection
- **provider:** State management
- **http:** HTTP requests
- **geolocator:** Location services
- **lottie:** Animations
- **flutter_weather_bg_null_safety:** Weather background animations
- **flutter_compass:** Compass functionality
- **fl_chart:** Charts and graphs

## Development Dependencies

- **flutter_test:** Testing framework
- **flutter_lints:** Linting rules
- **build_runner:** Code generation
- **auto_route_generator:** Route generation

## Assets

The following assets are included in the project:

- **.env:** Environment variables file
- **assets/gifs:** Animated GIFs
- **assets/icons:** Icon assets

## Versioning

Version: 1.0.0+1

For detailed information on versioning, refer to the following resources:
- [Android Versioning](https://developer.android.com/studio/publish/versioning)
- [iOS Versioning](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html)
- [Windows Versioning](https://flutter.dev/assets-and-images/#resolution-aware)

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Thanks to the Flutter community for their valuable resources and support.
