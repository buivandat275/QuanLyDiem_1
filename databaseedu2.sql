create database QuanLySinhVien;
-- Bảng Ngành học
CREATE TABLE NganhHoc (
    MaNganh INT PRIMARY KEY,
    TenNganh NVARCHAR(50) NOT NULL,
    DaXoa BIT DEFAULT 0
);
CREATE TABLE NguoiDung (
    UserName NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    PRIMARY KEY (UserName)
);

-- Bảng Sinh viên
CREATE TABLE SinhVien (
    MaSV INT PRIMARY KEY,
    Ho NVARCHAR(50) NOT NULL,
    Ten NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50),
    SoDienThoai NVARCHAR(15),
    MaNganh INT,
    GioiTinh NVARCHAR(10),
    DiaChi NVARCHAR(100),
    SoCMND NVARCHAR(20),
    KhoaHoc NVARCHAR(20),
    NgaySinh DATE,
    GhiChu NVARCHAR(200),
    DaXoa BIT DEFAULT 0,
    FOREIGN KEY (MaNganh) REFERENCES NganhHoc(MaNganh)
);

-- Bảng Cấu hình
CREATE TABLE CauHinh (
    SoSVToiDa INT NOT NULL
);

-- Bảng Học kỳ
CREATE TABLE HocKy (
    MaHocKy INT PRIMARY KEY,
    TenHocKy NVARCHAR(50) NOT NULL,
    Nam INT NOT NULL,
    DaXoa BIT DEFAULT 0
);

-- Bảng Loại khóa học
CREATE TABLE LoaiKhoaHoc (
    MaLoai INT PRIMARY KEY,
    TenLoai NVARCHAR(50) NOT NULL,
    DaXoa BIT DEFAULT 0
);

-- Bảng Môn học
CREATE TABLE MonHoc (
    MaMonHoc INT PRIMARY KEY,
    TenMon NVARCHAR(50) NOT NULL,
    SoTinChi INT NOT NULL,
    MaLoai INT,
    SoBuoiHoc INT NOT NULL,
    SoVangToiDa INT NOT NULL,
    DiemQuaMon FLOAT NOT NULL,
    DaXoa BIT DEFAULT 0,
    FOREIGN KEY (MaLoai) REFERENCES LoaiKhoaHoc(MaLoai)
);

-- Bảng Lớp học theo môn
CREATE TABLE LopHoc (
    MaLop INT PRIMARY KEY,
    MaMonHoc INT,
    MaHocKy INT,
    TenLop NVARCHAR(50) NOT NULL,
    DaXoa BIT DEFAULT 0,
	SoLuongSV int,
    FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc),
    FOREIGN KEY (MaHocKy) REFERENCES HocKy(MaHocKy)
);

-- Bảng Ghi danh (Sinh viên tham gia lớp học)
CREATE TABLE GhiDanh (
    MaSV INT,
    MaLop INT,
    SoBuoiVang INT DEFAULT 0,
    SoLanThi INT DEFAULT 0,
    DiemThi FLOAT,
    LanThi INT DEFAULT 1,
    PRIMARY KEY (MaSV, MaLop),
    FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV),
    FOREIGN KEY (MaLop) REFERENCES LopHoc(MaLop)
);

-- Bảng Loại điểm
CREATE TABLE LoaiDiem (
    MaLoaiDiem INT PRIMARY KEY,
    MaMonHoc INT,
    TenLoai NVARCHAR(50) NOT NULL,
    TiLePhanTram FLOAT NOT NULL,
    DaXoa BIT DEFAULT 0,
    FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc)
);

-- Bảng Điểm
CREATE TABLE Diem (
    MaDiem INT PRIMARY KEY,
    MaSV INT,
    MaLoaiDiem INT,
    DiemSo FLOAT NOT NULL,
    FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV),
    FOREIGN KEY (MaLoaiDiem) REFERENCES LoaiDiem(MaLoaiDiem)
);
-- Thêm dữ liệu vào bảng NganhHoc
INSERT INTO NganhHoc (MaNganh, TenNganh, DaXoa) VALUES (1, N'Công nghệ thông tin', 0);
INSERT INTO NganhHoc (MaNganh, TenNganh, DaXoa) VALUES (2, N'Kinh tế', 0);

