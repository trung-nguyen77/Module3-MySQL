use exercise_quanlybanhang;
create table NhaCC(
	MaNhaCC   varchar(20)  primary key,
    TenNhaCC  varchar(50) ,
    DiaChi    varchar(255),
    SDThoai   varchar(10)
);
create table DonDatHang(
	SoDH      varchar(20)  primary key,
    NgayDH    varchar(50) ,
    MaNhaCC   varchar(50) , foreign key (MaNhaCC) references NhaCC(MaNhaCC)
);
create table VatTu(
	MaVT     varchar(20)  primary key,
    TenVT    varchar(255),
    GiaVT    double
);
create table QuanLyDonHang(
	MaQLDH   varchar(20)  primary key,
	SoDH     varchar(20) , foreign key(SoDH)    references DonDatHang(SoDH),
	MaVT     varchar(20) , foreign key(MaVT)    references VatTu(MaVT)
);

create table PhieuXuat(
	SoPX     varchar(20)  primary key,
    NgayXuat varchar(50) ,
    MaVT     varchar(20) , foreign key(MaVT)   references VatTu(MaVT)
);
create table PhieuNhap(
	SoPN     varchar(20) primary key,
    NgayNhap varchar(50) ,
	MaVT     varchar(20) , foreign key(MaVT)   references VatTu(MaVT)
);
create table QuanLyXuatHang(
	MaXuat   varchar(20) primary key,
    DGiaXuat double,
    SLXuat   double,
    SoPX     varchar(20) , foreign key(SoPX)    references PhieuXuat(SoPX),
	MaVT     varchar(20) , foreign key(MaVT)    references VatTu(MaVT)
);
create table QuanLyNhapHang(
	MaNhap  varchar(20) primary key,
    DGiaNhap double,
    SLNhap   double,
    SoPN     varchar(20) , foreign key(SoPN)    references PhieuNhap(SoPN),
	MaVT     varchar(20) , foreign key(MaVT)    references VatTu(MaVT)
);
