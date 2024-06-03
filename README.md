# Rent a Tool

Rent a Tool is a full-stack application designed to create a platform where users can rent tools and equipment from their neighbors. This application leverages Flutter for the client-side and Flask microservices for the backend.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Backend Setup](#backend-setup)
- [Frontend Setup](#frontend-setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features

- User Authentication: Secure login and registration system.
- Tool Listing: Users can list tools they want to rent out.
- Search and Filter: Find tools based on category, availability, and location.
- Booking System: Rent tools for specific periods.
- User Profiles: Manage personal information and rental history.
- Notifications: Stay updated with rental status and reminders.
- **Real-Time Chat**: Communicate with tool owners using instant messaging.

## Technologies Used

### Client

- **Flutter**: For building cross-platform mobile applications.
- **Dart**: The programming language used by Flutter.

### Server

- **Flask**: A micro web framework for Python.
- **SQLAlchemy**: An ORM for database interactions.
- **PostgreSQL**: The database system.
- **Redis**: For caching and message brokering.
- **Socket.IO**: For real-time, bidirectional communication.

## Architecture

The application is designed using a microservices architecture. The backend consists of multiple Flask services, each responsible for different aspects of the application, such as user management, tool listings, booking, and chat. The frontend is a Flutter application that communicates with these microservices through RESTful APIs and WebSockets.

### High-Level Diagram

```
+------------+      +------------------+      +------------+
|  Flutter   |<---> |  API Gateway     |<---> |  Flask     |
|  Client    |      |  (Flask)         |      |  Services  |
+------------+      +------------------+      +------------+
   |  ^                |      ^            /        |  
   |  |                |      |           /         |  
   v  |                v      |          /          v  
+------------+      +------------------+           +------------+
| WebSocket  |<-->  |  Chat Service    |<--->      |  Flask     |
|  Client    |      |  (Socket.IO)     |           |  Services  |
+------------+      +------------------+           +------------+
                                         |
                                    +----+----+
                                    | Database |
                                    +----------+
```

## Getting Started

### Prerequisites

- Flutter SDK
- Python 3.10+
- PostgreSQL
- Redis

### Backend Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/danielgof/RT.git
    cd RT/server
    ```

2. Create a virtual environment and activate it:

    ```bash
    python3 -m venv venv
    source venv/bin/activate
    ```

3. Install the dependencies:

    ```bash
    pip install -r requirements.txt
    ```

4. Run the application:

    ```bash
    ./server.sh
    ```

### Frontend Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/danielgof/RT.git
    cd RT client
    ```

2. Get the Flutter packages:

    ```bash
    flutter pub get
    ```

3. Run the Flutter application:

    ```bash
    flutter run
    ```

## Usage

1. Register a new account or log in with existing credentials.
2. Browse the available tools or list a new tool for rent.
3. Use the search and filter options to find specific tools.
4. Book a tool for a specified period.
5. Manage your rentals and profile information through the user dashboard.
6. Chat with tool owners or renters using the real-time messaging feature.

## Contributing

Contributions are welcome! Please fork the repository and use a feature branch. Pull requests are accepted.

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
