class GroceryData {
  static List<Map<String, dynamic>> groceryProducts = [
    {
      "id": 1,
      "name": "Apple",
      "description": "Fresh and organic apples, rich in vitamins.",
      "image_url": "data:image/jpeg;base64,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",
      "price": 2.5
    },
    {
      "id": 2,
      "name": "Banana",
      "description": "Ripe bananas with natural sweetness, perfect for snacks.",
      "image_url": "https://example.com/images/banana.jpg",
      "price": 1.2
    },
    {
      "id": 3,
      "name": "Carrot",
      "description": "Crunchy organic carrots, ideal for salads and cooking.",
      "image_url": "https://example.com/images/carrot.jpg",
      "price": 1.8
    },
    {
      "id": 4,
      "name": "Milk",
      "description": "Fresh cow milk, rich in calcium and protein.",
      "image_url": "https://example.com/images/milk.jpg",
      "price": 3.0
    },
    {
      "id": 5,
      "name": "Bread",
      "description": "Whole wheat bread, perfect for healthy sandwiches.",
      "image_url": "https://example.com/images/bread.jpg",
      "price": 2.0
    },
    {
      "id": 6,
      "name": "Eggs",
      "description": "Organic farm eggs, rich in protein and vitamins.",
      "image_url": "https://example.com/images/eggs.jpg",
      "price": 3.5
    },
    {
      "id": 7,
      "name": "Tomato",
      "description": "Fresh tomatoes, great for cooking and salads.",
      "image_url": "https://example.com/images/tomato.jpg",
      "price": 1.5
    },
    {
      "id": 8,
      "name": "Potato",
      "description": "Fresh potatoes, ideal for a variety of dishes.",
      "image_url": "https://example.com/images/potato.jpg",
      "price": 1.0
    },
  ];               
}
