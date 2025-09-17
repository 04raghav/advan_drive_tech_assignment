# Quick Order - Request Handling Workflow Prototype

Watch the app in action:  
[▶️ View Demo](https://drive.google.com/file/d/1VbQYmTZatBc7-CbLgYbt5IEh9ZojvBms/view?usp=sharing)

This project is a Flutter mobile application designed to simulate a real-world request and confirmation workflow. It features two distinct user roles: an **End User** who submits requests for multiple items, and a **Receiver** who processes these requests. The system is built to handle partial confirmations by intelligently reassigning unconfirmed items while maintaining a unified view for the end user.

## Features

### End User
- **Create & Submit Requests:** Easily select and submit requests containing multiple items.
- **View Request Status:** Track the status of submitted requests in a clear, consolidated view:
    - **Pending:** The request is awaiting review by a receiver.
    - **Partially Fulfilled:** Some items have been confirmed, while others are being reassigned. The original request list remains intact.
    - **Confirmed:** All items in the original request have been successfully confirmed.

### Receiver
- **View Assigned Queue:** See a list of all pending requests that need to be processed.
- **Item-by-Item Confirmation:** Review requests and confirm the availability of each item individually.
- **Process Confirmations:** Submit confirmation results back to the system. The system automatically handles the backend logic for full or partial fulfillment.

### System
- **Partial Fulfillment Logic:** If only some items are confirmed, the system marks the original request as "Partially Fulfilled" and automatically creates a new, linked request for the remaining items.
- **Status Roll-up:** The system tracks all reassigned "child" requests. Once all parts of an original request are confirmed, the original request's status is automatically updated to "Confirmed."
- **Role-Based Authentication:** A secure JWT-based authentication system differentiates between End Users and Receivers, providing access to role-specific features.

---

## System Design & Approach

The application is built on a client-server architecture, ensuring a clean separation of concerns between the user interface and the business logic.

### Frontend (Flutter)
- **Framework:** Flutter is used for building a high-performance, cross-platform mobile application from a single codebase.
- **State Management:** The **Provider** package is used for simple and efficient state management, allowing UI components to react to changes in the application's data.
- **Architecture:** The app follows a feature-based folder structure. Business logic is abstracted away from the UI using **Provider** classes that interact with dedicated **API Service** layers. This makes the code modular, scalable, and easy to maintain.
- **Local Persistence:** **GetStorage** is used for fast and simple local storage of the user's session data (authentication token and user details).

### Backend (Node.js & Express)
- **Framework:** A lightweight and powerful backend is built using **Node.js** and the **Express.js** framework to create a RESTful API.
- **Database:** **MongoDB** is used as the database, with **Mongoose** for object data modeling. This provides a flexible, schema-based solution for storing user and request data.
- **Core Logic:** The critical partial fulfillment and reassignment logic is handled on the backend. A **"parent-child" relationship** is established using a `parentRequestId` field in the `Request` model. This allows the system to track all parts of an original order and "roll up" the final status to `Confirmed` only when all sub-tasks are complete, providing a seamless experience for the end user.

---

## Setup Instructions

To run this project locally, you will need **Node.js**, the **Flutter SDK**, and a **MongoDB** instance (local or cloud-based like MongoDB Atlas).

### 1. Backend Setup

1.  **Navigate to the backend directory:**
    ```bash
    cd backend
    ```
2.  **Install dependencies:**
    ```bash
    npm install
    ```
3.  **Configure Environment Variables:**
    Open the `backend/index.js` file and replace the placeholder values for `DB` (your MongoDB connection string).
    ```javascript
    const DB = 'YOUR_MONGODB_CONNECTION_STRING';
    ```
4.  **Run the server:**
    ```bash
    nodemon index.js
    ```
    The server should now be running on `http://localhost:9000`.

### 2. Frontend (Flutter) Setup

1.  **Navigate to the project root:**
    From the `backend` directory, go back to the root:
    ```bash
    cd ..
    ```
2.  **Get Flutter dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Configure the API Connection:**
    - Find your computer's local network IP address (e.g., `192.168.1.5`).
    - Open the file `lib/app/core/constants/api_config.dart`.
    - Replace the placeholder IP with your actual IP address:
    ```dart
    class ApiConfig {
      // IMPORTANT: Replace with your actual IP address
      static const String baseUrl = '[http://192.168.1.5:9000/api](http://192.168.1.5:9000/api)';
    }
    ```
4.  **Run the app:**
    Connect a device or start an emulator and run:
    ```bash
    flutter run
    ```

---

## API Endpoints

The backend exposes the following RESTful API endpoints.

| Endpoint                       | Method | Description                                                                                              | Auth Required | Sample Body                                        |
| ------------------------------ | ------ | -------------------------------------------------------------------------------------------------------- | ------------- | -------------------------------------------------- |
| `/api/signup`                  | `POST` | Creates a new user account.                                                                              | No            | `{"email": "...", "password": "...", "role": "..."}` |
| `/api/login`                   | `POST` | Logs in a user and returns a JWT token.                                                                  | No            | `{"email": "...", "password": "..."}`                |
| `/api/requests`                | `POST` | Creates a new request. (End User only)                                                                   | Yes           | `{"items": [{"name": "Milk"}, {"name": "Bread"}]}`   |
| `/api/requests`                | `GET`  | Fetches requests based on user role.                                                                     | Yes           | N/A                                                |
| `/api/requests/:id/confirm`    | `POST` | Confirms/partially fulfills a request. (Receiver only)                                                   | Yes           | `{"confirmedItems": ["Milk", "Bread"]}`              |