-- Thêm dữ liệu vào bảng SinhVien
INSERT INTO SinhVien (MaSV, Ho, Ten, Email, SoDienThoai, MaNganh, GioiTinh, DiaChi, SoCMND, KhoaHoc, NgaySinh, GhiChu, DaXoa) 
VALUES 
(1, N'Nguyễn', N'An',  'an.nguyen@example.com', '0123456789', 1, N'Nam', N'123 Đường A, Quận B', '123456789', 'K42', '2001-01-01', NULL, 0),
(2, N'Trần', N'Hà',  'ha.tran@example.com', '0987654321', 2, N'Nữ', N'456 Đường C, Quận D', '987654321', 'K43', '2002-02-02', N'Sinh viên năm hai', 0);

-- Thêm dữ liệu vào bảng CauHinh
INSERT INTO CauHinh (SoSVToiDa) VALUES (100);

-- Thêm dữ liệu vào bảng HocKy
INSERT INTO HocKy (MaHocKy, TenHocKy, Nam, DaXoa) VALUES (1, N'Học kỳ 1', 2024, 0);
INSERT INTO HocKy (MaHocKy, TenHocKy, Nam, DaXoa) VALUES (2, N'Học kỳ 2', 2024, 0);

-- Thêm dữ liệu vào bảng LoaiKhoaHoc
INSERT INTO LoaiKhoaHoc (MaLoai, TenLoai, DaXoa) VALUES (1, N'Cơ bản', 0);
INSERT INTO LoaiKhoaHoc (MaLoai, TenLoai, DaXoa) VALUES (2, N'Nâng cao', 0);

-- Thêm dữ liệu vào bảng MonHoc
INSERT INTO MonHoc (MaMonHoc, TenMon, SoTinChi, MaLoai, SoBuoiHoc, SoVangToiDa, DiemQuaMon, DaXoa) 
VALUES 
(1,  N'Toán cao cấp', 3, 1, 45, 5, 5.0, 0),
(2,  N'Lập trình căn bản', 4, 1, 60, 8, 5.0, 0);

-- Thêm dữ liệu vào bảng LopHoc
INSERT INTO LopHoc (MaLop, MaMonHoc, MaHocKy, TenLop, DaXoa,SoLuongSV) 
VALUES 
(1, 1, 1, N'Lớp Toán 1', 0,45),
(2, 2, 1, N'Lớp Lập trình 1', 0,50);

-- Thêm dữ liệu vào bảng GhiDanh
INSERT INTO GhiDanh (MaSV, MaLop, SoBuoiVang, SoLanThi, DiemThi, LanThi) 
VALUES 
(1, 1, 2, 1, 7.5, 1),
(2, 2, 3, 1, 6.0, 1);

-- Thêm dữ liệu vào bảng LoaiDiem
INSERT INTO LoaiDiem (MaLoaiDiem, MaMonHoc, TenLoai, TiLePhanTram, DaXoa) 
VALUES 
(1, 1, N'Điểm giữa kỳ', 40.0, 0),
(2, 1, N'Điểm cuối kỳ', 60.0, 0),
(3, 2, N'Điểm thực hành', 50.0, 0),
(4, 2, N'Điểm lý thuyết', 50.0, 0);

-- Thêm dữ liệu vào bảng Diem
INSERT INTO Diem (MaDiem, MaSV, MaLoaiDiem, DiemSo) 
VALUES 
(1, 1, 1, 7.0),
(2, 1, 2, 8.0),
(3, 2, 3, 6.5),
(4, 2, 4, 7.0);
INSERT INTO [dbo].[NguoiDung] (UserName, Password)
VALUES 
('admin', '123456'),
('user1', '123');