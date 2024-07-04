# Flickr_CVS

A SwiftUI application that allows users to search for images on Flickr. This project demonstrates the use of Combine, SwiftUI, and proper architectural patterns for an iOS application.

## Features

- Search for images on Flickr using a search bar.
- Display search results in a grid view.
- View detailed information about each image.
- Robust error handling and state management.

## Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/yourusername/Flickr_CVS.git
    cd Flickr_CVS
    ```

2. **Open the project in Xcode:**
    ```sh
    open Flickr_CVS.xcodeproj
    ```


3. **Run the project:**
   Select a simulator or device and click the `Run` button in Xcode.

## Usage

1. **Search for Images:**
   - Enter a search term in the search bar to fetch images from Flickr.
   - The search results will be displayed in a grid view.

2. **View Image Details:**
   - Tap on an image in the grid to view its details, including title, description, author, and published date.

## Architecture

- **ViewModel:** Handles the business logic and data fetching using Combine.
- **Service:** Handles network requests to the Flickr API.
- **Views:** SwiftUI views for displaying the UI components.

## Code Overview

### View Models

- **ImageSearchViewModel:** Manages the search functionality and state for the image search feature.

### Services

- **FlickrAPIService:** Fetches images from Flickr API and handles response parsing.
- **MockFlickrAPIService:** A mock service used for testing.

### Views

- **ImageGridView:** Displays a grid of images fetched from Flickr.
- **ImageDetailView:** Displays detailed information about a selected image.
- **AsyncImageView:** A custom view that asynchronously loads and caches images.

## Testing

Unit tests are included to ensure the functionality of the ViewModel and service layers.

- **ImageSearchViewModelTests:** Tests for the `ImageSearchViewModel`.

To run the tests, select the test target and click the `Test` button in Xcode, or run the following command in the terminal:

```sh
xcodebuild test -scheme Flickr_CVS -destination 'platform=iOS Simulator,name=iPhone 11'
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -am 'Add your feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or feedback, feel free to contact me at Adegbenroalexander15@gmail.com.com.

