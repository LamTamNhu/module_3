-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.(ho_ten like '% H%' or ho_ten like '% T%' or ho_ten like '% K%')

SELECT 
    *
FROM
    nhan_vien
WHERE
    CHAR_LENGTH(ho_ten) <= 15
        AND (SUBSTRING_INDEX(ho_ten, ' ', 1) LIKE 'H%'
        OR SUBSTRING_INDEX(ho_ten, ' ', 1) LIKE 'T%'
        OR SUBSTRING_INDEX(ho_ten, ' ', 1) LIKE 'K%');

-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
SELECT 
    *
FROM
    khach_hang
WHERE
    (dia_chi LIKE '%Đà Nẵng%'
        OR dia_chi LIKE '%Quảng Trị%')
        AND (DATEDIFF(CURDATE(), ngay_sinh) / 365 BETWEEN 18 AND 50);

-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
SELECT 
    kh.ma_khach_hang,
    kh.ho_ten,
    COUNT(hd.ma_hop_dong) AS so_lan_dat_phong
FROM
    khach_hang AS kh
        JOIN
    hop_dong AS hd ON kh.ma_khach_hang = hd.ma_khach_hang
        JOIN
    loai_khach AS lk ON kh.ma_loai_khach = lk.ma_loai_khach
GROUP BY kh.ma_khach_hang , kh.ho_ten , lk.ten_loai_khach
HAVING lk.ten_loai_khach = 'diamond'
ORDER BY so_lan_dat_phong ASC;

-- 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra). 
SELECT 
    kh.ma_khach_hang,
    ho_ten,
    ten_loai_khach,
    hd.ma_hop_dong,
    ten_dich_vu,
    ngay_lam_hop_dong,
    ngay_ket_thuc,
     SUM(chi_phi_thue + IFNULL(gia, 0) * IFNULL(so_luong, 0)) AS tong_tien
FROM
    khach_hang AS kh
        LEFT JOIN
    hop_dong AS hd ON kh.ma_khach_hang = hd.ma_khach_hang
        LEFT JOIN
    hop_dong_chi_tiet AS hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
        LEFT JOIN
    dich_vu AS dv ON hd.ma_dich_vu = dv.ma_dich_vu
        LEFT JOIN
    loai_khach AS lk ON kh.ma_loai_khach = lk.ma_loai_khach
        LEFT JOIN
    dich_vu_di_kem AS dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
    GROUP BY ma_khach_hang , ho_ten , ten_loai_khach , ma_hop_dong , ten_dich_vu , ngay_lam_hop_dong , ngay_ket_thuc;

-- 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
SELECT 
    dv.ma_dich_vu,
    ten_dich_vu,
    dien_tich,
    chi_phi_thue,
    ten_loai_dich_vu,
    hd.ngay_lam_hop_dong
FROM
    dich_vu AS dv
        LEFT JOIN
    hop_dong AS hd ON dv.ma_dich_vu = hd.ma_dich_vu
        LEFT JOIN
    loai_dich_vu AS ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
GROUP BY dv.ma_dich_vu
HAVING hd.ngay_lam_hop_dong NOT IN (SELECT 
        ngay_lam_hop_dong
    FROM
        hop_dong
    WHERE
        ngay_lam_hop_dong >= '2021-01-01');

-- 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
SELECT 
    dv.ma_dich_vu,
    ten_dich_vu,
    dien_tich,
    chi_phi_thue,
    ten_loai_dich_vu,
    hd.ngay_lam_hop_dong
FROM
    dich_vu AS dv
        LEFT JOIN
    hop_dong AS hd ON dv.ma_dich_vu = hd.ma_dich_vu
        LEFT JOIN
    loai_dich_vu AS ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
GROUP BY dv.ma_dich_vu
HAVING hd.ngay_lam_hop_dong < '2021-01-01'
    AND NOT '2021-12-31' >= hd.ngay_lam_hop_dong >= '2021-01-01';

-- 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau. Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
-- 1
select ho_ten
from khach_hang
group by ho_ten;

