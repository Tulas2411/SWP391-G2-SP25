-- Tạo database
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Bảng Users
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL,
    Gender VARCHAR(10) NULL,
    DateOfBirth DATE NULL,
    UserName VARCHAR(50) UNIQUE,
    Password VARCHAR(255) NULL,
    Role VARCHAR(20) NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20) NULL,
    Address TEXT NULL,
    Status VARCHAR(12) DEFAULT 'Active'
);

-- Bảng Guest
CREATE TABLE Guest (
    GuestID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL,
    Gender VARCHAR(10) NULL,
    Email VARCHAR(100) NULL,
    PhoneNumber VARCHAR(20) NULL,
    Address TEXT NULL,
    Status VARCHAR(12) DEFAULT 'Active'
);

-- Bảng Category
CREATE TABLE Category (
    CategoryID VARCHAR(50) PRIMARY KEY,
    CategoryName VARCHAR(100) NULL
);

-- Bảng Products
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID VARCHAR(50) NOT NULL,
    ProductName VARCHAR(255) NULL,
    Description TEXT NULL,
    Provider VARCHAR(100) NULL,
    Price DECIMAL(10,2) NULL,
    OldPrice DECIMAL(10,2) NULL,
    WarrantyPeriod VARCHAR(50) NULL,
    Amount INT NULL,
    ImageLink VARCHAR(255) NULL,
    IsPromoted BOOLEAN NULL,
    Status VARCHAR(12) DEFAULT 'Active',
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Bảng ProductDetails
CREATE TABLE ProductDetails (
    ProductDetailID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NULL,
    ProductDetailName VARCHAR(255) NULL,
    Value TEXT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Bảng Orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    GuestID INT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    DeliveryAddress TEXT NULL,
    Status VARCHAR(20) NULL,
    TotalAmount DECIMAL(10,2) NULL,
    BillOfLading VARCHAR(100) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);

-- Bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NULL,
    ProductID INT NULL,
    Quantity INT NULL,
    Price DECIMAL(10,2) NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Bảng Payments
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NULL,
    PaymentMethod VARCHAR(100) NULL,
    Price DECIMAL(10,2) NULL,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentStatus VARCHAR(20) NULL,
    TransactionCode VARCHAR(255) NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Bảng Carts
