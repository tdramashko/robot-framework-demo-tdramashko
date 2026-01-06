import sys
from selenium.webdriver.chrome.options import Options as ChromeOptions

def get_chrome_options():
    """
    Creates and returns a ChromeOptions object with specific flags to disable 
    the 'Data Breach' security warning and other password popups.
    """
    options = ChromeOptions()

    # 1. Preferences to disable the standard Password Manager behavior
    prefs = {
        "credentials_enable_service": False,
        "profile.password_manager_enabled": False,
        "autofill.enabled": False,
        # Disabling Safe Browsing often helps with 'Data Breach' warnings in test environments
        "safebrowsing.enabled": False, 
        "safebrowsing.disable_download_protection": True,
    }
    options.add_experimental_option("prefs", prefs)
    
    # 2. Exclude automation switches to make Chrome look like a regular user
    options.add_experimental_option("excludeSwitches", ["enable-automation"])

    # 3. CRITICAL: Disable the specific features causing the "Change Password" breach popup
    # We disable:
    # - PasswordBreachDetection: The exact feature causing your popup
    # - PasswordGeneration: Suggesting strong passwords
    # - AutofillServerCommunication: Checking passwords against Google servers
    disable_features = "PasswordBreachDetection,PasswordGeneration,AutofillServerCommunication,UnifiedPasswordManagerAndroid"
    options.add_argument(f"--disable-features={disable_features}")

    # 4. Standard UI suppressions
    options.add_argument("--disable-notifications")
    options.add_argument("--disable-infobars")
    options.add_argument("--disable-popup-blocking")
    options.add_argument("--disable-save-password-bubble")
    
    return options