-- 2
SELECT 
    ho_ten
FROM
    khach_hang 
UNION SELECT 
    ho_ten
FROM
    khach_hang;

-- 3
SELECT DISTINCT
    ho_ten
FROM
    khach_hang;
    
-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
SELECT 
    MONTH(ngay_lam_hop_dong) AS thang,
    COUNT(ma_hop_dong) AS so_luong_khach_hang
FROM
    hop_dong
WHERE
    ngay_lam_hop_dong BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY thang
ORDER BY thang;

-- 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
SELECT 
    hd.ma_hop_dong,
    ngay_lam_hop_dong,
    ngay_ket_thuc,
    tien_dat_coc,
    SUM(hdct.so_luong) AS so_luong_dich_vu_di_kem
FROM
    hop_dong AS hd
        LEFT JOIN
    hop_dong_chi_tiet AS hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
GROUP BY hd.ma_hop_dong;

-- 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
SELECT 
    dvdk.ma_dich_vu_di_kem,
    ten_dich_vu_di_kem,
    gia,
    don_vi,
    trang_thai
FROM
    dich_vu_di_kem AS dvdk
        JOIN
    hop_dong_chi_tiet AS hdct ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
        JOIN
    hop_dong AS hd ON hd.ma_hop_dong = hdct.ma_hop_dong
        JOIN
    khach_hang AS kh ON kh.ma_khach_hang = hd.ma_khach_hang
        JOIN
    loai_khach AS lk ON kh.ma_loai_khach = lk.ma_loai_khach
WHERE
    lk.ten_loai_khach = 'diamond'
        AND (kh.dia_chi LIKE '%vinh%'
        OR kh.dia_chi LIKE '%quảng ngãi%');

-- 12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
set sql_mode=0;
SELECT 
    hd.ma_hop_dong,
    nv.ho_ten,
    kh.ho_ten,
    kh.so_dien_thoai,
    dv.ten_dich_Vu,
    SUM(hdct.so_luong) AS so_luong_dich_vu_di_kem
FROM
    hop_dong AS hd
        JOIN
    nhan_vien AS nv ON nv.ma_nhan_vien = hd.ma_nhan_vien
        JOIN
    khach_hang AS kh ON kh.ma_khach_hang = hd.ma_khach_hang
        LEFT JOIN
    dich_vu AS dv ON dv.ma_dich_vu = hd.ma_dich_vu
        LEFT JOIN
    hop_dong_chi_tiet AS hdct ON hdct.ma_hop_dong = hd.ma_hop_dong
GROUP BY dv.ma_dich_vu , ngay_lam_hop_dong
HAVING hd.ngay_lam_hop_dong NOT IN (SELECT 
        ngay_lam_hop_dong
    FROM
        hop_dong
    WHERE
        ngay_lam_hop_dong BETWEEN '2021-01-01' AND '2021-30-06')
    AND ngay_lam_hop_dong BETWEEN '2020-09-01' AND '2020-12-31';

-- 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
SELECT 
    ten_dich_vu_di_kem, SUM(ct.so_luong) AS so_luong_dvdk
FROM
    dich_vu_di_kem dk
        JOIN
    hop_dong_chi_tiet ct ON dk.ma_dich_vu_di_kem = ct.ma_dich_vu_di_kem
GROUP BY dk.ma_dich_vu_di_kem
HAVING so_luong_dvdk = (SELECT 
        MAX(sum_col) AS max_sum
    FROM
        (SELECT 
            SUM(so_luong) AS sum_col
        FROM
            hop_dong_chi_tiet
        GROUP BY ma_dich_vu_di_kem) AS sub);



-- 14. Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
SELECT 
    hdct.ma_hop_dong,
    ldv.ten_loai_dich_vu,
    dvdk.ten_dich_vu_di_kem,
    COUNT(hdct.ma_dich_vu_di_kem) AS so_lan_su_dung
