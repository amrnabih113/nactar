

# Nectar

Nectar is an e-commerce mobile application built using Flutter. It offers a seamless shopping experience with dynamic content, real-time updates, and a user-friendly interface. The app integrates Firebase for authentication, SQLite for local database management, and uses the Provider package for state management.

## Features

- **Dynamic Home Page**: Showcases exclusive offers, best-selling products, and groceries.
- **User Authentication**: Secure login and registration using Firebase Authentication.
- **Local Database**: Manages user data, cart items, favorites, and product listings with SQLite.
- **Real-Time Updates**: Utilizes Provider for effective state management and real-time data synchronization.
- **Navigation**: Easy access to Home, Explore, Cart, Favorites, and Profile pages via a bottom navigation bar.
- **Cart and Favorites**: Add, update, and remove items from the cart and favorites list.



## Usage

- **Login/Signup**: Users can register or log in using their email.
- **Home Page**: Browse through exclusive offers, best-selling products, and groceries.
- **Cart**: Add products to the cart and manage quantities.
- **Favorites**: Mark products as favorites and view them in a dedicated list.
- **Explore**: Discover new products and categories.

## State Management

The app uses the [Provider](https://pub.dev/packages/provider) package for state management. This allows for efficient and reactive updates across the app. Key state management features include:

- **Fetching and updating product data**
- **Managing user cart and favorites**
- **Real-time synchronization of data**

## Database Schema

The app utilizes SQLite for local storage. The database schema includes:

- **Users**: Stores user profile information.
- **Categories**: Stores product categories.
- **Products**: Stores product details.
- **Cart**: Manages user cart items.
- **Orders**: Stores order details.
- **OrderItems**: Stores items within an order.
- **Offers**: Stores exclusive offers.
- **BestSelling**: Stores best-selling products.
- **Favorites**: Stores user favorite products.

## Contributing

Contributions are welcome! Please submit issues or pull requests via GitHub.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/) - The framework used for building the app.
- [Firebase](https://firebase.google.com/) - For authentication and cloud services.
- [Provider](https://pub.dev/packages/provider) - For state management.
