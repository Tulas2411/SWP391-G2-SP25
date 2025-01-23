CREATE DATABASE EcommerceDB1;
USE EcommerceDB1;

CREATE TABLE Blog (
    BlogID INT NOT NULL,
    CateID INT NULL,
    Title VARCHAR(255) NULL,
    MakertingID INT NULL,
    Image VARCHAR(255) NULL,
    BriefInfor TEXT NULL,
    CreateDate DATE NULL,
    BlogContent TEXT NULL,
    Status VARCHAR(50) NULL,
    Thumbnail VARCHAR(255) NULL,
    Flag VARCHAR(50) NULL,
    DateModified DATE NULL,
    NumberOfAccess INT NULL,
    PRIMARY KEY (BlogID)
);

CREATE TABLE CartItems (
    CartItemID INT NOT NULL,
    CartID INT NULL,
    ProductID INT NULL,
    Quantity INT NULL,
    PRIMARY KEY (CartItemID)
);

CREATE TABLE Carts (
    CartID INT NOT NULL,
    CustomerID INT NULL,
    Status VARCHAR(50) NULL,
    PRIMARY KEY (CartID)
);

CREATE TABLE Category (
    CategoryID INT NOT NULL,
    CategoryName VARCHAR(255) NULL,
    PRIMARY KEY (CategoryID)
);

CREATE TABLE CategoryBlog (
    CategoryBlogID INT NOT NULL,
    CategoryBlogName VARCHAR(255) NULL,
    PRIMARY KEY (CategoryBlogID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT NOT NULL,
    OrderID INT NULL,
    ProductID INT NULL,
    Quantity INT NULL,
    Price DECIMAL(10, 2) NULL,
    PRIMARY KEY (OrderDetailID)
);

CREATE TABLE Orders (
    OrderID INT NOT NULL,
    CustomerID INT NULL,
    OrderDate DATE NULL,
    DeliveryAddress VARCHAR(255) NULL,
    Status VARCHAR(50) NULL,
    TotalAmount DECIMAL(10, 2) NULL,
    BillOfLading VARCHAR(255) NULL,
    PRIMARY KEY (OrderID)
);

CREATE TABLE Payments (
    PaymentID INT NOT NULL,
    OrderID INT NULL,
    PaymentMethod VARCHAR(50) NULL,
    Price DECIMAL(10, 2) NULL,
    PaymentDate DATE NULL,
    PaymentStatus VARCHAR(50) NULL,
    TransactionCode VARCHAR(255) NULL,
    PRIMARY KEY (PaymentID)
);

CREATE TABLE ProductDetail (
    ProductDetailID INT NOT NULL,
    ProductID INT NULL,
    ProductDetailName VARCHAR(255) NULL,
    Value TEXT NULL,
    PRIMARY KEY (ProductDetailID)
);

CREATE TABLE Products (
    ProductID INT NOT NULL,
    CategoryID INT NULL,
    ProductName VARCHAR(255) NULL,
    Description TEXT NULL,
    Provider VARCHAR(100) NULL,
    Price DECIMAL(10, 2) NULL,
    WarrantyPeriod INT NULL,
    Amount INT NULL,
    ImageLink VARCHAR(255) NULL,
    IsPromoted BOOLEAN NULL,
    CreateAt DATETIME NULL,
    PRIMARY KEY (ProductID)
);

CREATE TABLE Reply (
    ReplyID INT NOT NULL,
    ReviewID INT NULL,
    ReplyComment TEXT NULL,
    ReplyDate DATE NULL,
    PRIMARY KEY (ReplyID)
);

CREATE TABLE Reports (
    ReportID INT NOT NULL,
    CustomerID INT NULL,
    Description TEXT NULL,
    ReportDate DATE NULL,
    Status VARCHAR(50) NULL,
    PRIMARY KEY (ReportID)
);

CREATE TABLE Review (
    ReviewID INT NOT NULL,
    ProductID INT NULL,
    CustomerID INT NULL,
    Rating INT NULL,
    Comment TEXT NULL,
    ReviewDate DATE NULL,
    PRIMARY KEY (ReviewID)
);

CREATE TABLE User (
    UserID INT NOT NULL,
    FirstName VARCHAR(100) NULL,
    LastName VARCHAR(100) NULL,
    Gender VARCHAR(10) NULL,
    Date DATE NULL,
    UserName VARCHAR(50) NULL,
    Password VARCHAR(50) NULL,
    Role VARCHAR(50) NULL,
    Email VARCHAR(100) NULL,
    PhoneNumber VARCHAR(20) NULL,
    Address VARCHAR(255) NULL,
    PRIMARY KEY (UserID)
);

-- Adding Foreign Keys
ALTER TABLE Blog ADD FOREIGN KEY (CateID) REFERENCES CategoryBlog(CategoryBlogID);
ALTER TABLE Blog ADD FOREIGN KEY (MakertingID) REFERENCES User(UserID);
ALTER TABLE CartItems ADD FOREIGN KEY (CartID) REFERENCES Carts(CartID);
ALTER TABLE CartItems ADD FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
ALTER TABLE Carts ADD FOREIGN KEY (CustomerID) REFERENCES User(UserID);
ALTER TABLE OrderDetails ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
ALTER TABLE OrderDetails ADD FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
ALTER TABLE Orders ADD FOREIGN KEY (CustomerID) REFERENCES User(UserID);
ALTER TABLE Payments ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
ALTER TABLE ProductDetail ADD FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
ALTER TABLE Products ADD FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID);
ALTER TABLE Reply ADD FOREIGN KEY (ReviewID) REFERENCES Review(ReviewID);
ALTER TABLE Reports ADD FOREIGN KEY (CustomerID) REFERENCES User(UserID);
ALTER TABLE Review ADD FOREIGN KEY (CustomerID) REFERENCES User(UserID);
ALTER TABLE Review ADD FOREIGN KEY (ProductID) REFERENCES Products(ProductID);

