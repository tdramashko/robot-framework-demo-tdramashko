# 🚀 SDET Automation Showcase: Robot Framework E2E Testing

This repository demonstrates my capabilities as a **Software Development Engineer in Test (SDET)** by implementing a robust, maintainable, and scalable end-to-end (E2E) automation suite using the **Robot Framework**.

The project adheres strictly to modern automation best practices, providing a clear illustration of technical proficiency in creating reliable and readable test automation.

## ✨ Key Skills Demonstrated

| Feature | Description | SDET Value |
| :--- | :--- | :--- |
| **Robot Framework** | Utilizes the BDD-style, English-like syntax for high test readability. | Promotes **collaboration** between QA, Dev, and Product teams. |
| **Page Object Model (POM)** | Structured organization of element locators and page-specific actions. | Ensures **maintainability** and **reusability** of test components. |
| **Keyword-Driven Testing** | Custom, high-level keywords abstract away implementation details. | Facilitates creation of complex flows with minimal code changes. |
| **Robust Reporting** | Leverages built-in HTML reports and logs for quick test analysis. | Essential for **debugging** and providing status updates in CI/CD. |
| **Environment Setup** | Clear `requirements.txt` and project structure for easy deployment. | **CI/CD Readiness** and team adoption. |

## 🛠 Project Scope & Technologies

The current suite focuses on automating core user flows for a sample web application (e.g., a public e-commerce or utility site).

* **Automation Tool:** Robot Framework (Python)
* **Web Automation Library:** `SeleniumLibrary`
* **Design Pattern:** Page Object Model (POM)
* **Target Application:** [**Placeholder: Insert URL of the application being tested, e.g., `https://www.saucedemo.com/`**]

## 📋 Getting Started

Follow these steps to clone the repository, set up the environment, and run the tests locally.

### 1. Prerequisites

* Python (3.8+)
* Git

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

### Running Specific Tests by Tag

Tests are organized using tags (e.g., `Smoke`, `Regression`).

```bash
# Run only tests tagged 'Smoke'
robot --include Smoke tests/
```

### Running a Specific File

```bash
robot tests/LoginTests.robot
```

## 📊 Reporting

After execution, Robot Framework automatically generates comprehensive reports in the root directory:

  * **`log.html`**: Detailed execution log.
  * **`report.html`**: Summary report of all test runs (open this in your browser).
  * **`output.xml`**: Raw XML output file.

## 📁 Project Structure

The automation code is organized for maximum maintainability and clarity:

```
.
├── resources/           # Implements the Page Object Model (POM)
│   ├── LoginPage.robot  # Keywords and locators for the Login Page
│   └── Common.robot     # Setup, Teardown, and common helper keywords
├── tests/               # Main Test Cases that define the user journey
│   ├── SmokeTests.robot
│   └── Regression/
│       └── CheckoutFlow.robot
├── drivers/             # Stores necessary browser drivers (e.g., chromedriver)
├── requirements.txt     # List of all Python dependencies
└── README.md
```
