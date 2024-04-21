# #!/usr/bin/env python
from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.common.by import By
import datetime

# Start the browser and perform the test
def start ():
    print (timestamp() + 'Opening Chrome browser...')
    options = ChromeOptions()
    
    options.add_argument("--headless")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--no-sandbox")
    options.add_argument("--remote-debugging-port=9222")

    driver = webdriver.Chrome(options=options)
    # driver = webdriver.Chrome()

    # Log in
    login(driver, 'standard_user', 'secret_sauce')

    # Adding a product to the cart
    addToCart(driver)

    # Remove a product from the cart
    removeFromCart(driver)

# Login
def login (driver, user, password):
    print (timestamp() + 'Chrome has been opened successfully. Redirecting demo login page.')
    driver.get('https://www.saucedemo.com/')

    print (timestamp() + 'Fill in username')
    driver.find_element(By.CSS_SELECTOR, "input[id = 'user-name']").send_keys(user)

    print (timestamp() + 'Fill in password')
    driver.find_element(By.CSS_SELECTOR, "input[id = 'password']").send_keys(password)

    print (timestamp() + 'Click on login button')
    driver.find_element(By.CSS_SELECTOR, "input[id = 'login-button']").click()

    logoElements = driver.find_elements(By.CSS_SELECTOR, ".app_logo")
    assert len(logoElements) > 0, "Element not found"
    print (timestamp() + 'Successfully logined')

# Adding
def addToCart(driver):
    print (timestamp() + 'Add 6 products')
    productElements = driver.find_elements(By.CSS_SELECTOR, ".inventory_item")

    for product in productElements:
        productButton = product.find_element(By.CSS_SELECTOR, ".btn_inventory")
        productName = product.find_element(By.CSS_SELECTOR, ".inventory_item_name")

        print(timestamp() + f"Item {productName.text} has been added into the cart")
        productButton.click()

    cartCount = int(driver.find_element(By.CSS_SELECTOR, ".shopping_cart_badge").text)
    assert cartCount == len(productElements), 'The cart count is in correct'
    print(timestamp() + 'Cart count: ' +str(cartCount))

# Removing all
def removeFromCart(driver):
    print (timestamp() + 'Navigate to the cart page')
    driver.find_element(By.CSS_SELECTOR, ".shopping_cart_link").click()

    print (timestamp() + 'Remove all products')
    removeButtons = driver.find_elements(By.CSS_SELECTOR, ".cart_button")
    for remove in removeButtons:
        remove.click()

    cartCountElement = driver.find_elements(By.CSS_SELECTOR, ".shopping_cart_badge")
    assert len(cartCountElement) == 0, "Remove failed"
    print(timestamp() + 'All product have been removed successfully')

def timestamp():
    ts = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%SZ")
    return (ts + ' ')

start()