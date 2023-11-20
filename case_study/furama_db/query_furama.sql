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
        LEFT JOIN
    dich_vu_di_kem AS dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
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
SELECT 
    hd.ma_hop_dong,
    nv.ho_ten,
    kh.ho_ten,
    kh.so_dien_thoai,
    dv.ten_dich_Vu,
    SUM(hdct.so_luong) AS so_luong_dich_vu_di_kem
FROM
    hop_dong AS hd
        LEFT JOIN
    nhan_vien AS nv ON nv.ma_nhan_vien = hd.ma_nhan_vien
        LEFT JOIN
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



