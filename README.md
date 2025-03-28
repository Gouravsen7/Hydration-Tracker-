# Hydration Tracking System

## Overview
This is a **Hydration Tracking System** built with **Ruby on Rails** and **Tailwind CSS**. It allows users to log their beverage intake, track symptoms, and receive personalized hydration recommendations.

## Features
- **Multi-step Beverage Logging** (with category, subcategory, quantity, temperature, and notes)
- **Symptom Tracking** (severity, timing, and details)
- **Confirmation Pop-up Before Submission**
- **Calorie Estimation on Submission Page**
- **Personalized Hydration & GI Health Tips**
- **Google Authentication for User Login**

## Setup Instructions

### Prerequisites
Ensure you have the following installed:
- Ruby (>= 3.0)
- Rails (>= 7.0)
- PostgreSQL
- Node.js & Yarn

### Installation Steps

1. **Clone the Repository**
   ```sh
   git clone https://github.com/your-username/hydration-tracker.git
   cd hydration-tracker
   ```

2. **Install Dependencies**
   ```sh
   bundle install
   yarn install
   ```

3. **Setup Database**
   - Open `config/database.yml`
   - Update it with your local PostgreSQL username and password
   - Then run:
     ```sh
     rails db:create db:migrate db:seed
     ```

4. **Setup Google Authentication**
   - Register your app with **Google Developer Console** to get OAuth credentials
   - Add your credentials to `config/credentials.yml.enc` or `ENV` variables:
     ```sh
     GOOGLE_CLIENT_ID: your_google_client_id
     GOOGLE_CLIENT_SECRET: your_google_client_secret
     ```
   - Ensure the **callback URL** is set to:
     ```sh
     /users/auth/google_oauth2/callback
     ```

5. **Run the Rails Server**
   ```sh
   rails assets:precompile && rails server
   ```

6. **Access the App**
   Open `http://localhost:3000` in your browser.

## Usage
- **Log a new beverage** from the dashboard.
- **Track symptoms** if any occur after drinking.
- **View your hydration summary** on the dashboard.

## Contributing
Pull requests are welcome. For major changes, please open an issue first.

## License
MIT License.

# Hydration-Tracker