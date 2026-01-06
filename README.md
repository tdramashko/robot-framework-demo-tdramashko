# 🚀 SDET Automation Showcase: Robot Framework E2E Testing with Page Object Model

This repository demonstrates my capabilities as a **Software Development Engineer in Test (SDET)** by implementing a robust, maintainable, and scalable end-to-end (E2E) automation suite using the **Robot Framework** with **Page Object Model (POM)** architecture.

The project covers both **API testing** and **UI testing** for the Restful Booker application, showcasing comprehensive testing approaches including BDD (Behavior-Driven Development) with Gherkin syntax for UI tests and enterprise-grade POM structure for maintainable automation.

## ✨ Key Skills Demonstrated

| Feature | Description | SDET Value |
| :--- | :--- | :--- |
| **Robot Framework** | Utilizes the BDD-style, English-like syntax for high test readability. | Promotes **collaboration** between QA, Dev, and Product teams. |
| **Page Object Model (POM)** | Enterprise-grade POM architecture with separate page objects, common keywords, and business workflows. | Ensures **maintainability**, **scalability**, and **code reusability**. |
| **Clear Architecture Documentation** | Comprehensive ARCHITECTURE.md and well-documented resource hierarchy. | **Single entry point** design enables easy maintenance and onboarding. |
| **API Testing** | REST API testing with RequestsLibrary for backend validation, including comprehensive auth token testing. | Ensures **API reliability** and **authentication security**. |
| **UI Testing** | Web UI automation with SeleniumLibrary and BDD Gherkin style. | Validates **user experience** and **frontend functionality**. |
| **Authentication Testing** | Comprehensive token creation, validation, and usage testing. | Ensures **security** and **session management** work correctly. |
| **Keyword-Driven Testing** | Custom, high-level keywords abstract away implementation details. | Facilitates creation of complex flows with minimal code changes. |
| **Business Workflow Testing** | End-to-end workflows covering complete user journeys and admin operations. | Validates **business processes** and **user scenarios**. |
| **Data-Driven Testing** | Multiple approaches: inline data tables, CSV files, and dynamic data generation. | Maximizes test coverage with minimal code duplication. |
| **Robust Reporting** | Leverages built-in HTML reports and logs for quick test analysis. | Essential for **debugging** and providing status updates in CI/CD. |
| **BDD with Gherkin** | Given/When/Then syntax for UI tests to improve readability and stakeholder communication. | Enhances **test clarity** and **business alignment**. |

## 🛠 Project Scope & Technologies

The suite automates comprehensive functionality for the Restful Booker application, covering API endpoints, web UI, and business workflows using enterprise-grade Page Object Model architecture.

