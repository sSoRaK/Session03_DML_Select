create database quanly_banhang;
use quanly_banhang;

-- 1. For primary key
create table NhaCungCap(
	MaNCC varchar(5) primary key,
    TenNCC varchar(50) not null,
    DiaChi varchar(50) not null,
    DienThoai varchar(15) not null,
    Email varchar(30) not null,
    Website varchar(30) null
);
create table NhanVien(
	MaNV varchar(4) primary key,
    HoTen varchar(30) not null,
    GioiTinh bit not null,
    DiaChi varchar(50) not null,
    NgaySinh datetime not null,
    DienThoai varchar(15) null,
    Email text null,
    NoiSinh varchar(20) not null,
    NgayVaoLam datetime null,
    MaNQL varchar(4) null
);
create table KhachHang(
	MaKH varchar(4) primary key,
    TenKH varchar(30) not null,
    DiaChi varchar(50) null,
    NgaySinh datetime null,
    SoDT varchar(15) null unique
);
create table LoaiSP(
	MaLoaiSP varchar(4) primary key,
    TenLoaiSP varchar(30) not null,
    Ghichu varchar(100) null
);

-- 2. For foreign key
create table SanPham(
	MaSP varchar(4) primary key,
    MaLoaiSP varchar(4) not null,
    TenSP varchar(50) not null,
    Donvitinh varchar(10) not null,
    Ghichu varchar(100) null
);
alter table SanPham
add constraint foreign key (MaLoaiSP) references LoaiSP(MaLoaiSP);

create table PhieuNhap(
	SoPN varchar(5) primary key,
    MaNV varchar(4) not null,
    MaNCC varchar(5) not null,
    NgayNhap datetime default (curdate()),
    Ghichu varchar(100) null
);
alter table PhieuNhap
add constraint foreign key (MaNV) references NhanVien(MaNV),
add constraint foreign key (MaNCC) references NhaCungCap(MaNCC);

create table PhieuXuat(
	SoPX varchar(5) primary key,
    MaNV varchar(4) not null,
    MaKH varchar(4) not null,
    NgayBan datetime default(curdate()),
    GhiChu text null
);
alter table PhieuXuat
add constraint foreign key (MaNV) references NhanVien(MaNV),
add constraint foreign key (MaKH) references KhachHang(MaKH);

create table CTPhieuNhap(
	SoPN varchar(5) not null,
	MaSP varchar(4) not null,    
    primary key(SoPN, MaSP),
    foreign key (SoPN) references PhieuNhap(SoPN),
    foreign key (MaSP) references SanPham(MaSP),    
    SoLuong smallint default 0,
    Gianhap real check(Gianhap >= 0)
);
create table CTPhieuXuat(
	SoPX varchar(5) not null,
    MaSP varchar(4) not null,
    primary key(SoPX, MaSP),
    foreign key (SoPX) references PhieuXuat(SoPX),
    foreign key (MaSP) references SanPham(MaSP),
    SoLuong smallint check(SoLuong > 0),
    GiaBan real check(GiaBan > 0)
);

-- 3. insert NhaCungCap
insert into NhaCungCap(MaNCC, TenNCC, Diachi, Dienthoai, Email, Website)
values
	('NC001', 'Nhà cung cấp 1', '12 đường abcxxx', '0307123678', 'ncc01@gmail.com', 'cungcap01.com'),
    ('NC002', 'Nhà cung cấp 2', '78 đường xxxyzaaa', '0307463617', 'ncc02@gmail.com', 'cungcap02.com');

-- Thông tin nhân viên 1
insert into NhanVien(MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL)
values 
	('E001','Nguyễn Văn A', 1,'Abc Liên Chiểu','2001-12-31','0908234567','nvae1@gmail.com','Đà Nẵng','2023-09-14','QL01'),
    ('E002','Nguyễn Văn B', 1,'Abc Hoàng Hà','2000-11-25','0908354567','nvbe2@gmail.com','Sài Gòn','2023-09-10','QL01'),
    ('E005','Nguyễn Văn C', 1,'Abc Liên Chiểu','2001-12-31','0908274563','nvce5@gmail.com','Huế','2023-09-01','QL02');
    
    -- insert info Type Product 
insert into LoaiSP(MaLoaiSP, TenLoaiSP, Ghichu)
values 
		('TP01', 'Quần áo', 'null'),
		('TP02', 'Thiết bị điện tử', 'null');

