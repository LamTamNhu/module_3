package repository;

import model.Product;

import java.util.List;

public interface ProductRepository {


    List<Product> getProducts();

    void addProduct(Product product);

    Product findById(String id);

    void editProduct(Product productEdited);

    void removeProduct(String id);
}
