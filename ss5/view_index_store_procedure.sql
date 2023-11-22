create database demo;
use demo;

create table products (
    id int primary key auto_increment,
    product_code varchar(45),
    product_name varchar(45),
    product_price double,
    product_amount int,
    product_description text,
    product_status bit(1)
);

insert into products(product_code,product_name,product_price,product_amount,product_description,product_status)
values ('p001','nice shoe',12,2,'huh ayo',1),
('p002','nice watch',133,2,'watches',1),
('p003','bones',5,2,'ner',1);
/*
tạo unique index trên bảng products (sử dụng cột productcode để tạo chỉ mục)
tạo composite index trên bảng products (sử dụng 2 cột productname và productprice)
sử dụng câu lệnh explain để biết được câu lệnh sql của bạn thực thi như nào
so sánh câu truy vấn trước và sau khi tạo index 
*/
explain select product_code from products where product_name = 'bones';
create index unique_index on products(product_code);
create index composite_index on products(product_name,product_price);
explain select product_code from products where product_name = 'bones';

/*
tạo view lấy về các thông tin: productcode, productname, productprice, productstatus từ bảng products.
tiến hành sửa đổi view
tiến hành xoá view
*/
create view info as
select product_code, product_name, product_price, product_status
from products;

create or replace view info as 
select product_code, product_name, product_price
from products;

drop view info;

/*
tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
tạo store procedure thêm một sản phẩm mới
tạo store procedure sửa thông tin sản phẩm theo id
tạo store procedure xoá sản phẩm theo id
*/
delimiter // 
create procedure show_all_fields()
begin
select *
from products;
end // 
delimiter ; 
call show_all_fields();

delimiter //
create procedure add_product(p_code varchar(45),
p_name varchar(45),
p_price double,
p_amount int,
p_description text,
p_status bit(1))
begin
insert into products(product_code,product_name,product_price,product_amount,product_description,product_status) 
values(p_code,p_name,p_price,p_amount,p_description,p_status);
end
//delimiter ;
call add_product('razer-m','mouse',55,4,'midrange mouse',1);

delimiter //
create procedure edit_by_id(p_id int,p_code varchar(45),
p_name varchar(45),
p_price double,
p_amount int,
p_description text,
p_status bit(1))
begin
update products
set product_code=p_code,product_name=p_name,product_price=p_price,product_amount=p_amount,product_description=p_description,product_status=p_status
where id=p_id;
end
//delimiter ;
call edit_by_id(1,'logi','keyboard',23,1,'good and cheap',1);

delimiter //
create procedure delete_by_id(p_id int)
begin
delete from products
where id=p_id;
end
//delimiter ;
call delete_by_id(2);