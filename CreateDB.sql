CREATE DATABASE EcommerceDB;
USE EcommerceDB;


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
    Address TEXT NULL
);

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


CREATE TABLE Category (
    CategoryID VARCHAR(50) PRIMARY KEY,
    CategoryName VARCHAR(100) NULL
);

CREATE TABLE CommentBlog (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    BlogID INT NULL,
    UserID INT NULL,
    Content TEXT NULL,
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

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


CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    DeliveryAddress TEXT NULL,
    Status VARCHAR(20) NULL,
    TotalAmount DECIMAL(10,2) NULL,
    BillOfLading VARCHAR(100) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID VARCHAR(50) NOT NULL,
    ProductName VARCHAR(255) NULL,
    Description TEXT NULL,
    Provider VARCHAR(100) NULL,
    Price DECIMAL(10,2) NULL,
    WarrantyPeriod VARCHAR(50) NULL,
    Amount INT NULL,
    ImageLink VARCHAR(255) NULL,
    IsPromoted BOOLEAN NULL,
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE ProductDetails (
    ProductDetailID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NULL,
    ProductDetailName VARCHAR(255) NULL,
    Value TEXT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NULL,
    ProductID INT NULL,
    Quantity INT NULL,
    Price DECIMAL(10,2) NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

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

CREATE TABLE Carts (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    Status VARCHAR(20) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

CREATE TABLE CartItems (
    CartItemID INT AUTO_INCREMENT PRIMARY KEY,
    CartID INT NULL,
    ProductID INT NULL,
    Quantity INT NULL,
    FOREIGN KEY (CartID) REFERENCES Carts(CartID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

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

CREATE TABLE Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    Description TEXT NULL,
    ReportDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NULL,
    CustomerID INT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT NULL,
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Reply (
    ReplyID INT AUTO_INCREMENT PRIMARY KEY,
    ReviewID INT NULL,
    ReplyComment TEXT NULL,
    ReplyDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ReviewID) REFERENCES Reviews(ReviewID)
);

CREATE TABLE Settings (
    SettingID INT AUTO_INCREMENT PRIMARY KEY,
    SettingType VARCHAR(100) NULL,
    SettingValue TEXT NULL,
    Status VARCHAR(20) NULL
);

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
('TBQ', 'Thiết bị quạt'), ('TBCS', 'Thiết bị chiếu sáng'), ('CTD', 'Công tắc điện'), ('TBTM', 'Thiết bị thông minh'), ('TBSCBT', 'Thiết bị sửa chữa & bảo trì'),
('SPM', 'Sản phẩm mới'), ('SPKM', 'Sản phẩm khuyến mãi');

-- Chèn dữ liệu vào bảng Products
INSERT INTO Products (CategoryID, ProductName, Description, Provider, Price, WarrantyPeriod, Amount, ImageLink, IsPromoted, CreateAt) 
VALUES
('TBQ', 'Quạt tích điện', 'Quạt sử dụng pin sạc tiện lợi.', 'ElectroCorp', 195000, '1 năm', 100, 'assets/img/TBQ-1.jpg', 1, NOW()),
('TBQ', 'Quạt hơi nước', 'Giúp làm mát không khí hiệu quả.', 'ElectroCorp', 499000, '1 năm', 50, 'assets/img/TBQ-2.jpg', 1, NOW()),
('TBQ', 'Quạt điều hòa', 'Điều hòa không khí với hơi nước.', 'ElectroCorp', 499000, '2 năm', 30, 'assets/img/TBQ-3.jpg', 1, NOW()),
('TBQ', 'Quạt trần treo tường', 'Quạt treo trần tiết kiệm diện tích.', 'ElectroCorp', 800000, '2 năm', 20, 'assets/img/TBQ-4.jpg', 0, NOW()),
('TBQ', 'Quạt treo tường', 'Dễ dàng lắp đặt và sử dụng.', 'ElectroCorp', 180000, '1 năm', 50, 'assets/img/TBQ-5.jpg', 0, NOW()),
('TBQ', 'Quạt cây', 'Quạt cây 3 tốc độ, có điều khiển.', 'ElectroCorp', 159000, '1 năm', 50, 'assets/img/TBQ-6.jpg', 0, NOW()),
('TBQ', 'Quạt phun sương tạo ẩm', 'Phun sương giúp tăng độ ẩm.', 'ElectroCorp', 3050000, '2 năm', 15, 'assets/img/TBQ-7.jpg', 1, NOW()),
('TBQ', 'Quạt sàn', 'Quạt công suất lớn cho không gian rộng.', 'ElectroCorp', 785000, '1 năm', 25, 'assets/img/TBQ-8.jpg', 0, NOW()),
('TBCS', 'Bóng đèn LED MPE LBD-50V 50W', 'Bóng đèn LED MPE LBD-50V 50W.', 'LightingCo', 290000, '2 năm', 100, 'assets/img/TBCS-1.jpg', 1, NOW()),
('TBCS', 'Đèn Led âm trần chống chói 7W', 'Đèn Led âm trần chống chói 7W.', 'LightingCo', 115000, '3 năm', 50, 'assets/img/TBCS-2.jpg', 1, NOW()),
('TBCS', 'Đèn pha LED 200w cao cấp ngoài trời', 'Đèn pha LED 200w cao cấp ngoài trời.', 'LightingCo', 795000, '2 năm', 75, 'assets/img/TBCS-3.jpg', 1, NOW()),
('TBCS', 'Bộ đèn led tuýp T8 thuỷ tinh 1,2m', 'Bộ đèn led tuýp T8 thuỷ tinh 1,2m.', 'LightingCo', 160000, '2 năm', 100, 'assets/img/TBCS-8.jpg', 0, NOW()),
('TBCS', 'Bóng đèn LED kẹp bàn 60 bóng LED', 'Đèn LED kẹp bàn tiết kiệm điện.', 'LightingCo', 96000, '2 năm', 100, 'assets/img/TBCS-5.jpg', 1, NOW()),
('TBCS', 'Đèn LED âm đất 36W', 'Đèn LED gắn âm đất.', 'LightingCo', 860000, '3 năm', 50, 'assets/img/TBCS-6.jpg', 1, NOW()),
('TBCS', 'Đèn LED thanh hắt', 'Đèn LED dài phù hợp trang trí.', 'LightingCo', 640000, '2 năm', 75, 'assets/img/TBCS-7.jpg', 1, NOW()),
('TBCS', 'Đèn LED rọi 12W mắt ếch', 'Đèn rọi giúp chiếu sáng tập trung.', 'LightingCo', 270000, '2 năm', 100, 'assets/img/TBCS-8.jpg', 0, NOW()),
('CTD', 'Bộ 3 công tắc điện 1 chiều Size S', 'Bộ 3 công tắc điện 1 chiều Size S.', 'ElectricCo', 175000, '1 năm', 500, 'assets/img/CTD-1.jpg', 0, NOW()),
('CTD', 'Công tắc 2 nút và 1 ổ cắm đôi âm tường', 'Công tắc 2 nút và 1 ổ cắm đôi âm tường.', 'ElectricCo', 180000, '2 năm', 200, 'assets/img/CTD-2.jpg', 0, NOW()),
('CTD', 'Công tắc điện quả nhót', 'Công tắc điện dạng nhỏ gọn.', 'ElectricCo', 9000, '5 năm', 500, 'assets/img/CTD-3.jpg', 0, NOW()),
('CTD', 'Công tắc ON-OFF điện 3 pha', 'Công tắc ON-OFF điện 3 pha.', 'ElectricCo', 125000, '5 năm', 200, 'assets/img/CTD-4.jpg', 0, NOW()),
('CTD', 'Công tắc điện điều khiển từ xa qua remote', 'Điều khiển từ xa qua remote tiện lợi.', 'ElectricCo', 550000, '5 năm', 100, 'assets/img/CTD-5.jpg', 1, NOW()),
('CTD', 'Công tắc bập bênh 2 chân', 'Công tắc bập bênh tiêu chuẩn.', 'ElectricCo', 8000, '5 năm', 300, 'assets/img/CTD-6.jpg', 0, NOW());

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
('Giới thiệu bộ đèn LED thanh hắt: Xu hướng mới', 'Đèn LED thanh hắt phù hợp cho trang trí hiện đại.', 1, NOW(), 'Published', 'assets/img/BV-2.jpg'),
('Quạt hơi nước hay quạt điều hòa: Đâu là sự lựa chọn hoàn hảo?', 'So sánh giữa quạt hơi nước và quạt điều hòa.', 1, NOW(), 'Published', 'assets/img/BV-3.jpg'),
('Top 10 ổ cắm điện cao cấp đáng mua nhất hiện nay', 'Danh sách các ổ cắm điện tốt nhất.', 1, NOW(), 'Published', 'assets/img/BV-4.jpg');



-- Chèn dữ liệu vào bảng Blog
INSERT INTO Blog (CateID, Title, Author, Image, BriefInfor, CreateDate, BlogContent, Status, Thumbnail, Flag, DateModified, NumberOfAccess)
VALUES
('Chia sẻ kinh nghiệm', 'Lợi ích của bóng đèn LED trong gia đình', 1, 'led_benefits.jpg', 'Bóng đèn LED giúp tiết kiệm điện và bảo vệ môi trường.', NOW(), 'Chi tiết về ưu điểm và cách chọn bóng đèn LED phù hợp.', 'Published', 'assets/img/led_thumb.jpg', 1, NOW(), 50),
('Chia sẻ kinh nghiệm', 'Cách chọn quạt điều hòa tốt nhất', 1, 'quat_tips.jpg', 'Hướng dẫn cách chọn quạt điều hòa phù hợp với không gian.', NOW(), 'Những điều cần biết khi mua quạt điều hòa cho gia đình.', 'Published', 'assets/img/quat_thumb.jpg', 1, NOW(), 40),
('Hướng dẫn sử dụng', 'Bí quyết sử dụng dây điện an toàn', 1, 'day_dien_an_toan.jpg', 'Hướng dẫn cách sử dụng dây điện đúng cách và an toàn.', NOW(), 'Cách nhận biết dây điện chất lượng và an toàn khi sử dụng.', 'Published', 'assets/img/day_dien_thumb.jpg', 1, NOW(), 30),
('Thảo luận', 'Ổ cắm điện đa năng - Giải pháp tiện lợi', 1, 'o_cam_tien_loi.jpg', 'Lợi ích của ổ cắm điện đa năng trong gia đình.', NOW(), 'Những loại ổ cắm điện đa năng tốt nhất hiện nay.', 'Published', 'assets/img/o_cam_thumb.jpg', 1, NOW(), 20),
('Thảo luận', 'Tại sao cần dùng cầu dao tự động?', 1, 'cau_dao_tu_dong.jpg', 'Công dụng và cách chọn cầu dao tự động cho nhà bạn.', NOW(), 'Hướng dẫn cách lắp đặt và sử dụng cầu dao tự động.', 'Published', 'assets/img/cau_dao_thumb.jpg', 1, NOW(), 10);

-- Chèn dữ liệu thiết bị thông minh vào bảng Products
INSERT INTO Products (CategoryID, ProductName, Description, Provider, Price, WarrantyPeriod, Amount, ImageLink, IsPromoted, CreateAt) 
VALUES
('TBTM', 'Đèn LED sạc không dây cảm ứng siêu mỏng', 'Đèn LED sạc không dây cảm ứng siêu mỏng.', 'SmartTech', 190000, '1 năm', 50, 'assets/img/TBTM-1.jpg', 0, NOW()),
('TBTM', 'Đèn LED cảm ứng chuyển động PIR', 'Đèn LED cảm ứng chuyển động PIR.', 'SmartTech', 115000, '2 năm', 80, 'assets/img/TBTM-2.jpg', 0, NOW()),
('TBTM', 'Công tắc điện cảm ứng', 'Công tắc điện cảm ứng điều khiển dễ dàng.', 'SmartTech', 520000, '3 năm', 30, 'assets/img/TBTM-3.jpg', 1, NOW()),
('TBTM', 'Khoá cửa thông minh tích hợp camera AB-24K', 'Khoá cửa thông minh tích hợp camera AB-24K, an ninh tối ưu.', 'SmartTech', 4160000, '5 năm', 20, 'assets/img/TBTM-4.jpg', 0, NOW()),
('TBTM', 'Cảm biến khói Panasonic', 'Cảm biến khói Panasonic, bảo vệ an toàn cho gia đình.', 'Panasonic', 960000, '2 năm', 50, 'assets/img/TBTM-5.jpg', 1, NOW()),
('TBTM', 'Cảm biến chuyển động', 'Cảm biến chuyển động sử dụng trong hệ thống an ninh.', 'SmartTech', 360000, '2 năm', 70, 'assets/img/TBTM-6.jpg', 0, NOW()),
('TBTM', 'Rèm thông minh điều khiển từ xa', 'Rèm thông minh điều khiển từ xa thông qua ứng dụng điện thoại.', 'SmartTech', 2140000, '3 năm', 40, 'assets/img/TBTM-7.jpg', 1, NOW()),
('TBTM', 'Cảm biến cửa SmartLock', 'Cảm biến cửa SmartLock, bảo mật và điều khiển từ xa.', 'SmartTech', 700000, '2 năm', 60, 'assets/img/TBTM-8.jpg', 1, NOW());

CREATE DATABASE EcommerceDB;
USE EcommerceDB;


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
    Address TEXT NULL
);

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


CREATE TABLE Category (
    CategoryID VARCHAR(50) PRIMARY KEY,
    CategoryName VARCHAR(100) NULL
);

CREATE TABLE CommentBlog (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    BlogID INT NULL,
    UserID INT NULL,
    Content TEXT NULL,
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

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


CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    DeliveryAddress TEXT NULL,
    Status VARCHAR(20) NULL,
    TotalAmount DECIMAL(10,2) NULL,
    BillOfLading VARCHAR(100) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID VARCHAR(50) NOT NULL,
    ProductName VARCHAR(255) NULL,
    Description TEXT NULL,
    Provider VARCHAR(100) NULL,
    Price DECIMAL(10,2) NULL,
    WarrantyPeriod VARCHAR(50) NULL,
    Amount INT NULL,
    ImageLink VARCHAR(255) NULL,
    IsPromoted BOOLEAN NULL,
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE ProductDetails (
    ProductDetailID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NULL,
    ProductDetailName VARCHAR(255) NULL,
    Value TEXT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NULL,
    ProductID INT NULL,
    Quantity INT NULL,
    Price DECIMAL(10,2) NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

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

CREATE TABLE Carts (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    Status VARCHAR(20) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

CREATE TABLE CartItems (
    CartItemID INT AUTO_INCREMENT PRIMARY KEY,
    CartID INT NULL,
    ProductID INT NULL,
    Quantity INT NULL,
    FOREIGN KEY (CartID) REFERENCES Carts(CartID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

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

CREATE TABLE Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    Description TEXT NULL,
    ReportDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NULL,
    CustomerID INT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT NULL,
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Reply (
    ReplyID INT AUTO_INCREMENT PRIMARY KEY,
    ReviewID INT NULL,
    ReplyComment TEXT NULL,
    ReplyDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ReviewID) REFERENCES Reviews(ReviewID)
);

CREATE TABLE Settings (
    SettingID INT AUTO_INCREMENT PRIMARY KEY,
    SettingType VARCHAR(100) NULL,
    SettingValue TEXT NULL,
    Status VARCHAR(20) NULL
);

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
('TBQ', 'Thiết bị quạt'), ('TBCS', 'Thiết bị chiếu sáng'), ('CTD', 'Công tắc điện'), ('TBTM', 'Thiết bị thông minh'), ('TBSCBT', 'Thiết bị sửa chữa & bảo trì'),
('SPM', 'Sản phẩm mới'), ('SPKM', 'Sản phẩm khuyến mãi');

-- Chèn dữ liệu vào bảng Products
INSERT INTO Products (CategoryID, ProductName, Description, Provider, Price, WarrantyPeriod, Amount, ImageLink, IsPromoted, CreateAt) 
VALUES
('TBQ', 'Quạt tích điện', 'Quạt sử dụng pin sạc tiện lợi.', 'ElectroCorp', 195000, '1 năm', 100, 'assets/img/TBQ-1.jpg', 1, NOW()),
('TBQ', 'Quạt hơi nước', 'Giúp làm mát không khí hiệu quả.', 'ElectroCorp', 499000, '1 năm', 50, 'assets/img/TBQ-2.jpg', 1, NOW()),
('TBQ', 'Quạt điều hòa', 'Điều hòa không khí với hơi nước.', 'ElectroCorp', 499000, '2 năm', 30, 'assets/img/TBQ-3.jpg', 1, NOW()),
('TBQ', 'Quạt trần treo tường', 'Quạt treo trần tiết kiệm diện tích.', 'ElectroCorp', 800000, '2 năm', 20, 'assets/img/TBQ-4.jpg', 0, NOW()),
('TBQ', 'Quạt treo tường', 'Dễ dàng lắp đặt và sử dụng.', 'ElectroCorp', 180000, '1 năm', 50, 'assets/img/TBQ-5.jpg', 0, NOW()),
('TBQ', 'Quạt cây', 'Quạt cây 3 tốc độ, có điều khiển.', 'ElectroCorp', 159000, '1 năm', 50, 'assets/img/TBQ-6.jpg', 0, NOW()),
('TBQ', 'Quạt phun sương tạo ẩm', 'Phun sương giúp tăng độ ẩm.', 'ElectroCorp', 3050000, '2 năm', 15, 'assets/img/TBQ-7.jpg', 1, NOW()),
('TBQ', 'Quạt sàn', 'Quạt công suất lớn cho không gian rộng.', 'ElectroCorp', 785000, '1 năm', 25, 'assets/img/TBQ-8.jpg', 0, NOW()),
('TBCS', 'Bóng đèn LED MPE LBD-50V 50W', 'Bóng đèn LED MPE LBD-50V 50W.', 'LightingCo', 290000, '2 năm', 100, 'assets/img/TBCS-1.jpg', 1, NOW()),
('TBCS', 'Đèn Led âm trần chống chói 7W', 'Đèn Led âm trần chống chói 7W.', 'LightingCo', 115000, '3 năm', 50, 'assets/img/TBCS-2.jpg', 1, NOW()),
('TBCS', 'Đèn pha LED 200w cao cấp ngoài trời', 'Đèn pha LED 200w cao cấp ngoài trời.', 'LightingCo', 795000, '2 năm', 75, 'assets/img/TBCS-3.jpg', 1, NOW()),
('TBCS', 'Bộ đèn led tuýp T8 thuỷ tinh 1,2m', 'Bộ đèn led tuýp T8 thuỷ tinh 1,2m.', 'LightingCo', 160000, '2 năm', 100, 'assets/img/TBCS-8.jpg', 0, NOW()),
('TBCS', 'Bóng đèn LED kẹp bàn 60 bóng LED', 'Đèn LED kẹp bàn tiết kiệm điện.', 'LightingCo', 96000, '2 năm', 100, 'assets/img/TBCS-5.jpg', 1, NOW()),
('TBCS', 'Đèn LED âm đất 36W', 'Đèn LED gắn âm đất.', 'LightingCo', 860000, '3 năm', 50, 'assets/img/TBCS-6.jpg', 1, NOW()),
('TBCS', 'Đèn LED thanh hắt', 'Đèn LED dài phù hợp trang trí.', 'LightingCo', 640000, '2 năm', 75, 'assets/img/TBCS-7.jpg', 1, NOW()),
('TBCS', 'Đèn LED rọi 12W mắt ếch', 'Đèn rọi giúp chiếu sáng tập trung.', 'LightingCo', 270000, '2 năm', 100, 'assets/img/TBCS-8.jpg', 0, NOW()),
('CTD', 'Bộ 3 công tắc điện 1 chiều Size S', 'Bộ 3 công tắc điện 1 chiều Size S.', 'ElectricCo', 175000, '1 năm', 500, 'assets/img/CTD-1.jpg', 0, NOW()),
('CTD', 'Công tắc 2 nút và 1 ổ cắm đôi âm tường', 'Công tắc 2 nút và 1 ổ cắm đôi âm tường.', 'ElectricCo', 180000, '2 năm', 200, 'assets/img/CTD-2.jpg', 0, NOW()),
('CTD', 'Công tắc điện quả nhót', 'Công tắc điện dạng nhỏ gọn.', 'ElectricCo', 9000, '5 năm', 500, 'assets/img/CTD-3.jpg', 0, NOW()),
('CTD', 'Công tắc ON-OFF điện 3 pha', 'Công tắc ON-OFF điện 3 pha.', 'ElectricCo', 125000, '5 năm', 200, 'assets/img/CTD-4.jpg', 0, NOW()),
('CTD', 'Công tắc điện điều khiển từ xa qua remote', 'Điều khiển từ xa qua remote tiện lợi.', 'ElectricCo', 550000, '5 năm', 100, 'assets/img/CTD-5.jpg', 1, NOW()),
('CTD', 'Công tắc bập bênh 2 chân', 'Công tắc bập bênh tiêu chuẩn.', 'ElectricCo', 8000, '5 năm', 300, 'assets/img/CTD-6.jpg', 0, NOW());

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
('Giới thiệu bộ đèn LED thanh hắt: Xu hướng mới', 'Đèn LED thanh hắt phù hợp cho trang trí hiện đại.', 1, NOW(), 'Published', 'assets/img/BV-2.jpg'),
('Quạt hơi nước hay quạt điều hòa: Đâu là sự lựa chọn hoàn hảo?', 'So sánh giữa quạt hơi nước và quạt điều hòa.', 1, NOW(), 'Published', 'assets/img/BV-3.jpg'),
('Top 10 ổ cắm điện cao cấp đáng mua nhất hiện nay', 'Danh sách các ổ cắm điện tốt nhất.', 1, NOW(), 'Published', 'assets/img/BV-4.jpg');



-- Chèn dữ liệu vào bảng Blog
INSERT INTO Blog (CateID, Title, Author, Image, BriefInfor, CreateDate, BlogContent, Status, Thumbnail, Flag, DateModified, NumberOfAccess)
VALUES
('Chia sẻ kinh nghiệm', 'Lợi ích của bóng đèn LED trong gia đình', 1, 'led_benefits.jpg', 'Bóng đèn LED giúp tiết kiệm điện và bảo vệ môi trường.', NOW(), 'Chi tiết về ưu điểm và cách chọn bóng đèn LED phù hợp.', 'Published', 'assets/img/led_thumb.jpg', 1, NOW(), 50),
('Chia sẻ kinh nghiệm', 'Cách chọn quạt điều hòa tốt nhất', 1, 'quat_tips.jpg', 'Hướng dẫn cách chọn quạt điều hòa phù hợp với không gian.', NOW(), 'Những điều cần biết khi mua quạt điều hòa cho gia đình.', 'Published', 'assets/img/quat_thumb.jpg', 1, NOW(), 40),
('Hướng dẫn sử dụng', 'Bí quyết sử dụng dây điện an toàn', 1, 'day_dien_an_toan.jpg', 'Hướng dẫn cách sử dụng dây điện đúng cách và an toàn.', NOW(), 'Cách nhận biết dây điện chất lượng và an toàn khi sử dụng.', 'Published', 'assets/img/day_dien_thumb.jpg', 1, NOW(), 30),
('Thảo luận', 'Ổ cắm điện đa năng - Giải pháp tiện lợi', 1, 'o_cam_tien_loi.jpg', 'Lợi ích của ổ cắm điện đa năng trong gia đình.', NOW(), 'Những loại ổ cắm điện đa năng tốt nhất hiện nay.', 'Published', 'assets/img/o_cam_thumb.jpg', 1, NOW(), 20),
('Thảo luận', 'Tại sao cần dùng cầu dao tự động?', 1, 'cau_dao_tu_dong.jpg', 'Công dụng và cách chọn cầu dao tự động cho nhà bạn.', NOW(), 'Hướng dẫn cách lắp đặt và sử dụng cầu dao tự động.', 'Published', 'assets/img/cau_dao_thumb.jpg', 1, NOW(), 10);



-- Code dưới đây sẽ được update khi nào cần hãy chỉ chạy code này khi có thông báo trong zalo


USE EcommerceDB;
-- Tạo bảng Category cho MarketingPosts
CREATE TABLE MarketingPostCategories (
    CategoryID VARCHAR(50) PRIMARY KEY,
    CategoryName VARCHAR(100) NULL
);

-- Cập nhật bảng MarketingPosts để thêm CategoryID liên kết với bảng MarketingPostCategories
ALTER TABLE MarketingPosts 
ADD COLUMN CategoryID VARCHAR(50),
ADD FOREIGN KEY (CategoryID) REFERENCES MarketingPostCategories(CategoryID);

-- Chèn dữ liệu mẫu vào bảng MarketingPostCategories
INSERT INTO MarketingPostCategories (CategoryID, CategoryName) 
VALUES 
('PMKT1', 'Khóa cửa thông minh'),
('PMKT2', 'Đèn LED'),
('PMKT3', 'Quạt và điều hòa'),
('PMKT4', 'Ổ cắm điện cao cấp');

ALTER TABLE users add column status varchar(12) default 'Active';
ALTER TABLE products add column status varchar(12) default 'Active';
ALTER TABLE reviews add column status varchar(12) default 'Active';
select * from products