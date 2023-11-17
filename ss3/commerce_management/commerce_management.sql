CREATE DATABASE quan_ly_ban_hang ;
USE quan_ly_ban_hang ;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    age INT
);

CREATE TABLE `order` (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_price DOUBLE,
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    product_price DOUBLE
);
CREATE TABLE order_detail (
    product_id INT,
    order_id INT,
    order_quantity INT,
    PRIMARY KEY (product_id , order_id),
    FOREIGN KEY (product_id)
        REFERENCES product (product_id),
    FOREIGN KEY (order_id)
        REFERENCES `order` (order_id)
);

INSERT 
INTO customer(customer_name,age) 
VALUES ('Minh Quan',10),('Ngoc Oanh',20),('Hong Ha',50);

INSERT INTO `order`(customer_id,order_date,total_price) VALUES (1,'2006/03/21',NULL),(2,'2006/03/23',NULL),(1,'2006/03/16',NULL);
INSERT INTO product(product_name,product_price) VALUES ('May Giat',3),('Tu Lanh',5),('Dieu Hoa',7),('Quat',1),('Bep Dien',2);
INSERT INTO order_detail(order_id,product_id,order_quantity) VALUES (1,1,3),(1,3,7),(1,4,2),(2,1,1),(3,1,8),(2,5,4),(2,3,3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT 
    order_id, customer_id, total_price
FROM
    `order`sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT 
    c.customer_id,
    c.customer_name,
    GROUP_CONCAT(product_name) AS danh_sach_sp
FROM
    customer c
        JOIN
    `order` o ON c.customer_id = o.customer_id
        JOIN
    order_detail od ON o.order_id = od.order_id
        JOIN
    product p ON od.product_id = p.product_id
GROUP BY c.customer_id , c.customer_name;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT c.customer_id,c.customer_name
FROM customer c
LEFT JOIN `order` o 
ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)    
SELECT 
    o.order_id, o.order_date,
    sum(od.order_quantity * p.product_price) as order_total
FROM
    `order` o
        JOIN
    order_detail od ON o.order_id = od.order_id
        JOIN
    product p ON od.product_id = p.product_id
GROUP BY o.order_id , o.order_date;