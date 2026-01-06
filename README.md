# 🚀 SDET Automation Showcase: Robot Framework E2E Testing

This repository demonstrates my capabilities as a **Software Development Engineer in Test (SDET)** by implementing a robust, maintainable, and scalable end-to-end (E2E) automation suite using the **Robot Framework**.

The project covers both **API testing** and **UI testing** for the Restful Booker application, showcasing comprehensive testing approaches including BDD (Behavior-Driven Development) with Gherkin syntax for UI tests.

## ✨ Key Skills Demonstrated

| Feature | Description | SDET Value |
| :--- | :--- | :--- |
| **Robot Framework** | Utilizes the BDD-style, English-like syntax for high test readability. | Promotes **collaboration** between QA, Dev, and Product teams. |
| **API Testing** | REST API testing with RequestsLibrary for backend validation, including comprehensive auth token testing. | Ensures **API reliability** and **authentication security**. |
| **UI Testing** | Web UI automation with SeleniumLibrary and BDD Gherkin style. | Validates **user experience** and **frontend functionality**. |
| **Authentication Testing** | Comprehensive token creation, validation, and usage testing. | Ensures **security** and **session management** work correctly. |
| **Keyword-Driven Testing** | Custom, high-level keywords abstract away implementation details. | Facilitates creation of complex flows with minimal code changes. |
| **Robust Reporting** | Leverages built-in HTML reports and logs for quick test analysis. | Essential for **debugging** and providing status updates in CI/CD. |
| **Environment Setup** | Clear `requirements.txt` and project structure for easy deployment. | **CI/CD Readiness** and team adoption. |
| **BDD with Gherkin** | Given/When/Then syntax for UI tests to improve readability and stakeholder communication. | Enhances **test clarity** and **business alignment**. |

## 🛠 Project Scope & Technologies

The suite automates login functionality for the Restful Booker application, covering both API endpoints and web UI.

* **Automation Tool:** Robot Framework (Python)
* **API Testing Library:** `RequestsLibrary`
* **Web Automation Library:** `SeleniumLibrary`
* **Design Pattern:** Consolidated resource file with reusable keywords
* **Testing Approaches:** API testing + UI testing with BDD Gherkin
* **Target Application:** [**Restful Booker**](https://restful-booker.herokuapp.com/) - Hotel booking API and web interface

## 📋 Getting Started

Follow these steps to clone the repository, set up the environment, and run the tests locally.

### 1. Prerequisites

* Python (3.8+)
* Git
* Google Chrome (for UI tests)

### 2. Clone the Repository

```bash
git clone [https://github.com/](https://github.com/)[Your-GitHub-Username]/[Your-Repo-Name].git
cd [Your-Repo-Name]
````

### 3\. Setup Virtual Environment

It is highly recommended to use a Python virtual environment to manage dependencies.

```bash
# Create the virtual environment
python -m venv venv

# Activate the virtual environment
# On Windows:
.\venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
```

### 4\. Install Dependencies

Install all required Robot Framework libraries from the `requirements.txt` file.

```bash
pip install -r requirements.txt
```

## ▶️ How to Run the Test Suite

The tests can be executed directly from the command line using the `robot` command.

### Running All Tests

To run the entire suite in the `tests/` directory:

```bash
robot tests/
```

### Running Specific Test Types

```bash
# Run only API tests
robot tests/test_login_api.robot

# Run only UI tests
robot tests/test_login_ui.robot
```

### Running Tests by Tag

Tests are organized using tags (e.g., `Smoke`, `API`, `UI`, `BDD`).

```bash
# Run only API tests
robot --include API tests/

# Run only UI tests
robot --include UI tests/

# Run only smoke tests
robot --include Smoke tests/
```

The test suite covers login functionality across two testing dimensions:

### API Tests (`test_login_api.robot`)
- **Basic Authentication**: Validates successful login with correct credentials
- **Security Validation**: Ensures proper error handling for invalid credentials
- **Token Creation**: Verifies auth tokens are properly generated and formatted
- **Token Usage**: Tests that tokens can be used in subsequent API requests
- **Token Persistence**: Confirms tokens work across multiple API calls
- **Token Security**: Ensures invalid credentials never return tokens

### UI Tests (`test_login_ui.robot`)
- **BDD Gherkin Style**: Uses Given/When/Then syntax for improved readability
- **Successful Login**: Verifies web UI login with valid credentials
- **Invalid Credentials**: Tests error handling in the web interface
- **Isolated Test Execution**: Each test runs in a fresh browser instance

## 📊 Reporting

After execution, Robot Framework automatically generates comprehensive reports in the root directory:

  * **`log.html`**: Detailed execution log.
  * **`report.html`**: Summary report of all test runs (open this in your browser).
  * **`output.xml`**: Raw XML output file.

## 📁 Project Structure

The automation code is organized for maximum maintainability and clarity:

```
.
├── libraries/                    # Python variables and configurations
│   └── common_variables.py       # Application URLs and credentials
├── resources/                    # Consolidated resource file with all keywords
│   └── common.resource           # API, UI, and BDD keywords
├── tests/                        # Main Test Cases
│   ├── test_login_api.robot      # API login tests
│   └── test_login_ui.robot       # UI login tests (BDD Gherkin style)
├── drivers/                      # Browser drivers (if needed)
├── libraries/                    # Python utility modules
│   └── browser_setup.py          # Chrome options configuration
├── requirements.txt              # Python dependencies
├── results/                      # Test execution results (generated)
│   ├── log.html
│   ├── report.html
│   └── output.xml
└── README.md
```
