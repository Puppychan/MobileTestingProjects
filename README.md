# Testing Project
- This repository contains the iOS applications and problem 2 answers.
- This repository is done by [Nhung Tran](https://www.linkedin.com/in/nhungtr)
  <a href="https://github.com/Puppychan"><img src="https://github-readme-stats.vercel.app/api?username=Puppychan&theme=aura_dark&show_icons=true&count_private=true" alt="GitHub Readme Stats" /></a>
  
- Below is general project folder structure:
``` bash
MobileTestingProjects/
├── Problem1_Swift/             # Currency Converter Application
│   ├── CurrencyConverter/      # Currency Converter Application
├── Problem2a/                  # Problem 2a answers
├── Problem2b/                  # Problem 2b answers
├── Supporting/                 # For formatting currency list data from 2 sources by python file
│   ├── convert_currency_data.py
├── SupportingAttachments       # For storing images like Logo for the application
└── README.md                   # Project README file
```


# 📂 Problem 1: Currency Converter Application
A powerful and intuitive application to track currency exchange rates globally. With dynamic charts, error handling, and real-time updates, it is designed for users who need insights into currency trends with ease.

## 🚀 Key Features
- Global Currency Support: Track exchange rates of various currencies across the world.
- Dynamic Charts: Visualize trends with interactive and scrollable charts.
- Offline Support: Handles "No Internet Connection" gracefully with detailed error messages.
- Real-Time Updates: Fetch the latest currency rates on demand (rates are updated every one hour).
- User-Friendly UI: Clean and responsive design for seamless user experience.

## 🛠️ Tech Stack
### Application
- **Swift** - Programming language for iOS app development.
- **SwiftUI** - Declarative UI framework for building user interfaces.
- **Swift Charts** - Library for creating beautiful charts in SwiftUI.
### API
- **FXRates API** - API for fetching currency exchange rates.
  - Link: [https://fxratesapi.com/](https://fxratesapi.com/)
- 

## 📍 Installation Prerequisites
Please ensure your system meets the following requirements before running the application:
### System Requirements
- Xcode 15+: Make sure you have the latest version of Xcode installed.
- macOS Sonoma (14.0)+: Compatible with macOS 14.0 or higher.
- Swift 5+: Supports Swift 5 or later.

### Running the Application
- iOS 17.0+: Supports iPhone devices running iOS 17 or later.

## 📦 Installation Guide
### Step 1: Clone the Repository
```bash
git clone https://github.com/Puppychan/MobileTestingProjects
cd Problem1_Swift/CurrencyConverter
```
### Step 2: Open the Project
Open the CurrencyRatesTracker.xcodeproj file in Xcode.
### Step 3: Validate iOS Version on XCode
Ensure that the project is set to run on an iOS device with version 17.0 or higher.
### Step 4: Build and Run
- Select your desired simulator or connected device in Xcode.
- Press Command + R to build and run the app.

## 🧑‍💻 How It Works
- (Optional) Running python file `convert_currency_data.py` in Supporting folder from root of the project to generate and format currency json file based on currencies data of 2 sources:
  - [Github](https://gist.githubusercontent.com/ibrahimhajjaj/a0e39e7330aebf0feb49912f1bf9062f/raw/d160e7d3b0e11ea3912e97a1b3b25b359746c86a/currencies-with-flags.json)
  - [FXRates API](https://fxratesapi.com/)
  *Because currency data from main API is not having flag, so I need to merge it with the data from the first source.*
- Read static JSON file for rendering currency list
- Fetch Data: The app fetches real-time currency rates from a remote API (Fxratesapi).
- Visualize Trends: Exchange rates are normalized and displayed in dynamic charts.
- Error Handling: Users are notified if the app cannot fetch data due to connectivity or other issues.

## 📁 Folder Structure
``` bash
CurrencyConverter/
├── Assets/               # App assets (e.g., images, colors, fonts)
│   ├── Data/             # Storing static JSON data
├── Helpers/              # Supporting reusable functional and helpers files
│   ├── Enum/             # Storing enum files for the app
│   ├── ViewModifier/     # Storing reusable view modifier files
├── Utilities/            # Helper functions and utilities (e.g., API calls, date formatting, network manager) that can be reused in other projects
├── Views/                # SwiftUI views for rendering UI
│   ├── Components/       # Reusable UI components (e.g., ErrorView ProgressView)
│   │   ├── Charts/       # Contains reusable chart components
│   │   ├── Currency/     # Contains reusable components relevant to currency
│   │   ├── SettingView/  # Contains setting view components and sections
│   │   ├── Card/         # Contains reusable card components for displaying data
│   ├── Screens/          # Main screens like Home, Settings, etc.
├── Models/               # Data models for the app (e.g., ExchangeRate, Currency)
│   │   ├── Response/     # For defining models for API response
└── ViewModels/           # ViewModels for managing app state and logic
```

## 📝 Additional Notes
### Reference
- Currencies having Flag: https://gist.githubusercontent.com/ibrahimhajjaj/a0e39e7330aebf0feb49912f1bf9062f/raw/d160e7d3b0e11ea3912e97a1b3b25b359746c86a/currencies-with-flags.json

### Future Enhancements
- Add more user interactions and animations to enhance the user experience.
- Implement a search feature to allow users to search for specific currencies in the past.

# 📂 Problem 2: Testing Code
This section contains the answers to Problem 2a and Problem 2b.
## Problem 2a
- Folder explanation:
  - **problem2a.py**: main file for problem 2a
  - **helpers**: define helpers functions handling business logic for solving the problem
  - **product_model**: define Product class
  - **product_menu**: building menu for user to interact with the program and improve user experience
- To run:
  - On MacOs:
    - Open the terminal
    - From root of the project, run `cd Problem2a`
    - `python3.10 problem2a.py`

## Problem 2b
- Folder explanation:
  - **problem2b.py**: main file for problem 2b
- To run:
  - On MacOs: 
    - Open the terminal
    - From root of the project, run `cd Problem2b`
    - `python3.10 problem2b.py`

## Supporting folder
- Folder explanation:
  - **convert_currency_data.py**: Python file to convert and format currency data from 2 sources
  - **flag_currencies.json**: JSON file containing currency data with flag - from FXRates API
  - **rendered_currencies.json**: JSON file containing currency data with flag - from Github
  => **final_currencies.json**: JSON file containing merged currency data from 2 sources - used in the application
- To run:
  - On MacOs:
    - Open the terminal
    - From root of the project, run `cd Supporting`
    - `python3.10 convert_currency_data.py`