FROM
    dich_vu_di_kem AS dvdk
        JOIN
    hop_dong_chi_tiet AS hdct ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
        JOIN
    hop_dong AS hd ON hd.ma_hop_dong = hdct.ma_hop_dong
        JOIN
    dich_vu AS dv ON dv.ma_dich_vu = hd.ma_dich_vu
        JOIN
    loai_dich_vu AS ldv ON ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
GROUP BY hdct.ma_dich_vu_di_kem
HAVING so_lan_su_dung = 1
ORDER BY ten_loai_dich_vu;

-- 15. Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.
SELECT 
    nv.ma_nhan_vien,
    ho_ten,
    so_dien_thoai,
    dia_chi,
    hd.ngay_lam_hop_dong
FROM
    nhan_vien AS nv
        JOIN
    hop_dong AS hd ON nv.ma_nhan_vien = hd.ma_nhan_vien
GROUP BY nv.ma_nhan_vien
HAVING COUNT(ma_hop_dong) <= 3
    AND (hd.ngay_lam_hop_dong BETWEEN '2020-01-01' AND '2021-12-31');

-- 16. Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
DELETE FROM nhan_vien 
WHERE
    ma_nhan_vien NOT IN (SELECT 
        ma_nhan_vien
    FROM
        hop_dong
    
    WHERE
        YEAR(hop_dong.ngay_lam_hop_dong) BETWEEN 2019 AND 2021);

-- 17. Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond, chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.
CREATE VIEW khach_hang_update_len_diamond AS
    SELECT 
        hd.ma_khach_hang
    FROM
        hop_dong AS hd
            JOIN
        khach_hang AS kh ON hd.ma_khach_hang = kh.ma_khach_hang
            JOIN
        loai_khach AS lk ON kh.ma_loai_khach = lk.ma_loai_khach
            JOIN
        hop_dong_chi_tiet AS ct ON ct.ma_hop_dong = hd.ma_hop_dong
            JOIN
        dich_vu AS dv ON dv.ma_dich_vu = hd.ma_dich_vu
            JOIN
        dich_vu_di_kem AS dk ON ct.ma_dich_vu_di_kem = dk.ma_dich_vu_di_kem
    WHERE
        YEAR(hd.ngay_lam_hop_dong) = 2021
            AND kh.ma_loai_khach = 2
    GROUP BY hd.ma_hop_dong
    HAVING SUM(dk.gia * ct.so_luong + dv.chi_phi_thue) > 10000000;

UPDATE khach_hang AS kh
        INNER JOIN
    khach_hang_update_len_diamond AS ud ON ud.ma_khach_hang = kh.ma_khach_hang 
SET 
    kh.ma_loai_khach = 1;

-- 18.	Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).
WITH kh_hd_truoc_2021
AS (
	SELECT kh.ma_khach_hang
	FROM khach_hang AS kh
	INNER JOIN hop_dong AS hd ON hd.ma_khach_hang = kh.ma_khach_hang
	WHERE year(ngay_lam_hop_dong) < 2021
	GROUP BY kh.ma_khach_hang
	)
UPDATE khach_hang 
SET 
    is_deleted = 1
WHERE
    ma_khach_hang IN (SELECT 
            ma_khach_hang
        FROM
            kh_hd_truoc_2021)
        AND ma_khach_hang > 0;

-- 19. Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.
WITH dvdk_su_dung_tren_10_lan
AS (
	SELECT ct.ma_dich_vu_di_kem
		,sum(so_luong) AS so_lan_su_dung
	FROM hop_dong_chi_tiet AS ct
	INNER JOIN dich_vu_di_kem AS dk ON ct.ma_dich_vu_di_kem = dk.ma_dich_vu_di_kem
	GROUP BY ct.ma_dich_vu_di_kem
	HAVING so_lan_su_dung > 10
	)


UPDATE dich_vu_di_kem 
SET 
    gia = gia * 2
WHERE
    ma_dich_vu_di_kem IN (SELECT 
            ma_dich_vu_di_kem
        FROM
            dvdk_su_dung_tren_10_lan)
        AND ma_dich_vu_di_kem > 0;

