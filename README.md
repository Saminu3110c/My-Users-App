# Welcome to My Users App
***

## Task
The task is to implement a User Management application using the MVC (Model-View-Controller) architecture.
The application will allow you to create, read, update, and delete users stored in a SQLite database. 
Additionally, the application provides routes for user authentication and a web interface to display users.

## Description
The application is built with Ruby and uses Sinatra as the web framework. The SQLite3 gem is used for database management. The application includes:

- A User model to handle database operations.
- A Controller to manage HTTP requests and responses.
- Views to render HTML pages.

### User Model
The `User` class provides methods to interact with the SQLite database:
- `create(user_info)`: Creates a new user.
- `find(user_id)`: Finds a user by ID.
- `all`: Retrieves all users.
- `update(user_id, attribute, value)`: Updates a user's attribute.
- `destroy(user_id)`: Deletes a user by ID.

### Controller
The Sinatra application provides several routes:
- `GET /users`: Returns all users (excluding passwords).
- `POST /users`: Creates a new user.
- `POST /sign_in`: Authenticates a user.
- `PUT /users`: Updates the logged-in user's password.
- `DELETE /sign_out`: Logs out the current user.
- `DELETE /users`: Deletes the logged-in user.
- `GET /`: Renders the index page showing all users.

### Views
The application uses ERB templates for rendering HTML. The main view displays a table of all users.

## Installation
To install the project, follow these steps:

1. Clone the repository:
    ```bash
    git clone the-repo-url.git
    cd the-repo-name
    ```

2. Install the dependencies using Bundler:
    ```bash
    gem install bundler
    bundle install
    ```

## Usage
To start the server, run:
```bash
bundle exec ruby app.rb -p 8080 -o 0.0.0.0
```


### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering Schools Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