-- Thêm dữ liệu vào bảng

-- Thêm dữ liệu vào bảng User
INSERT INTO User (UserID, FirstName, LastName, Gender, Date, UserName, Password, Role, Email, PhoneNumber, Address)
VALUES 
(1, 'Nguyễn', 'Văn An', 'Nam', '1990-01-01', 'Customer', '123', 'Customer', 'nguyenvana@gmail.com', '0912345678', 'Hà Nội'),
(2, 'Trần', 'Thị Bích', 'Nữ', '1995-02-10', 'Marketing', '123', 'Marketing', 'tranthibich@gmail.com', '0987654321', 'TP. Hồ Chí Minh'),
(3, 'Nguyễn', 'Minh Tuấn', 'Nam', '2004-11-24', 'Admin', '123', 'Admin', 'tuanminh2424@gmai.com', '0865855204', 'TP. Hồ Chí Minh');

-- Thêm dữ liệu vào bảng CategoryBlog
INSERT INTO CategoryBlog (CategoryBlogID, CategoryBlogName)
VALUES 
(1, 'Tin tức'),
(2, 'Khuyến mãi'),
(3, 'Hướng dẫn sử dụng');

-- Thêm dữ liệu vào bảng Blog
INSERT INTO Blog (BlogID, CateID, Title, MakertingID, Image, BriefInfor, CreateDate, BlogContent, Status, Thumbnail, Flag, DateModified, NumberOfAccess)
VALUES 
(1, 1, 'Cách sử dụng quạt trần tiết kiệm điện', 1, 'images/blog1.jpg', 'Hướng dẫn tiết kiệm điện với quạt trần', '2025-01-20', 'Nội dung chi tiết...', 'Published', 'images/thumbnail1.jpg', 'None', '2025-01-20', 100),
(2, 2, 'Khuyến mãi tủ lạnh Samsung', 1, 'images/blog2.jpg', 'Ưu đãi cực sốc', '2025-01-21', 'Nội dung khuyến mãi...', 'Published', 'images/thumbnail2.jpg', 'Hot', '2025-01-21', 250);


-- Thêm dữ liệu vào bảng Category
INSERT INTO Category (CategoryID, CategoryName)
VALUES 
(1, 'Quạt điện'),
(2, 'Tủ lạnh'),
(3, 'Điều hòa');

-- Thêm dữ liệu vào bảng Products
INSERT INTO Products (ProductID, CategoryID, ProductName, Description, Provider, Price, WarrantyPeriod, Amount, ImageLink, IsPromoted, CreateAt)
VALUES 
(1, 1, 'Quạt trần Panasonic', 'Quạt trần cao cấp 5 cánh', 'Panasonic', 5000000, 24, 10, 'images/quat_tran.jpg', TRUE, NOW()),
(2, 2, 'Tủ lạnh Samsung', 'Tủ lạnh Inverter 350L', 'Samsung', 12000000, 36, 5, 'images/tu_lanh.jpg', FALSE, NOW());

-- Thêm dữ liệu vào bảng Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, DeliveryAddress, Status, TotalAmount, BillOfLading)
VALUES 
(1, 1, '2025-01-20', '123 đường ABC, Hà Nội', 'Đang giao', 15500000.00, 'BL12345'),
(2, 1, '2025-01-22', '456 đường XYZ, TP. Hồ Chí Minh', 'Đã giao', 500000.00, 'BL67890');

-- Thêm dữ liệu vào bảng Payments
INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, Price, PaymentDate, PaymentStatus, TransactionCode)
VALUES 
(1, 1, 'Cash', 15500000.00, '2025-01-20', 'Thành công', 'TRANS001'),
(2, 2, 'Banking', 500000.00, '2025-01-22', 'Thành công', 'TRANS002');

-- Thêm dữ liệu vào bảng Carts
INSERT INTO Carts (CartID, CustomerID, Status)
VALUES 
(1, 2, 'Pending'),
(2, 2, 'Completed');

-- Thêm dữ liệu vào bảng CartItems
INSERT INTO CartItems (CartItemID, CartID, ProductID, Quantity)
VALUES 
(1, 1, 1, 2),
(2, 1, 2, 1);

-- Thêm dữ liệu vào bảng OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price)
VALUES 
(1, 1, 1, 2, 5000000),
(2, 1, 2, 1, 12000000);
