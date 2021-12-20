use `bai_tap 1`;
create table  nhacungcap(
	maNhaCC int primary key,
    tenNhaCC varchar(255),
    diaChi varchar(255),
    soDt varchar(10),
    maSoThue varchar(10)
);
create table loaiDichVu(
	maLoaiDV int primary key,
    tenDV varchar(255)
);
create table mucPhi(
	maMucPhi int primary key,
    donGia double,
    moTa varchar(255)
);
create table dongXe(
	dongXe varchar(255) primary key,
    hangXe varchar(255),
    soChoNgoi int
);
create table dangKyCungCap(
	maDKCC int primary key,
	maNhaCC int,
	maLoaiDV int,
	maMucPhi int,
	dongXe varchar(255),
    ngayBatDau date,
    ngayKetThuc date,
    soLuongXeDK int,
    foreign key(maNhaCC) references nhacungcap(maNhaCC),
    foreign key(maLoaiDV) references loaiDichVu(maLoaiDV),
    foreign key(maMucPhi) references mucPhi(maMucPhi),
    foreign key(dongXe) references dongXe(dongXe)
);
-- Câu 2: Nhập toàn bộ dữ liệu mẫu đã được minh họa ở trên vào cơ sở dữ liệu
insert into dongxe
values ('Civic 1.8E'  , 'honda' , 5),
       ('City 1.5G'   , 'honda' , 5),
       ('CR-V G'      , 'honda' , 7),
       ('Land Cruiser', 'toyota', 5),
       ('Vios'        , 'toyota', 5),
       ('Fortuner'    , 'toyota', 7),
       ('KIA K3'      , 'kia'   , 5),
       ('KIA SONE'    , 'kia'   , 7),
       ('KIA CARNIVAL', 'kia'   , 7);
       
insert into mucphi
values (1, 59, 'honda' ),
       (2, 69, 'toyota'),
	   (3, 49, 'kia');
       
insert into loaidichvu
values (1, 'vệ sinh'),
       (2, 'nâng cấp'),
       (3, 'thay dầu');
       
insert into nhacungcap
values (1, 'honda huệ sinh'  , 'ha noi', '0899268268', 'sfe-456213'),
       (2, 'toyota tiến lực' , 'ha noi', '0966456456', 'cbg-567126'),
       (3, 'kia hoa hải'     , 'ha noi', '0368345345', 'ocb-456456');
       
insert into dangkycungcap
values (1, 1, 3, 1, 'Civic 1.8E'  , '2021-12-12', '2022-06-30', 33),
       (2, 1, 3, 1, 'City 1.5G'   , '2021-12-12', '2022-06-30', 50),
       (3, 1, 3, 1, 'CR-V G'      , '2021-12-12', '2022-06-30', 40),
       (4, 2, 3, 2, 'Land Cruiser', '2021-12-12', '2022-06-30', 3),
       (5, 2, 3, 2, 'Vios'        , '2021-12-12', '2022-06-30', 65),
       (6, 2, 3, 2, 'Fortuner'    , '2021-12-12', '2022-06-30', 30),
       (7, 3, 3, 3, 'KIA K3'      , '2021-12-12', '2022-06-30', 20),
       (8, 3, 3, 3, 'KIA SONE'   , '2021-12-12', '2022-06-30', 45),
	   (9, 3, 3, 3, 'KIA CARNIVAL', '2021-12-12', '2022-06-30', 23);
      
-- Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ
select * from dongxe
where sochongoi > 5;

-- Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe
-- thuộc hãng xe “Toyota” với mức phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe
-- thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km
select * 
from nhacungcap join dangKyCungCap on nhacungcap.maNhaCC = dangKyCungCap.maNhaCC
				join dongxe on dangKyCungCap.dongxe = dongxe.dongxe
				join mucphi on mucphi.mamucphi = dangKyCungCap.mamucphi
where (hangxe = 'Toyota' and dongia = 100) or (hangxe = 'Kia' and dongia = 200);

-- Câu 5: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần theo mã số thuế
select * 
from nhacungcap
order by tennhacc asc,masothue desc;

-- Câu 6: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với
-- yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu
-- cung cấp là “20/11/2015”

select tenNhaCC, count(tenNhaCC)
from nhacungcap join dangKyCungCap on nhacungcap.maNhaCC = dangKyCungCap.maNhaCC
where ngayBatDau >= '2021-5-5'
group by tenNhaCC;

-- Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe
-- chỉ được liệt kê một lần

select hangxe 
from dongxe
group by hangxe;

-- Câu 8: show tất cả các lần đăng ký cung cấp phương tiện với yêu 
-- cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương
-- tiện thì cũn
select * 
from nhacungcap  left join dangKyCungCap on nhacungcap.maNhaCC = dangKyCungCap.maNhaCC
				 left join dongxe on dangKyCungCap.dongxe = dongxe.dongxe
				 left join mucphi on mucphi.mamucphi = dangKyCungCap.mamucphi;
                 
-- Câu 9: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện
-- thuộc dòng xe “Toyota” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Hundai”

select nhacungcap.*
from nhacungcap join dangKyCungCap on nhacungcap.maNhaCC = dangKyCungCap.maNhaCC
				join dongxe on dangKyCungCap.dongxe = dongxe.dongxe
Where hangxe = 'Toyota' or hangxe = 'hundai';

-- Câu 10: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp phương tiện lần nào cả.
select *
from nhacungcap left join dangKyCungCap on nhacungcap.maNhaCC = dangKyCungCap.maNhaCC
where maDKCC is null
