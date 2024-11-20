from product_model import Product
from product_menu import main_menu

def main():
    products = [
        Product("Laptop", 999.99, 5),
        Product("Smartphone", 499.99, 10),
        Product("Tablet", 299.99, 0),
        Product("Smartwatch", 199.99, 3)
    ]

    main_menu(products)
   

if __name__ == "__main__":
    main()
