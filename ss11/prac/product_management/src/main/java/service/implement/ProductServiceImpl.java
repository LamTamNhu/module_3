package service.implement;

import model.Product;
import repository.ProductRepository;
import repository.implement.ProductRepoImp;
import service.ProductService;

import java.util.List;

public class ProductServiceImpl implements ProductService {
    private final ProductRepository repository = new ProductRepoImp();

    @Override
    public List<Product> getProducts() {
        return repository.getProducts();
    }

    @Override
    public void addProduct(Product product) {
        repository.addProduct(product);
    }

    @Override
    public Product findById(String id) {
        return repository.findById(id);

    }

    @Override
    public void editProduct(Product productEdited) {
        repository.editProduct(productEdited);
    }

    @Override
    public void removeProduct(String id) {
        repository.removeProduct(id);
    }
}
