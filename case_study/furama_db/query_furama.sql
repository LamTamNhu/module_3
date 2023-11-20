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
    GROUP BY ma_khach_hang , ho_ten , ten_loai_khach , hd.ma_hop_dong , dv.ten_dich_vu , hd.ngay_lam_hop_dong , hd.ngay_ket_thuc;