-- 20. Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.
SELECT 
    ma_nhan_vien AS id,
    ho_ten,
    email,
    so_dien_thoai,
    ngay_sinh,
    dia_chi
FROM
    nhan_vien 
UNION SELECT 
    ma_khach_hang,
    ho_ten,
    email,
    so_dien_thoai,
    ngay_sinh,
    dia_chi
FROM
    khach_hang;
    
-- 21.	Tạo khung nhìn có tên là v_nhan_vien để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu” và đã từng lập hợp đồng cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng là “12/12/2019”.
CREATE OR REPLACE VIEW v_nhan_vien AS
    SELECT 
        nv.*
    FROM
        nhan_vien AS nv
            JOIN
        hop_dong AS hd ON nv.ma_nhan_vien = hd.ma_nhan_vien
    GROUP BY nv.ma_nhan_vien , hd.ngay_lam_hop_dong
    HAVING ngay_lam_hop_dong = '2019-12-12'
        AND dia_chi LIKE '%Hải Châu%';

select * from v_nhan_vien;

-- 22.	Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả các nhân viên được nhìn thấy bởi khung nhìn này.
UPDATE nhan_vien 
SET 
    dia_chi = 'Liên Chiểu'
WHERE
    ma_nhan_vien IN (SELECT 
            ma_nhan_vien
        FROM
            v_nhan_vien)
        AND ma_nhan_vien > 0;
        
-- 23.	Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng nào đó với ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang.
delimiter //
create procedure sp_xoa_khach_hang(id int)
begin
update khach_hang
set is_deleted=1
where ma_khach_hang=id;
end
// delimiter ;

call sp_xoa_khach_hang(3);

-- 24.	Tạo Stored Procedure sp_them_moi_hop_dong dùng để thêm mới vào bảng hop_dong với yêu cầu sp_them_moi_hop_dong phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung, với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.
delimiter //
create procedure sp_them_moi_hop_dong (new_ngay_lam_hop_dong datetime,
    new_ngay_ket_thuc datetime,
    new_tien_dat_coc double,
    new_ma_nhan_vien int,
    new_ma_khach_hang int,
    new_ma_dich_vu int)
    begin    
    if new_ma_nhan_vien not in (select ma_nhan_vien from nhan_vien) then 
    signal SQLSTATE '45000' set MESSAGE_TEXT= 'Mã nhân viên không tồn tại!';
    end if;
    
    if(new_ma_khach_hang not in (select ma_khach_hang from khach_hang)) 
    then signal SQLSTATE '45000' set MESSAGE_TEXT= 'Mã khách hàng không tồn tại!'; end if;
    
    if(new_ma_dich_vu not in (select ma_dich_vu from dich_vu)) 
    then signal SQLSTATE '45000' set MESSAGE_TEXT= 'Mã dịch vụ không tồn tại!'; end if;
    
    insert into hop_dong (ngay_lam_hop_dong,ngay_ket_thuc,tien_dat_coc,ma_nhan_vien,ma_khach_hang,ma_dich_vu)
    values (new_ngay_lam_hop_dong,new_ngay_ket_thuc,new_tien_dat_coc,new_ma_nhan_vien,new_ma_khach_hang,new_ma_dich_vu);
    end
    // delimiter ;
    
    call sp_them_moi_hop_dong('2023-01-01','2023-02-01',11,1,2,2);
    
-- 25.	Tạo Trigger có tên tr_xoa_hop_dong khi xóa bản ghi trong bảng hop_dong thì hiển thị tổng số lượng bản ghi còn lại có trong bảng hop_dong ra giao diện console của database.
-- Lưu ý: Đối với MySQL thì sử dụng SIGNAL hoặc ghi log thay cho việc ghi ở console.
delimiter //
create or replace view count_record_hop_dong as
select count(ma_hop_dong) as so_luong_hop_dong
from hop_dong
where is_deleted=0;

