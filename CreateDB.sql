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
('Tuan', 'Minh', 'Male', '2004-11-24', 'admin', '123', 'Admin', 'john@example.com', '1234567890', '123 Main St'),
('JaneT', 'Smith', 'Female', '1985-09-22', 'sale1', '123', 'SaleManager', 'jane@example.com', '0987654321', '456 Oak St'),
('Alice', 'Johnson', 'Female', '1992-07-10', 'sale2', '123', 'Sale', 'alice@example.com', '1122334455', '789 Pine St'),
('Bob', 'Brown', 'Male', '1988-11-30', 'mkt1', '123', 'Marketing', 'bob@example.com', '2233445566', '321 Elm St'),
('Charlie', 'White', 'Male', '1995-03-25', 'customer1', '123', 'Customer', 'charlie@example.com', '3344556677', '654 Birch St');

-- Chèn dữ liệu vào bảng Category
INSERT INTO Category (CategoryID, CategoryName)
VALUES ('TBCS', 'Thiết bị chiếu sáng'), ('TBTM', 'Thiết bị thông minh'), ('TBQ', 'Thiết bị quạt'), ('FURN04', 'Furniture'), ('TOYS05', 'Toys');

-- Chèn dữ liệu vào bảng Products
INSERT INTO Products (CategoryID, ProductName, Description, Provider, Price, WarrantyPeriod, Amount, ImageLink, IsPromoted, CreateAt)
VALUES
('TBCS', 'Bóng đèn LED đui to 120W MPE', 'High-end smartphone', 'Tech Corp', 999.99, '2 years', 50, 'assets/img/TBCS-1.jpg', 1, NOW()),
('TBCS', 'Bóng đèn led âm tường', 'Denim blue jeans', 'Fashion Co', 49.99, '1 year', 100, 'assets/img/TBCS-2.jpg', 0, NOW()),
('TBCS', 'Bóng đèn led để sân', 'Bestselling book', 'BookHouse', 19.99, 'N/A', 200, 'assets/img/TBCS-3.jpg', 1, NOW()),
('TBTM', 'Đèn cảm ứng người đi qua âm tương', 'Ergonomic chair', 'Furniture Ltd', 149.99, '5 years', 30, 'assets/img/TBTM-1.jpg', 0, NOW()),
('TBTM', 'Bóng đèn thông minh cảm ứng', 'Superhero collectible', 'ToyWorld', 29.99, 'N/A', 75, 'assets/img/TBTM-1.jpg', 1, NOW());

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
('New Smartphone Launch', 'Introducing the latest smartphone with cutting-edge features.', 1, NOW(), 'Published', 'smartphone_launch.jpg'),
('Winter Fashion Trends', 'Discover the latest trends for this winter season.', 2, NOW(), 'Published', 'winter_fashion.jpg'),
('Bestselling Books of the Year', 'A list of the top-selling books this year.', 3, NOW(), 'Published', 'bestselling_books.jpg'),
('Ergonomic Office Chairs', 'Upgrade your office with the best ergonomic chairs.', 4, NOW(), 'Published', 'ergonomic_chair.jpg'),
('Top 10 Toys for Kids', 'Find out the most popular toys for children.', 5, NOW(), 'Published', 'top10_toys.jpg');

-- Chèn dữ liệu vào bảng Blog
INSERT INTO Blog (CateID, Title, Author, Image, BriefInfor, CreateDate, BlogContent, Status, Thumbnail, Flag, DateModified, NumberOfAccess)
VALUES
('Chia sẻ kinh nghiệm', 'Lợi ích của bóng đèn LED trong gia đình', 1, 'led_benefits.jpg', 'Bóng đèn LED giúp tiết kiệm điện và bảo vệ môi trường.', NOW(), 'Chi tiết về ưu điểm và cách chọn bóng đèn LED phù hợp.', 'Published', 'led_thumb.jpg', 1, NOW(), 50),
('Chia sẻ kinh nghiệm', 'Cách chọn quạt điều hòa tốt nhất', 1, 'quat_tips.jpg', 'Hướng dẫn cách chọn quạt điều hòa phù hợp với không gian.', NOW(), 'Những điều cần biết khi mua quạt điều hòa cho gia đình.', 'Published', 'quat_thumb.jpg', 1, NOW(), 40),
('Hướng dẫn sử dụng', 'Bí quyết sử dụng dây điện an toàn', 1, 'day_dien_an_toan.jpg', 'Hướng dẫn cách sử dụng dây điện đúng cách và an toàn.', NOW(), 'Cách nhận biết dây điện chất lượng và an toàn khi sử dụng.', 'Published', 'day_dien_thumb.jpg', 1, NOW(), 30),
('Thảo luận', 'Ổ cắm điện đa năng - Giải pháp tiện lợi', 1, 'o_cam_tien_loi.jpg', 'Lợi ích của ổ cắm điện đa năng trong gia đình.', NOW(), 'Những loại ổ cắm điện đa năng tốt nhất hiện nay.', 'Published', 'o_cam_thumb.jpg', 1, NOW(), 20),
('Thảo luận', 'Tại sao cần dùng cầu dao tự động?', 1, 'cau_dao_tu_dong.jpg', 'Công dụng và cách chọn cầu dao tự động cho nhà bạn.', NOW(), 'Hướng dẫn cách lắp đặt và sử dụng cầu dao tự động.', 'Published', 'cau_dao_thumb.jpg', 1, NOW(), 10);