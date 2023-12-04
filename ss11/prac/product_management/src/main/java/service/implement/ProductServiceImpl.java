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
}