CREATE TABLE Carts (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    Status VARCHAR(20) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

-- Bảng CartItems
CREATE TABLE CartItems (
    CartItemID INT AUTO_INCREMENT PRIMARY KEY,
    CartID INT NULL,
    ProductID INT NULL,
    Quantity INT NULL,
    FOREIGN KEY (CartID) REFERENCES Carts(CartID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Bảng Reviews
CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NULL,
    CustomerID INT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT NULL,
    Status VARCHAR(12) DEFAULT 'Active',
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Bảng Reply (cho Reviews)
CREATE TABLE Reply (
    ReplyID INT AUTO_INCREMENT PRIMARY KEY,
    ReviewID INT NULL,
    ReplyComment TEXT NULL,
    ReplyDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ReviewID) REFERENCES Reviews(ReviewID)
);

-- Bảng Blog
CREATE TABLE Blog (
    BlogID INT AUTO_INCREMENT PRIMARY KEY,
    CateID VARCHAR(50) NULL,
    Title VARCHAR(255) NULL,
    Author INT NOT NULL,
    Image VARCHAR(255) NULL,
    BriefInfor TEXT NULL,
    CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    BlogContent TEXT NULL,
    Status VARCHAR(20) NULL,
    Thumbnail VARCHAR(255) NULL,
    Flag BOOLEAN NULL,
    DateModified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    NumberOfAccess INT DEFAULT 0,
    FOREIGN KEY (Author) REFERENCES Users(UserID)
);

-- Bảng CommentBlog
CREATE TABLE CommentBlog (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    BlogID INT NULL,
    UserID INT NULL,
    Content TEXT NULL,
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Bảng ReplyBlog
CREATE TABLE ReplyBlog (
    ReplyID INT AUTO_INCREMENT PRIMARY KEY,
    CommentID INT NULL,
    UserID INT NULL,
    ParentReplyID INT NULL,
    Content TEXT NULL,
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CommentID) REFERENCES CommentBlog(CommentID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Bảng MarketingPosts
CREATE TABLE MarketingPosts (
    PostID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NULL,
    Content TEXT NULL,
    Author INT NULL,
    CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) NULL,
    ImageLink VARCHAR(255) NULL,
    FOREIGN KEY (Author) REFERENCES Users(UserID)
);

-- Bảng Reports
CREATE TABLE Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    Description TEXT NULL,
    ReportDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

-- Bảng Settings
CREATE TABLE Settings (
    SettingID INT AUTO_INCREMENT PRIMARY KEY,
    SettingType VARCHAR(100) NULL,
    SettingValue TEXT NULL,
    Status VARCHAR(20) NULL
);

-- Bảng Sliders
CREATE TABLE Sliders (
    SliderID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NULL,
    Image VARCHAR(255) NULL,
    Backlink VARCHAR(255) NULL,
    Status VARCHAR(20) NULL,
    BlogID INT NULL,
    ProductID INT NULL,
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Chèn dữ liệu vào bảng Users
INSERT INTO Users (FirstName, LastName, Gender, DateOfBirth, UserName, Password, Role, Email, PhoneNumber, Address)
VALUES
('Tuan', 'Minh', 'Male', '2004-11-24', 'admin', '123', 'Admin', 'admin@example.com', '1234567890', '123 Main St'),
('Tung', 'Duong', 'Male', '2004-10-12', 'sale1', '123', 'SaleManager', 'salemanager@example.com', '0987654321', '456 Oak St'),
('Duc', 'Manh', 'Female', '1992-07-10', 'sale2', '123', 'Sale', 'sale@example.com', '1122334455', '789 Pine St'),
('The', 'Quang', 'Male', '1988-11-30', 'mkt1', '123', 'Marketing', 'marketing@example.com', '2233445566', '321 Elm St'),
('Quang', 'Son', 'Male', '1995-03-25', 'customer1', '123', 'Customer', 'customer@example.com', '3344556677', '654 Birch St');

-- Chèn dữ liệu vào bảng Category
INSERT INTO Category (CategoryID, CategoryName)
VALUES 
('TBQ', 'Thiết bị quạt'),
('TBCS', 'Thiết bị chiếu sáng'),
('CTD', 'Công tắc điện'),
('TBTM', 'Thiết bị thông minh'),
('TBSCBT', 'Thiết bị sửa chữa & bảo trì'),
('SPM', 'Sản phẩm mới'),
('SPKM', 'Sản phẩm khuyến mãi');

-- Chèn dữ liệu vào bảng Products
INSERT INTO Products (CategoryID, ProductName, Description, Provider, Price, WarrantyPeriod, Amount, ImageLink, IsPromoted, CreateAt) 
VALUES
('TBQ', 'Quạt tích điện', 'Quạt sử dụng pin sạc tiện lợi.', 'ElectroCorp', 195000, '1 năm', 100, 'assets/img/TBQ-1.jpg', 1, NOW()),
('TBQ', 'Quạt hơi nước', 'Giúp làm mát không khí hiệu quả.', 'ElectroCorp', 499000, '1 năm', 50, 'assets/img/TBQ-2.jpg', 1, NOW()),
('TBQ', 'Quạt điều hòa', 'Điều hòa không khí với hơi nước.', 'ElectroCorp', 499000, '2 năm', 30, 'assets/img/TBQ-3.jpg', 1, NOW()),
('TBQ', 'Quạt trần treo tường', 'Quạt treo trần tiết kiệm diện tích.', 'ElectroCorp', 800000, '2 năm', 20, 'assets/img/TBQ-4.jpg', 0, NOW()),
('TBCS', 'Bóng đèn LED MPE LBD-50V 50W', 'Bóng đèn LED MPE LBD-50V 50W.', 'LightingCo', 290000, '2 năm', 100, 'assets/img/TBCS-1.jpg', 1, NOW()),
('TBCS', 'Đèn LED âm trần chống chói 7W', 'Đèn LED âm trần chống chói 7W.', 'LightingCo', 115000, '3 năm', 50, 'assets/img/TBCS-2.jpg', 1, NOW()),
('CTD', 'Công tắc điện điều khiển từ xa qua remote', 'Điều khiển từ xa qua remote tiện lợi.', 'ElectricCo', 550000, '5 năm', 100, 'assets/img/CTD-5.jpg', 1, NOW()),
('TBTM', 'Khoá cửa thông minh tích hợp camera AB-24K', 'Khoá cửa thông minh tích hợp camera AB-24K, an ninh tối ưu.', 'SmartTech', 4160000, '5 năm', 20, 'assets/img/TBTM-4.jpg', 0, NOW()),
('TBTM', 'Cảm biến khói Panasonic', 'Cảm biến khói Panasonic, bảo vệ an toàn cho gia đình.', 'Panasonic', 960000, '2 năm', 50, 'assets/img/TBTM-5.jpg', 1, NOW());

-- Cập nhật OldPrice cho sản phẩm khuyến mãi
UPDATE Products
SET OldPrice = Price * 1.10
WHERE IsPromoted = 1;

-- Chèn dữ liệu vào bảng Orders
INSERT INTO Orders (CustomerID, OrderDate, DeliveryAddress, Status, TotalAmount, BillOfLading)
VALUES
(1, NOW(), '123 Main St', 'Pending', 1049.98, 'BL12345'),
(2, NOW(), '456 Oak St', 'Shipped', 199.98, 'BL23456'),
(3, NOW(), '789 Pine St', 'Delivered', 29.99, 'BL34567'),
(4, NOW(), '321 Elm St', 'Processing', 149.99, 'BL45678'),
(5, NOW(), '654 Birch St', 'Pending', 999.99, 'BL56789');

-- Chèn dữ liệu vào bảng Payments
INSERT INTO Payments (OrderID, PaymentMethod, Price, PaymentDate, PaymentStatus, TransactionCode)
VALUES
(1, 'Credit Card', 1049.98, NOW(), 'Completed', 'TXN12345'),
(2, 'PayPal', 199.98, NOW(), 'Completed', 'TXN23456'),
(3, 'Credit Card', 29.99, NOW(), 'Completed', 'TXN34567'),
(4, 'Bank Transfer', 149.99, NOW(), 'Pending', 'TXN45678'),
(5, 'Credit Card', 999.99, NOW(), 'Processing', 'TXN56789');

-- Chèn dữ liệu vào bảng Reviews
INSERT INTO Reviews (ProductID, CustomerID, Rating, Comment, ReviewDate)
VALUES
(1, 1, 5, 'Excellent product!', NOW()),
(2, 2, 4, 'Good quality but a bit pricey.', NOW()),
(3, 3, 5, 'Loved this book!', NOW()),
(4, 4, 3, 'Decent chair but not very comfortable.', NOW()),
(5, 5, 4, 'Nice collectible figure.', NOW());

-- Chèn dữ liệu vào bảng MarketingPosts
INSERT INTO MarketingPosts (Title, Content, Author, CreateDate, Status, ImageLink) 
VALUES
('Khóa cửa thông minh: Bước đột phá an ninh thời 4.0', 'Khám phá công nghệ khóa cửa thông minh mới nhất.', 1, NOW(), 'Published', 'assets/img/BV-1.jpg'),
('Giới thiệu bộ đèn LED thanh hắt', 'Đèn LED thanh hắt phù hợp cho trang trí hiện đại.', 1, NOW(), 'Published', 'assets/img/BV-2.jpg');

-- Chèn dữ liệu vào bảng Blog
INSERT INTO Blog (CateID, Title, Author, Image, BriefInfor, CreateDate, BlogContent, Status, Thumbnail, Flag, DateModified, NumberOfAccess)
VALUES
('Chia sẻ kinh nghiệm', 'Lợi ích của bóng đèn LED trong gia đình', 1, 'led_benefits.jpg', 'Bóng đèn LED giúp tiết kiệm điện và bảo vệ môi trường.', NOW(), 'Chi tiết về ưu điểm và cách chọn bóng đèn LED phù hợp.', 'Published', 'assets/img/led_thumb.jpg', 1, NOW(), 50),
('Hướng dẫn sử dụng', 'Bí quyết sử dụng dây điện an toàn', 1, 'day_dien_an_toan.jpg', 'Hướng dẫn cách sử dụng dây điện đúng cách và an toàn.', NOW(), 'Cách nhận biết dây điện chất lượng và an toàn khi sử dụng.', 'Published', 'assets/img/day_dien_thumb.jpg', 1, NOW(), 30);

-- Chèn dữ liệu vào bảng Sliders
INSERT INTO Sliders (Title, Image, Backlink, Status, BlogID, ProductID) 
VALUES
('Khuyến mãi mùa hè', 'assets/img/orderdetailsslider1.jpg', 'https://example.com/khuyen-mai', 'Active', NULL, 1),
('Sản phẩm mới', 'assets/img/slider2.jpg', 'https://example.com/san-pham-moi', 'Active', NULL, 2),
('Bài viết nổi bật', 'assets/img/slider3.jpg', 'https://example.com/blog-hot', 'Active', 1, NULL),
('Giảm giá đặc biệt', 'assets/img/slider4.jpg', 'https://example.com/giam-gia', 'Inactive', NULL, 3),
('Công nghệ hiện đại', 'assets/img/slider5.jpg', 'https://example.com/cong-nghe', 'Active', 2, NULL);
('Bài viết nổi bật', 'assets/img/slider3.jpg', 'https://example.com/blog-hot', 'Active', 1, NULL);