create trigger tr_xoa_hop_dong after update on hop_dong
for each row
if (new.is_deleted<>old.is_deleted) 
then 
begin
declare so_ban_ghi_update int;
set so_ban_ghi_update = (select so_luong_hop_dong from count_record_hop_dong);
insert into so_ban_ghi_hop_dong(so_ban_ghi) values (so_ban_ghi_update);
end;
end if;
// delimiter ;

UPDATE hop_dong 
SET 
    is_deleted = 1
WHERE
    ma_hop_dong = 5;
SELECT 
    *
FROM
    so_ban_ghi_hop_dong;

-- 26.	Tạo Trigger có tên tr_cap_nhat_hop_dong khi cập nhật ngày kết thúc hợp đồng, cần kiểm tra xem thời gian cập nhật có phù hợp hay không, với quy tắc sau: Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày. Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ thì in ra thông báo “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database.
delimiter // 
create trigger tr_cap_nhat_hop_dong before update on hop_dong
for each row 
if day(new.ngay_ket_thuc) - day(old.ngay_lam_hop_dong) < 2 then 
signal SQLSTATE '45000' 
set MESSAGE_TEXT = 'Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày';
end if;
// delimiter ;

/*
 27.	Tạo Function thực hiện yêu cầu sau:
a.	Tạo Function func_dem_dich_vu: Đếm các dịch vụ đã được sử dụng với tổng tiền là > 2.000.000 VNĐ.
b.	Tạo Function func_tinh_thoi_gian_hop_dong: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm hợp đồng đến lúc kết thúc hợp đồng mà khách hàng đã thực hiện thuê dịch vụ (lưu ý chỉ xét các khoảng thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ, không xét trên toàn bộ các lần làm hợp đồng). Mã của khách hàng được truyền vào như là 1 tham số của function này.
*/
-- a
delimiter //
create function func_dem_dich_vu () RETURNS INT
  DETERMINISTIC
  begin
  declare result int;
  with chi_phi as(
  select sum(chi_phi_thue) as chi_phi, ten_dich_vu
  from dich_vu as dv
  join hop_dong as hd on dv.ma_dich_vu = hd.ma_dich_vu
  group by dv.ma_dich_vu
  having chi_phi >2000000)
  
  select count(ten_dich_vu) into result
  from chi_phi;  
  return result;
  end
  // delimiter ;
  
select func_dem_dich_vu();

-- b
delimiter //
create function func_tinh_thoi_gian_hop_dong (id int) returns INT
DETERMINISTIC
begin
declare result int;
with tinh_ngay as
(select datediff(ngay_ket_thuc,ngay_lam_hop_dong) as theo_ngay
from hop_dong
where id = ma_khach_hang and is_deleted=0)

select max(theo_ngay) into result
from tinh_ngay;
return result;
end
// delimiter ;

select func_tinh_thoi_gian_hop_dong(1);

-- 28.	Tạo Stored Procedure sp_xoa_dich_vu_va_hd_room để tìm các dịch vụ được thuê bởi khách hàng với loại dịch vụ là “Room” từ đầu năm 2015 đến hết năm 2019 để xóa thông tin của các dịch vụ đó (tức là xóa các bảng ghi trong bảng dich_vu) và xóa những hop_dong sử dụng dịch vụ liên quan (tức là phải xóa những bản gi trong bảng hop_dong) và những bản liên quan khác.
delimiter //
create procedure sp_xoa_dich_vu_va_hd_room ()
begin
with bang_de_xoa as
(select dv.ma_dich_vu as id_xoa
from dich_vu as dv
join hop_dong as hd on dv.ma_dich_vu = hd.ma_dich_vu
group by dv.ma_dich_vu, ma_loai_dich_vu,ngay_lam_hop_dong
having ma_loai_dich_vu=3 and year(ngay_lam_hop_dong) between 2015 and 2019)

update dich_vu as dv,hop_dong as hd
set dv.is_deleted=1,hd.is_deleted=1
where dv.ma_dich_vu=hd.ma_dich_vu and dv.ma_dich_vu in (select id_xoa from bang_de_xoa) and dv.ma_dich_vu>0;
end
// delimiter ;

call sp_xoa_dich_vu_va_hd_room();