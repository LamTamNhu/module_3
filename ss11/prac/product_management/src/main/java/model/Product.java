package model;

import java.time.LocalDate;

public class Product {
    private String id;
    private String name;
    private Double price;
    private LocalDate productionDate;
    private String description;

    public Product() {
    }

    public Product(String id, String name, Double price, LocalDate productionDate, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.productionDate = productionDate;
        this.description = description;
    }

    public String getId() {
        return id;
    }

    public LocalDate getProductionDate() {
        return productionDate;
    }

    public void setProductionDate(LocalDate productionDate) {
        this.productionDate = productionDate;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