* **Automation Tool:** Robot Framework (Python)
* **API Testing Library:** `RequestsLibrary`
* **Web Automation Library:** `SeleniumLibrary`
* **Design Pattern:** Page Object Model (POM) with separate page objects, common keywords, and business workflows
* **Testing Approaches:** API testing + UI testing with BDD Gherkin + End-to-End workflow testing
* **Target Application:** [**Restful Booker**](https://restful-booker.herokuapp.com/) - Hotel booking API and web interface
* **Architecture:** Modular POM structure with reusable components and business logic separation

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

# Run POM-based booking tests
robot tests/test_booking_pom.robot
```

### Running Tests by Tag

Tests are organized using tags (e.g., `Smoke`, `API`, `UI`, `BDD`, `booking`, `pom`, `workflow`).

```bash
# Run only API tests
robot --include API tests/

# Run only UI tests
robot --include UI tests/

# Run only smoke tests
robot --include Smoke tests/

# Run POM-based tests
robot --include pom tests/

# Run booking workflow tests
robot --include booking tests/
```

The test suite covers comprehensive functionality across three testing dimensions:

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

### POM-Based Booking Tests (`test_booking_pom.robot`)
- **Complete Booking Workflow**: End-to-end room booking using POM architecture
- **Contact Inquiry Integration**: Booking combined with contact form submission
- **Admin Management Workflows**: Admin panel operations for booking and room management
- **Form Validation Testing**: Contact form validation using page objects
- **Multi-Room Scenarios**: Complex booking scenarios with multiple rooms
- **Business Process Validation**: Complete user journeys and admin operations

### Admin Page Framework Tests (`test_admin_page.robot`)
- **Admin Login Framework**: Demonstrates admin authentication POM structure
- **Dashboard Framework**: Shows admin dashboard statistics and verification methods
- **Booking Management Framework**: Illustrates CRUD operations for booking administration
- **Room Management Framework**: Demonstrates room inventory management operations
- **Search Functionality Framework**: Shows admin search and filtering capabilities

## � Test Execution & Results

### Current Test Status
- **Total Tests**: 31 tests across 5 test files ✅
- **Pass Rate**: 100% (31 passed, 0 failed)
- **Test Coverage**: API authentication, UI login, data-driven testing, comprehensive booking workflows, and admin panel framework
- **Architecture**: Page Object Model with hierarchical, maintainable structure

### Test Distribution
- **API Tests** (`test_login_api.robot`): 8 tests - Authentication and token management
- **Data-Driven Tests** (`test_data_driven.robot`): 5 tests - Multiple data-driven approaches
- **UI Tests** (`test_login_ui.robot`): 3 tests - Web interface login with BDD Gherkin
- **POM Booking Tests** (`test_booking_pom.robot`): Multiple tests - Comprehensive booking workflows
- **Admin Page Tests** (`test_admin_page.robot`): Multiple tests - Admin panel POM framework demonstration

### Execution Command
```bash
# Run all tests
robot tests/

# Run with custom output directory
robot -d results tests/
```

## �📊 Reporting

After execution, Robot Framework automatically generates comprehensive reports in the root directory:

  * **`log.html`**: Detailed execution log.
  * **`report.html`**: Summary report of all test runs (open this in your browser).
  * **`output.xml`**: Raw XML output file.

## 📁 Project Structure

The automation code is organized using **Page Object Model (POM)** architecture with a clear hierarchical reference structure for maximum maintainability, scalability, and reusability:

```
.
├── ARCHITECTURE.md               # Complete architecture documentation (READ THIS!)
├── libraries/                    # Python variables and configurations
│   ├── common_variables.py       # Application URLs and credentials
│   └── browser_setup.py          # Chrome options configuration
├── resources/                    # Robot Framework resources (POM structure)
│   ├── common.resource           # ⭐ CENTRAL HUB - Single import point for all tests
│   ├── pages/                    # 📄 PAGE OBJECTS - Page-specific keywords & locators
│   │   ├── HomePage.robot        # Home page interactions
│   │   ├── BookingPage.robot     # Booking form interactions
│   │   ├── AdminPage.robot       # Admin panel operations
│   │   └── ContactPage.robot     # Contact form interactions
│   ├── common/                   # 🔧 COMMON UTILITIES - Reusable keywords
│   │   ├── NavigationCommon.robot     # Shared navigation functionality
│   │   ├── VerificationCommon.robot   # Common verification methods
│   │   └── DataSetupCommon.robot      # Test data generation and setup
│   └── workflows/                # 🚀 BUSINESS WORKFLOWS - Complex multi-step processes
│       └── BookingWorkflow.robot # End-to-end booking processes
├── tests/                        # 🧪 TEST CASES - Test scenarios
│   ├── test_login_api.robot           # API login tests
│   ├── test_data_driven.robot         # Data-driven testing approaches
│   ├── test_login_ui.robot            # UI login tests (BDD Gherkin)
│   ├── test_booking_pom.robot         # POM-based booking tests
│   └── test_admin_page.robot          # Admin page framework tests
├── drivers/                      # Browser drivers (if needed)
├── data/                         # Test data files
│   └── login_credentials.csv     # Login test data
├── requirements.txt              # Python dependencies
├── results/                      # Test execution results (generated)
│   ├── log.html
│   ├── report.html
│   └── output.xml
└── README.md                     # This file
```

### Resource Import Hierarchy
```
TEST FILES (tests/*.robot)
    │
    └─→ Resource: common.resource (SINGLE ENTRY POINT)
            │
            ├─→ Libraries
            ├─→ Page Objects (pages/*.robot)
            ├─→ Common Utilities (common/*.robot)
            ├─→ Workflows (workflows/*.robot)
            └─→ Variables (Python)
```

## 📚 Architecture & Design Documentation

This project implements a **clear, hierarchical reference structure** with comprehensive documentation:

### **Architecture Reference**
See [**ARCHITECTURE.md**](ARCHITECTURE.md) for:
- **Visual hierarchy** of all resource imports
- **Layer definitions** and responsibilities
- **Import chain** from tests to all resources
- **Best practices** and design principles
- **How to extend** the framework safely

### **Key Architectural Features**
- **Single Entry Point**: All tests import only `common.resource` for unified access
- **Layered Design**: Separation into Libraries → Pages → Utilities → Workflows → Variables
- **No Circular Imports**: Clean dependency flow throughout the project
- **Self-Documenting**: Each resource file includes clear purpose documentation

## 🚀 Enhancements & Current State

### ✨ Implemented Architecture Improvements
- ✅ **Central Hub Design**: `common.resource` serves as single entry point
- ✅ **Clear Documentation**: All resource files include purpose and reference documentation
- ✅ **Architecture Guide**: Comprehensive `ARCHITECTURE.md` explains the entire structure
- ✅ **Layered Organization**: Proper separation into Pages → Utils → Workflows
- ✅ **No Circular Imports**: Clean dependency flow throughout project
- ✅ **Self-Documenting**: Each file clearly documents what it provides and where it's used
- ✅ **Data-Driven Testing**: Multiple approaches demonstrated (inline, CSV, dynamic generation)
- ✅ **All Tests Passing**: 31/31 tests passing (100% success rate)

### Future Enhancements

This POM architecture provides a solid foundation for extending the test automation suite:

#### **Planned Extensions**
- **Additional Page Objects**: Extend coverage to all Restful Booker application features
- **API Workflow Tests**: Comprehensive API-only business process testing
- **Performance Testing**: Integration with performance testing tools
- **Cross-Browser Testing**: Multi-browser execution support
- **CI/CD Integration**: Automated test execution in CI/CD pipelines
- **Parallel Execution**: Configure tests to run in parallel for faster results

### Contributing

To extend this framework following the established architecture:

1. **Add a New Page Object**:
   - Create `resources/pages/NewPage.robot`
   - Add locators in `*** Variables ***` section
   - Add keywords in `*** Keywords ***` section
   - Import in `common.resource`

2. **Add a New Utility Keyword**:
   - Add to appropriate file in `resources/common/`
   - Already imported via `common.resource`

3. **Add a New Workflow**:
   - Create `resources/workflows/NewWorkflow.robot`
   - Import needed resources
   - Add complex keywords combining multiple steps
   - Import in `common.resource`

4. **Add Test Cases**:
   - Create `tests/test_new_feature.robot`
   - Import only `common.resource`
   - Write test scenarios

### Best Practices Demonstrated

✅ **Modular Design** - Clear separation of concerns across layers
✅ **DRY Principle** - Don't Repeat Yourself with reusable keywords
✅ **Maintainable Code** - Easy to update when UI changes
✅ **Scalable Architecture** - Simple to extend with new features
✅ **Professional Standards** - Enterprise-grade test automation structure
✅ **Single Responsibility** - Each file has one clear purpose
✅ **Documented Dependencies** - Clear import hierarchy and references
✅ **Self-Sustaining** - Architecture guides future development