-- Insert info Product 15
insert into SanPham(MaSP, MaLoaiSP, TenSP, Donvitinh, Ghichu)
values 
	('P001', 'TP01', 'Quần kaki', 275, 'Quần'),
    ('P002', 'TP02', 'Motherboard', 750, 'Bảng mạch'),
	('P015', 'TP01', 'Ao vest', 450, 'Áo vest');


-- insert PhieuNhap
insert into PhieuNhap(SoPN, MaNV, MaNCC, NgayNhap, GhiChu)
values
	('PN001','E001','NC001','2023-09-01','Phiếu nhập 1'),
    ('PN002','E002','NC002','2023-09-07','Phiếu nhập 2'),
    ('PN003','E002','NC002','2023-09-07','Phiếu nhập 2');
    
insert into CTPhieuNhap(SoPN, MaSP, SoLuong, GiaNhap)
values
-- Phiếu nhập 1
	('PN001','P001',5,550),
    ('PN001','P002',14,2384),
-- Phiếu nhập 2
	('PN002','P015',7,680),
    ('PN002','P002',23,3408);
    
-- Info Customer 
insert into KhachHang(MaKH, TenKH, DiaChi, NgaySinh, SoDT)
values 
	('C012', 'Khách hàng 1', 'Pham Thai Hoc', '1998-10-18','090531789'),
    ('C005', 'Khách hàng 2', 'Truong Phuc', '1999-07-08','096724789'),
	('C010', 'Khách hàng 3','Pham Ngu Lao', '1998-07-08','0905624789');
    
-- insert PhieuXuat
insert into PhieuXuat(SoPX, MaNV, MaKH, NgayBan, GhiChu)
values
	('PX001','E001','C012','2023-09-01','Phiếu xuất 1'),
    ('PX002','E002','C005','2023-08-07','Phiếu xuất 2'),
    ('PX003','E002','C010','2023-09-02','Phiếu xuất 3');
    

insert into CTPhieuXuat(SoPX, MaSP, SoLuong, GiaBan)
values
-- Phiếu xuất 1
	('PX001','P001',3,125),
-- Phiếu xuất 2
    ('PX002','P002',10,782),
-- Phiếu xuất 3
    ('PX003','P001',13,1407.4);


-- Update info NhanVien
update NhanVien
set DiaChi = '13/31 Trần Cao Vân'
where MaNV = 'E005';

-- Update info KhachHang
update KhachHang
set SoDT = '0805147519'
where MaKH = 'C010';

-- Delete info Employee 1
delete from NhanVien where MaNV = 'E0005';

-- Delete info Product 15
delete from SanPham where MaSP = 'P015';


-- 1. Liệt kê NhanVien, order by Tuoi ASC
select MaNV, HoTen, GioiTinh, NgaySinh, DiaChi, DienThoai, floor(datediff(now(), NgaySinh) / 365) as Tuoi
from NhanVien
order by floor(datediff(now(), NgaySinh) / 365) ASC;

-- 2. Liệt kê hóa đơn nhập hàng trong tháng 6/2018
select SoPN, NhanVien.MaNV, NhanVien.HoTen, NhaCungCap.TenNCC, NgayNhap, Ghichu
from PhieuNhap
inner join NhaCungCap on NhaCungCap.MaNCC = PhieuNhap.MaNCC
inner join NhanVien on NhanVien.MaNV = PhieuNhap.MaNV
where month(NgayNhap) = 6 and year(NgayNhap) = 2018;

-- 3. Liệt kê SanPham có Donvitinh = 'chai'
select MaSP, MaLoaiSP, TenSP, Donvitinh, Ghichu
from SanPham
where Donvitinh = 'chai';

-- 4. Liệt kê CTPhieuNhap
select PhieuNhap.SoPN, SanPham.MaSP, SanPham.TenSP, LoaiSP.TenLoaiSP, SanPham.Donvitinh, SoLuong, GiaNhap, (SoLuong * GiaNhap) as ThanhTien
from CTPhieuNhap
inner join PhieuNhap on PhieuNhap.SoPN = CTPhieuNhap.SoPN
inner join SanPham on SanPham.MaSP = CTPhieuNhap.MaSP
inner join LoaiSP on LoaiSP.MaLoaiSP = SanPham.MaLoaiSP
where month(PhieuNhap.NgayNhap) = month(curdate());

-- 5. Liệt kê NhaCungCap có giao dịch trong tháng hiện hành
select NhaCungCap.MaNCC, TenNCC, DiaChi, DienThoai
from NhaCungCap
inner join PhieuNhap on PhieuNhap.MaNCC = NhaCungCap.MaNCC
where month(PhieuNhap.NgayNhap);




