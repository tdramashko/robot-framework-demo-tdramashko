# Project Architecture & Reference Structure

## Overview
This project follows a **Page Object Model (POM)** architecture with clear separation of concerns and a hierarchical reference structure.

---

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────────┐
│                          TEST CASES                             │
│         (tests/test_*.robot - All test files)                   │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────────┐
        │  common.resource (Central Hub)     │
        │  ▪ Imports all resources           │
        │  ▪ Single entry point for all      │
        │    test imports                    │
        └────────────────────────────────────┘
                         │
         ┌───────────────┼───────────────┐
         │               │               │
         ▼               ▼               ▼
    ┌─────────┐   ┌──────────┐   ┌──────────────┐
    │Libraries│   │Page      │   │Common        │
    │         │   │Objects   │   │Utilities     │
    │ • Req   │   │          │   │              │
    │ • Sel   │   │HomePage  │   │Navigation    │
    │         │   │Booking   │   │Verification  │
    │         │   │Admin     │   │Data Setup    │
    │         │   │Contact   │   │              │
    └─────────┘   └──────────┘   └──────────────┘
                                       │
                                       ▼
                                  ┌──────────────┐
                                  │ Workflows    │
                                  │              │
                                  │Booking       │
                                  │Workflow      │
                                  └──────────────┘
```

---

## File Structure & References

### 1. **Test Layer** (`tests/`)
All test files import from `common.resource`:
- `test_login_api.robot` → API testing
- `test_login_ui.robot` → UI testing with Gherkin syntax
- `test_booking_pom.robot` → POM-based booking workflows
- `test_admin_page.robot` → Admin panel testing
- `test_data_driven.robot` → Data-driven testing approaches

**Reference Flow:**
```
test_*.robot
    ↓
Resource: ../resources/common.resource
    ↓
(Automatically pulls all resources)
```

---

### 2. **Central Hub** (`resources/common.resource`)
**Purpose:** Single point of entry for all resource imports

**Imports (Ordered by Layer):**

#### Libraries
```robot
Library  RequestsLibrary    # API testing
Library  SeleniumLibrary    # Web automation
```

#### Page Objects
```robot
Resource  ../resources/pages/HomePage.robot
Resource  ../resources/pages/BookingPage.robot
Resource  ../resources/pages/AdminPage.robot
Resource  ../resources/pages/ContactPage.robot
```

#### Common Utilities
```robot
Resource  ../resources/common/NavigationCommon.robot      # Navigation keywords
Resource  ../resources/common/VerificationCommon.robot    # Verification keywords
Resource  ../resources/common/DataSetupCommon.robot       # Data generation keywords
```

#### Business Workflows
```robot
Resource  ../resources/workflows/BookingWorkflow.robot    # Complex workflows
```

#### Variables
```robot
Variables  ../libraries/common_variables.py               # Environment config
```

---

### 3. **Page Objects** (`resources/pages/`)
Each page has its own resource file with:
- **Page-Specific Locators** (Variables section)
- **Page-Specific Keywords** (Keywords section)

**Files:**
- `HomePage.robot` - Home page locators & keywords
- `BookingPage.robot` - Booking form locators & keywords
- `AdminPage.robot` - Admin panel locators & keywords
- `ContactPage.robot` - Contact page locators & keywords

**Reference Flow:**
```
common.resource
    ↓
HomePage.robot, BookingPage.robot, AdminPage.robot, ContactPage.robot
    ↓
Used by tests (via common.resource)
```

---

### 4. **Common Utilities** (`resources/common/`)
Reusable keywords that don't belong to a specific page.

#### NavigationCommon.robot
- Base navigation keywords
- Examples: `Navigate To Home Page`, `Go To Login Page`, `Go To Admin Panel`
- Used by: Page objects, tests, workflows

#### VerificationCommon.robot
- General assertion/verification keywords
- Examples: `Verify Element Is Visible`, `Verify Page Contains Text`
- Used by: Tests, page objects, workflows

#### DataSetupCommon.robot
- Test data creation and generation
- Examples: `Create Test User`, `Generate Random String`, `Create Test Booking Data`
- Used by: Tests, workflows

**Reference Flow:**
```
common.resource
    ↓
NavigationCommon.robot
VerificationCommon.robot
DataSetupCommon.robot
    ↓
