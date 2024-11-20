def calculate_total_inventory_value(products) -> int:
    return sum(product.price * product.quantity for product in products)

def find_most_expensive_product(products):
    return max(products, key=lambda product: product.price).name

def check_in_stock(name, products):
    format_name = name.lower().capitalize().strip()
    return any(product.name == format_name and product.quantity > 0 for product in products)

def sort_products(products, sort_key, sort_order):
    return sorted(products, key=lambda product: getattr(product, sort_key), reverse=sort_order)
