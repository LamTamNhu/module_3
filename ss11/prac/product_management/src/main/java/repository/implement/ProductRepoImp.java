package repository.implement;

import model.Product;
import repository.ProductRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProductRepoImp implements ProductRepository {
    private static final List<Product> products = new ArrayList<>();

    static {
        products.add(new Product("P-0001", "Ai phone", 11.5, LocalDate.of(2001, 1, 1), "Good phone not very good price"));
    }

    @Override
    public List<Product> getProducts() {
        return products;
    }
}
