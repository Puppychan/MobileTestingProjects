import helpers

def sort_menu_key_content():
    sort_key = "price"
    while True:
        print("\n==========================")
        print("       SORT PRODUCTS       ")
        print("==========================")
        print("1. Sort by Price")
        print("2. Sort by Quantity")
        print("3. Exit to Main Menu")
        print("==========================")
        
        sort_key_choice = input("Enter your choice: ")
        
        if sort_key_choice == "1":
            sort_key = "price"
            break
        elif sort_key_choice == "2":
            sort_key = "quantity"
            break
        elif sort_key_choice == "3":
            sort_key = -1
            break
        else:
            print("Invalid choice. Please try again.")
            continue
    return sort_key

def sort_menu_order_content():
    sort_order = False
    while True:
        print("\n==========================")
        print("      SORT ORDER       ")
        print("==========================")
        print("1. Sort in Ascending Order")
        print("2. Sort in Descending Order")
        print("3. Exit to Main Menu")
        print("==========================")
        
        sort_order_choice = input("Enter your choice: ")
        if sort_order_choice == "1":
            sort_order = False
            break
        elif sort_order_choice == "2":
            sort_order = True
            break
        elif sort_order_choice == "3":
            sort_order = -1
            break
        else:
            print("Invalid choice. Please try again.")
            continue
    return sort_order

def sort_menu(products):
    while True:
        sort_key = sort_menu_key_content()
        if (sort_key == -1):
            # Exit to main menu
            break
        
        sort_order = sort_menu_order_content()
        if (sort_order == -1):
            # Exit to main menu
            break
        
        sorted_products = helpers.sort_products(products, sort_key, sort_order)
        print("\n\n************************")
        print("    SORTED PRODUCTS    ")
        print("************************")
        for product in sorted_products:
            print(f"{product.name}: Price: {product.price:.2f}, Quantity: {product.quantity}")
        print("************************")
        
        break        
    
def main_menu(products):
    while True:
        print("\n\n==========================")
        print("       MAIN MENU         ")
        print("==========================")
        print("1. Calculate Total Inventory Value")
        print("2. Find Most Expensive Product")
        print("3. Check If Headphones Are In Stock")
        print("4. Sort Products")
        print("5. Exit")
        print("==========================")
        
        choice = input("Enter your choice: ")
        
        if choice == "1":
            total_value = helpers.calculate_total_inventory_value(products)
            print(f"\nTotal Inventory Value: {total_value:.2f}")
        elif choice == "2":
            most_expensive = helpers.find_most_expensive_product(products)
            print(f"\nMost Expensive Product: {most_expensive}")
        elif choice == "3":
            in_stock = helpers.check_in_stock("Headphones", products)
            print(f"\nHeadphones are in stock: {in_stock}")
        elif choice == "4":
            sort_menu(products)
        elif choice == "5":
            print("\nExiting the program. Goodbye!")
            break
        else:
            print("\nInvalid choice. Please try again.")