Used by tests (via common.resource)
```

---

### 5. **Business Workflows** (`resources/workflows/`)
Complex multi-step workflows that combine page objects and utilities.

#### BookingWorkflow.robot
- Complete booking processes
- Examples: `Complete Room Booking Process`, `Book Room With API And Verify UI`
- Imports all necessary resources for full access

**Reference Flow:**
```
BookingWorkflow.robot
    ↓
Imports all resources needed
    (common.resource + direct page/utility imports)
    ↓
Combines multiple keywords into workflows
    ↓
Used by booking tests
```

---

### 6. **Variables** (`libraries/`)

#### common_variables.py
Environment-specific configuration:
- `URL` - API base URL
- `UI_URL` - Web application URL
- `BROWSER` - Browser selection
- `USERNAME`, `PASSWORD` - Test credentials
- `UI_USERNAME`, `UI_PASSWORD` - UI credentials

**Imported by:** `common.resource` → Available to all tests

---

## Import Hierarchy

```
TEST FILES
    │
    └─→ Resource: common.resource
            │
            ├─→ Library: RequestsLibrary
            ├─→ Library: SeleniumLibrary
            │
            ├─→ HomePage.robot
            ├─→ BookingPage.robot
            ├─→ AdminPage.robot
            ├─→ ContactPage.robot
            │
            ├─→ NavigationCommon.robot
            ├─→ VerificationCommon.robot
            ├─→ DataSetupCommon.robot
            │
            ├─→ BookingWorkflow.robot
            │   └─→ (Also imports key resources)
            │
            └─→ Variables: common_variables.py
```

---

## Design Principles

### 1. **Single Responsibility**
- **Page Objects:** Only page-specific locators & keywords
- **Common Utilities:** Only reusable, generic keywords
- **Workflows:** Complex multi-step business processes
- **Tests:** Only test logic & assertions

### 2. **DRY (Don't Repeat Yourself)**
- Common keywords in `common/` directory
- Reusable workflows in `workflows/` directory
- Shared locators in page objects

### 3. **POM (Page Object Model)**
- Each page = separate resource file
- Locators centralized in each page file
- Page keywords abstract implementation details
- Easy to maintain when UI changes

### 4. **Hierarchical Resources**
- Central hub (`common.resource`) imports everything
- Tests only import the central hub
- Changes to resource organization only require hub update
- Clear dependency flow

---

## Reference Example

### How a test uses the complete structure:

```robot
*** Settings ***
Resource    ../resources/common.resource    # Single import!

*** Test Cases ***
Book A Room Successfully
    # Uses HomePage keyword (from common.resource → HomePage.robot)
    Go To Home Page
    
    # Uses BookingPage keyword (from common.resource → BookingPage.robot)
    Fill Booking Form    ${booking_data}
    
    # Uses WorkFlow keyword (from common.resource → BookingWorkflow.robot)
    ${booking_id}=    Complete Room Booking Process    ${booking_data}
    
    # Uses Verification keyword (from common.resource → VerificationCommon.robot)
    Verify Booking Confirmation
```

**Reference chain:**
```
test_booking_pom.robot
    ↓
Resource: ../resources/common.resource
    ↓
    ├─ Go To Home Page ← from HomePage.robot ← via common.resource
    ├─ Fill Booking Form ← from BookingPage.robot ← via common.resource
    ├─ Complete Room Booking Process ← from BookingWorkflow.robot ← via common.resource
    └─ Verify Booking Confirmation ← from VerificationCommon.robot ← via common.resource
```

---

## Adding New Resources

### To add a new page object:
1. Create `resources/pages/NewPage.robot`
2. Add locators in `*** Variables ***` section
3. Add keywords in `*** Keywords ***` section
4. Import in `common.resource`

### To add a new utility keyword:
1. Add to appropriate file in `resources/common/`
2. Already imported via `common.resource`

### To add a new workflow:
1. Create `resources/workflows/NewWorkflow.robot`
2. Import needed resources
3. Add complex keywords combining multiple steps
4. Import in `common.resource`

---

## Best Practices Implemented

✅ Single point of entry for all resources (`common.resource`)
✅ Clear layer separation (Pages → Utils → Workflows → Tests)
✅ No circular imports
✅ Consistent naming conventions
✅ Documented dependencies
✅ Easy to extend without breaking changes
✅ Minimal test file complexity
✅ Reusable keyword library

