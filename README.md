
---

# **Flutter E-Commerce App**

This is a Flutter-based e-commerce app built using the MVVM architecture. It includes user authentication (sign-up and login), product listing, product details, and a responsive UI. The app is designed to showcase clean code practices, state management using Riverpod, and local storage for authentication.

---

## **Features**
1. **User Authentication**
    - Sign-up and login functionality using local storage.
    - Persistent user authentication state.

2. **Product Listing**
    - Displays a list of products fetched from an API.
    - Each product includes a title, image, and price.

3. **Product Details**
    - View detailed information about a product, including its description, price, and image.

4. **Favorites**
    - Mark products as favorites for easy access.

5. **User Profile**
    - View and update user profile details.

---

## **Screens**
1. **Sign-Up Screen**: Create an account with email and password.
2. **Login Screen**: Log in to the app with email and password.
3. **Product Listing Screen**: View a list of products.
4. **Product Detail Screen**: See detailed information about a selected product.
5. **Profile Screen**: See  information about the authenticated user.
6.  **Favourite system**: Users can add, view and remove favourites.

---

## **User Journey**
1. **Authentication Flow**:
    - New users navigate to the **Sign-Up Screen** to create an account.
    - Existing users log in through the **Login Screen**.
    - Once logged in, the app navigates to the **Product Listing Screen**.

2. **Product Browsing**:
    - Browse a list of products on the **Product Listing Screen**.
    - Select a product to view its details on the **Product Detail Screen**.
    - Add a product to favourite for future reference and can view the favourite on the **Favourite Screen**.

3. **Logout**:
    - Logout functionality to securely exit the app.

---

## **How to Test the App**

### Prerequisites
1. Install **Flutter** on your system:
    - [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
2. Install **Android Studio** or **Xcode**:
    - Android: [Download Android Studio](https://developer.android.com/studio)
    - iOS: [Download Xcode](https://developer.apple.com/xcode/)

---

### **Steps to Run the App**

#### **1. Clone the Repository**
```bash
git clone https://github.com/pcechz/ImmersiveCommerce.git
cd <your directory>
```

#### **2. Install Dependencies**
Run the following command in the project directory to install all required packages:
```bash
flutter pub get
```

#### **3. Run on Android Emulator**
1. Open **Android Studio**.
2. Launch an Android Emulator from the **AVD Manager**.
3. Run the app:
   ```bash
   flutter run
   ```

#### **4. Run on iOS Simulator**
1. Open **Xcode**.
2. Select an iPhone simulator from the device list.
3. Run the app:
   ```bash
   flutter run
   ```

#### **5. Test on a Physical Device**
- For Android:  
  Connect your device via USB and enable USB Debugging.
- For iOS:  
  Connect your device via USB and ensure it is trusted.

---

### **API Used**
We are using [Dummyjson API](https://dummyjson.com/products/) to fetch mock product data for demonstration purposes.

---

## **Directory Structure**
The project follows a clean and maintainable MVVM architecture. Below is the directory structure:

```
lib/
│
├── data/
│   ├── models/                 # Data models (ProductModel, UserModel)
│   ├── repositories/           # API interaction and data handling
│
├── domain/
│   ├── entities/               # Abstract data representations
│   ├── usecases/               # Business logic (not implemented yet)
│   └── interfaces/             # Interfaces for repository abstraction
│
├── presentation/
│   ├── screens/
│   │   ├── auth/               # Login & Sign-Up Screens
│   │   ├── home/               # Product Listing Screen
│   │   └── product_details/    # Product Detail Screen
│   │   └── profile/            # Profile  Screen
│   │   └── favourite/          # Favourite Screen
│   ├── viewmodels/             # Riverpod state management for products
│   ├── widgets/                # Reusable UI components (e.g., ProductCard)
│   └── routes/                 # App routing logic
│
└── main.dart                   # App entry point
```

---

## **Testing Features**
1. **Sign-Up and Login**:
    - Open the app.
    - Sign up with a new email and password.
    - Log out and log back in with the same credentials.

2. **Product Listing**:
    - Browse the list of products on the home screen.
    - Verify that product images, titles, and prices load correctly.

3. **Product Details**:
    - Tap on a product to view its details.
    - Verify that the product's image, description, and price display correctly.

---

## **Tech Stack**
- **Framework**: Flutter
- **State Management**: Flutter_Riverpod
- **Mock API**: [Dummyjson API](https://dummyjson.com/products)
- **Local Storage**: `shared_preferences`

---

## **Future Improvements**
1. Integrate real APIs for authentication and product management.

---

## **Contributing**
Feel free to submit issues or pull requests to improve the app. For major changes, please open an issue first to discuss what you’d like to change.

---

## **License**
This project is licensed under the MIT License.

---
