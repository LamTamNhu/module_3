package repository.implement;

import model.Product;
import repository.ProductRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ProductRepoImp implements ProductRepository {
    private static final List<Product> products = new ArrayList<>();

    static {
        products.add(new Product("P-0001", "Ai phone", 11.5, LocalDate.of(2001, 1, 1), "Good phone not very good price"));
        products.add(new Product("P-0002", "Hoodie", 2.0, LocalDate.of(2020, 10, 13), "N/A"));
        products.add(new Product("P-0003", "Air Frier", 6.0, LocalDate.of(2008, 1, 1), "N/A"));
        products.add(new Product("P-0004", "Lipstick", 3.0, LocalDate.of(2012, 1, 1), "N/A"));
        products.add(new Product("P-0005", "Sandal", 5.0, LocalDate.of(2021, 1, 1), "N/A"));
        products.add(new Product("P-0006", "Plush", 8.0, LocalDate.of(2017, 1, 1), "N/A"));
    }

    @Override
    public List<Product> getProducts() {
        return products;
    }

    @Override
    public void addProduct(Product product) {
        products.add(product);
    }

    @Override
    public Product findById(String id) {
        for (Product p : products) {
            if (id.equals(p.getId())) {
                return p;
            }
        }
        return null;
    }

    @Override
    public void editProduct(Product productEdited) {
        Product productToEdit = findById(productEdited.getId());
        productToEdit.setName(productEdited.getName());
        productToEdit.setPrice(productEdited.getPrice());
        productToEdit.setProductionDate(productEdited.getProductionDate());
        productToEdit.setDescription(productEdited.getDescription());
    }

    @Override
    public void removeProduct(String id) {
        Product productToRemove = findById(id);
        products.remove(productToRemove);
    }
}
