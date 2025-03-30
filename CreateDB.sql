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
    Address TEXT NULL,
    Status VARCHAR(20) NULL,
    CreateAt DATETIME default current_timestamp
);

CREATE TABLE Category (
    CategoryID VARCHAR(50) PRIMARY KEY,
    CategoryName VARCHAR(100) NULL
);

CREATE TABLE MarketingPostsCategories (
	CategoryID VARCHAR(50) PRIMARY KEY,
    CategoryName VARCHAR(200)
);

CREATE TABLE MarketingPosts (
    PostID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID VARCHAR(50),
    Title VARCHAR(255) NULL,
    Content TEXT NULL,
    Author INT NULL,
    CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) NULL,
    ImageLink VARCHAR(255) NULL,
    FOREIGN KEY (Author) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES MarketingPostsCategories(CategoryID)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID VARCHAR(50) NOT NULL,
    ProductName VARCHAR(255) NULL,
    Description TEXT NULL,
    ProductDetail TEXT NULL,
    Provider VARCHAR(100) NULL,
    Price DECIMAL(10,2) NULL,
    OldPrice DECIMAL(10,2) NULL,
    WarrantyPeriod VARCHAR(50) NULL,
    Amount INT NULL,
    ImageLink VARCHAR(255) NULL,
    IsPromoted BOOLEAN NULL,
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    DeliveryAddress TEXT NULL,
    Status VARCHAR(20) NULL,
    TotalAmount DECIMAL(10,2) NULL,
    Comment text NULL,
    ShipperID INT NULL,
    assigned_sale_id INT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (ShipperID) REFERENCES Users(UserID),
    FOREIGN KEY (assigned_sale_id) REFERENCES Users(UserID)
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

CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NULL,
    CustomerID INT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT NULL,
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CHECK (Rating BETWEEN 1 AND 5)
);

CREATE TABLE Settings (
    SettingID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Type VARCHAR(10) NULL,
    SettingType VARCHAR(100) NULL,
    SettingValue TEXT NULL,
    priority int default 0,
    Status VARCHAR(20) NULL
);

CREATE TABLE User_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  userID INT,
  log TEXT,
  change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  email varchar(255) DEFAULT NULL,
  full_name varchar(255) DEFAULT NULL,
  gender varchar(10) DEFAULT NULL,
  mobile varchar(15) DEFAULT NULL,
  address text,
  updated_by varchar(255) DEFAULT NULL,
  FOREIGN KEY (userID) REFERENCES users(userID)
);

CREATE TABLE Sliders (
    SliderID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NULL,
    Image VARCHAR(255) NULL,
    Status VARCHAR(20) NULL,
    PostID INT NULL,
    ProductID INT NULL,
    FOREIGN KEY (PostID) REFERENCES MarketingPosts(PostID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Users (FirstName, LastName, Gender, DateOfBirth, UserName, Password, Role, Email, PhoneNumber, Address, Status, CreateAt)
VALUES
('Tung', 'Duong', 'Male', '2004-10-12', 'admin', '$2a$10$c8KRIRLOmM5YtfHURFTU/.v1qnN5xmf0FzZ3Yj5uS091KysrUKDVO', 'Admin', 'admin@example.com', '0123456789', 'Thach Hoa Ha Noi', 'Active', NOW()),
('Tuan', 'Minh', 'Male', '2004-11-24', 'shipper', '$2a$10$c8KRIRLOmM5YtfHURFTU/.v1qnN5xmf0FzZ3Yj5uS091KysrUKDVO', 'Shipper', 'shipper@example.com', '0123456789', 'Thach Hoa Ha Noi', 'Active', NOW()),
('The', 'Quang', 'Male', '2004-01-24', 'salemanager', '$2a$10$c8KRIRLOmM5YtfHURFTU/.v1qnN5xmf0FzZ3Yj5uS091KysrUKDVO', 'SaleManager', 'salemanager@example.com', '0123456789', 'Thach Hoa Ha Noi', 'Active', NOW()),
('Quang', 'Son', 'Female', '2004-11-24', 'sale1', '$2a$10$c8KRIRLOmM5YtfHURFTU/.v1qnN5xmf0FzZ3Yj5uS091KysrUKDVO', 'Sale', 'sale1@example.com', '0123456789', 'Thach Hoa Ha Noi', 'Active', NOW()),
('Duc', 'Manh', 'Male', '2004-11-24', 'marketing', '$2a$10$c8KRIRLOmM5YtfHURFTU/.v1qnN5xmf0FzZ3Yj5uS091KysrUKDVO', 'Marketing', 'marketing@example.com', '0123456789', 'Thach Hoa Ha Noi', 'Active', NOW()),
('Tuan', 'Minh', 'Male', '2004-11-24', 'sale2', '$2a$10$c8KRIRLOmM5YtfHURFTU/.v1qnN5xmf0FzZ3Yj5uS091KysrUKDVO', 'Sale', 'sale2@example.com', '0123456789', 'Thach Hoa Ha Noi', 'Active', NOW()),
('Tung', 'Duong', 'Male', '2004-11-24', 'customer1', '$2a$10$c8KRIRLOmM5YtfHURFTU/.v1qnN5xmf0FzZ3Yj5uS091KysrUKDVO', 'Customer', 'customer1@example.com', '0123456789', 'Thach Hoa Ha Noi', 'Active', NOW()),
('Manh', 'Hien', 'Female', '2004-11-24', 'customer2', '$2a$10$c8KRIRLOmM5YtfHURFTU/.v1qnN5xmf0FzZ3Yj5uS091KysrUKDVO', 'Customer', 'customer2@example.com', '0123456789', 'Thach Hoa Ha Noi', 'Active', NOW());

INSERT INTO Category (CategoryID, CategoryName)
VALUES 
('TBQ', 'Thiết bị quạt'), 
('TBCS', 'Thiết bị chiếu sáng'), 
('CTD', 'Công tắc điện'), 
('TBTM', 'Thiết bị thông minh'), 
('TBSCBT', 'Thiết bị sửa chữa & bảo trì'),
('SPM', 'Sản phẩm mới'), 
('SPKM', 'Sản phẩm khuyến mãi');

INSERT INTO Products (CategoryID, ProductName, Description, ProductDetail, Provider, Price, OldPrice, WarrantyPeriod, Amount, ImageLink, IsPromoted, status, CreateAt) 
VALUES
('TBQ', 'Quạt tích điện', 'Quạt sử dụng pin sạc tiện lợi.', 'Quạt tích điện Lumias Korea: Lựa chọn hoàn hảo cho mùa hè! Nhỏ gọn, pin trâu 12 giờ, đèn LED, xoay 60 độ. Thân thép sang trọng, sạc nhanh Type C. Mát mẻ, tiện lợi mọi lúc mọi nơi!', 'ElectroCorp', 195000, 450000, '1 năm', 100, 'assets/img/TBQ-1.jpg', 1, 'Active', NOW()),
('TBQ', 'Quạt hơi nước', 'Giúp làm mát không khí hiệu quả.', 'Quạt điều hòa hơi nươc DHHN-04 thiết kế mới hiện đại, dễ di chuyển với bánh xe, làm mát hiệu quả cho không gian từ 20 – 30m2, điều khiển dễ dàng với bảng điều khiển cảm ứng, trang bị remote điều khiển từ xa kết hợp 2 đá khô tăng hiệu suất làm mát, tự ngắt khi bơm cạn nước giúp bạn an tâm khi sử dụng.', 'ElectroCorp', 499000, 999000, '1 năm', 50, 'assets/img/TBQ-2.jpg', 1, 'Active', NOW()),
('TBQ', 'Quạt điều hòa', 'Điều hòa không khí với hơi nước.', 'Kết hợp giữa công nghệ làm mát và lọc không khí, đáp ứng nhu cầu sử dụng đa dạng của người tiêu dùng. Với thiết kế hiện đại, công nghệ tiên tiến và các tính năng ưu việt, đây là sự lựa chọn lý tưởng để cải thiện không gian sống.', 'ElectroCorp', 499000, 999000, '2 năm', 30, 'assets/img/TBQ-3.jpg', 1, 'Active', NOW()),
('TBQ', 'Quạt trần treo tường', 'Quạt treo trần tiết kiệm diện tích.', 'Không chỉ mang đến làn gió mát cho căn phòng, với thiết kế độc đáo, chiếc quạt này còn làm cho không gian trở nên nổi bật, bắt mắt hơn. Siêu phẩm mang hơi hướng phong cách hiện đại nhưng vẫn toát lên sự đơn giản sang trọng. Sự kết hợp tuyệt vời giữa chất liệu gỗ tự nhiên và thiết kế mềm mại, đơn giản nhưng thực sự độc đáo', 'ElectroCorp', 800000, 1000000, '2 năm', 20, 'assets/img/TBQ-4.jpg', 1, 'Active', NOW()),
('TBQ', 'Quạt treo tường', 'Dễ dàng lắp đặt và sử dụng.', 'Một trong những sản phẩm quạt tích điện tiên tiến, được thiết kế đặc biệt để mang lại sự tiện lợi và hiệu quả làm mát vượt trội trong mọi không gian. Với công nghệ pin Lithium-ion, quạt không chỉ mạnh mẽ, bền bỉ mà còn giúp tiết kiệm năng lượng tối đa. Cùng với nhiều tính năng nổi bật như chức năng nạp điện thoại và khả năng sử dụng trong thời gian dài, QGV1025 là lựa chọn lý tưởng cho gia đình, văn phòng và không gian công cộng.', 'ElectroCorp', 180000, 380000, '1 năm', 50, 'assets/img/TBQ-5.jpg', 1, 'Active', NOW()),
('TBQ', 'Quạt cây', 'Quạt cây 3 tốc độ, có điều khiển.', 'Thiết kế mới hiện đại, dễ di chuyển với bánh xe, làm mát hiệu quả cho không gian từ 20 – 30m2, điều khiển dễ dàng với bảng điều khiển cảm ứng, trang bị remote điều khiển từ xa kết hợp 2 đá khô tăng hiệu suất làm mát, tự ngắt khi bơm cạn nước giúp bạn an tâm khi sử dụng.', 'ElectroCorp', 159000, 359000 ,'1 năm', 50, 'assets/img/TBQ-6.jpg', 1, 'Active', NOW()),
('TBQ', 'Quạt phun sương tạo ẩm', 'Phun sương giúp tăng độ ẩm.', 'Kết hợp giữa công nghệ làm mát và lọc không khí, đáp ứng nhu cầu sử dụng đa dạng của người tiêu dùng. Với thiết kế hiện đại, công nghệ tiên tiến và các tính năng ưu việt, đây là sự lựa chọn lý tưởng để cải thiện không gian sống.', 'ElectroCorp', 3050000, 4050000, '2 năm', 15, 'assets/img/TBQ-7.jpg', 1, 'Active', NOW()),
('TBQ', 'Quạt sàn', 'Quạt công suất lớn cho không gian rộng.', 'Không chỉ mang đến làn gió mát cho căn phòng, với thiết kế độc đáo, chiếc quạt này còn làm cho không gian trở nên nổi bật, bắt mắt hơn, chiếc quạt này còn làm cho không gian trở nên nổi bật, bắt mắt hơn.', 'ElectroCorp', 785000, 985000, '1 năm', 25, 'assets/img/TBQ-8.jpg', 1, 'Active', NOW()),
('TBCS', 'Bóng đèn LED MPE LBD-50V 50W', 'Bóng đèn LED MPE LBD-50V 50W.', 'Đèn Led búp trụ MPE 50w thân nhôm đúc  cao cấp được bao bọc bởi lớp vỏ phản quang từ nhựa PMMA cho khả năng phân bổ ánh sáng đồng đều, giảm độ chói và quan trọng là mang lại hiệu quả chiếu sáng tối ưu với độ hoàn màu đạt Ra >80', 'LightingCo', 290000, 500000, '2 năm', 100, 'assets/img/TBCS-1.jpg', 1, 'Active', NOW()),
('TBCS', 'Đèn Led âm trần chống chói 7W', 'Đèn Led âm trần chống chói 7W.', 'Đèn LED 3 màu được điều khiển tắt bật riêng với quạt nên cũng rất tiện lợi trong quá trình sử dụng khi mà muốn chỉ bật riêng đèn hoặc bật riêng quạt. Động cơ DC tiết kiệm điện, tuy công suất 50W nhưng khỏe gấp đôi so với động cơ AC tương tự.', 'LightingCo', 115000, 200000, '3 năm', 50, 'assets/img/TBCS-2.jpg', 1, 'Active', NOW()),
('TBCS', 'Đèn pha LED 200w cao cấp ngoài trời', 'Đèn pha LED 200w cao cấp ngoài trời.', 'Đèn Led búp trụ MPE 50w thân nhôm đúc  cao cấp được bao bọc bởi lớp vỏ phản quang từ nhựa PMMA cho khả năng phân bổ ánh sáng đồng đều, giảm độ chói và quan trọng là mang lại hiệu quả chiếu sáng tối ưu với độ hoàn màu đạt Ra >80 ', 'LightingCo', 795000, 995000, '2 năm', 75, 'assets/img/TBCS-3.jpg', 1, 'Active', NOW()),
('TBCS', 'Bộ đèn led tuýp T8 thuỷ tinh 1,2m', 'Bộ đèn led tuýp T8 thuỷ tinh 1,2m.', 'Đèn LED âm trần siêu mỏng (không mắt) đa dạng mẫu mã phù hợp nhiều không gian sống với độ chiếu sáng tốt do sử dụng chip LED phát sáng. Đèn LED âm trần có tuổi thọ cao. Tuổi thọ trung bình của một bóng đèn lên đến 50.000 giờ.', 'LightingCo', 160000, 250000, '2 năm', 100, 'assets/img/TBCS-8.jpg', 1, 'Active', NOW()),
('TBCS', 'Bóng đèn LED kẹp bàn 60 bóng LED', 'Đèn LED kẹp bàn tiết kiệm điện.', 'Công tắc đóng ngắt điện điều khiển từ xa 220v, 100m, 3000w, 30a. Dùng để điều khiển đóng ngắt thiết bị điện từ xa như: đèn, quạt, máy bơm nước ….vvvv. Với công suất tải tối đa 3000W hoặc có dòng khởi động tối đa 30a', 'LightingCo', 96000, 115000, '2 năm', 100, 'assets/img/TBCS-5.jpg', 1, 'Active', NOW()),
('TBCS', 'Đèn LED âm đất 36W', 'Đèn LED gắn âm đất.', 'Đèn LED 3 màu được điều khiển tắt bật riêng với quạt nên cũng rất tiện lợi trong quá trình sử dụng khi mà muốn chỉ bật riêng đèn hoặc bật riêng quạt. Động cơ DC tiết kiệm điện, tuy công suất 50W nhưng khỏe gấp đôi so với động cơ AC tương tự.', 'LightingCo', 860000, 1000000, '3 năm', 50, 'assets/img/TBCS-6.jpg', 1, 'Active', NOW()),
('TBCS', 'Đèn LED thanh hắt', 'Đèn LED dài phù hợp trang trí.', 'Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.chiếc quạt này còn làm cho không gian trở nên nổi bật, bắt mắt hơn.', 'LightingCo', 640000, 850000, '2 năm', 75, 'assets/img/TBCS-7.jpg', 1, 'Active', NOW()),
('TBCS', 'Đèn LED rọi 12W mắt ếch', 'Đèn rọi giúp chiếu sáng tập trung.', 'Đèn rọi giúp chiếu sáng tập trung.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.', 'LightingCo', 270000, 540000, '2 năm', 100, 'assets/img/TBCS-8.jpg', 1, 'Active', NOW()),
('SPKM', 'Quạt tích điện', 'Quạt sử dụng pin sạc tiện lợi.', 'Quạt tích điện Lumias Korea: Lựa chọn hoàn hảo cho mùa hè! Nhỏ gọn, pin trâu 12 giờ, đèn LED, xoay 60 độ. Thân thép sang trọng, sạc nhanh Type C. Mát mẻ, tiện lợi mọi lúc mọi nơi!', 'ElectroCorp', 195000, 450000, '1 năm', 100, 'assets/img/TBQ-1.jpg', 1, 'Active', NOW()),
('SPKM', 'Bóng đèn LED kẹp bàn 60 bóng LED', 'Đèn LED kẹp bàn tiết kiệm điện.', 'Công tắc đóng ngắt điện điều khiển từ xa 220v, 100m, 3000w, 30a. Dùng để điều khiển đóng ngắt thiết bị điện từ xa như: đèn, quạt, máy bơm nước ….vvvv. Với công suất tải tối đa 3000W hoặc có dòng khởi động tối đa 30a', 'LightingCo', 96000, 115000, '2 năm', 100, 'assets/img/TBCS-5.jpg', 1, 'Active', NOW()),
('SPKM', 'Đèn LED rọi 12W mắt ếch', 'Đèn rọi giúp chiếu sáng tập trung.', 'Đèn rọi giúp chiếu sáng tập trung.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.Đèn LED dài phù hợp trang trí.', 'LightingCo', 270000, 540000, '2 năm', 100, 'assets/img/TBCS-8.jpg', 1, 'Active', NOW()),
('SPKM', 'Bóng đèn LED kẹp bàn 60 bóng LED', 'Đèn LED kẹp bàn tiết kiệm điện.', 'Công tắc đóng ngắt điện điều khiển từ xa 220v, 100m, 3000w, 30a. Dùng để điều khiển đóng ngắt thiết bị điện từ xa như: đèn, quạt, máy bơm nước ….vvvv. Với công suất tải tối đa 3000W hoặc có dòng khởi động tối đa 30a', 'LightingCo', 96000, 115000, '2 năm', 100, 'assets/img/TBCS-5.jpg', 1, 'Active', NOW()),
('SPKM', 'Quạt trần treo tường', 'Quạt treo trần tiết kiệm diện tích.', 'Không chỉ mang đến làn gió mát cho căn phòng, với thiết kế độc đáo, chiếc quạt này còn làm cho không gian trở nên nổi bật, bắt mắt hơn. Siêu phẩm mang hơi hướng phong cách hiện đại nhưng vẫn toát lên sự đơn giản sang trọng. Sự kết hợp tuyệt vời giữa chất liệu gỗ tự nhiên và thiết kế mềm mại, đơn giản nhưng thực sự độc đáo', 'ElectroCorp', 800000, 1000000, '2 năm', 20, 'assets/img/TBQ-4.jpg', 1, 'Active', NOW()),
('TBTM', 'Đèn LED sạc không dây cảm ứng siêu mỏng', 'Đèn LED sạc không dây cảm ứng siêu mỏng.', 'Đèn Led búp trụ MPE 50w thân nhôm đúc  cao cấp được bao bọc bởi lớp vỏ phản quang từ nhựa PMMA cho khả năng phân bổ ánh sáng đồng đều, giảm độ chói và quan trọng là mang lại hiệu quả chiếu sáng tối ưu với độ hoàn màu đạt Ra >80', 'SmartTech', 170000, 190000, '1 năm', 50, 'assets/img/TBTM-1.jpg', 1, 'Active', NOW()),
('TBTM', 'Đèn LED cảm ứng chuyển động PIR', 'Đèn LED cảm ứng chuyển động PIR.', 'Đèn LED âm trần siêu mỏng (không mắt) đa dạng mẫu mã phù hợp nhiều không gian sống với độ chiếu sáng tốt do sử dụng chip LED phát sáng', 'SmartTech', 115000, 125000, '2 năm', 80, 'assets/img/TBTM-2.jpg', 1, 'Active', NOW()),
('TBTM', 'Công tắc điện cảm ứng', 'Công tắc điện cảm ứng điều khiển dễ dàng.', 'Kết hợp giữa công nghệ làm mát và lọc không khí, đáp ứng nhu cầu sử dụng đa dạng của người tiêu dùng. Với thiết kế hiện đại, công nghệ tiên tiến và các tính năng ưu việt, đây là sự lựa chọn lý tưởng để cải thiện không gian sống. ', 'SmartTech', 520000, 590000,'3 năm', 30, 'assets/img/TBTM-3.jpg', 1, 'Active', NOW()),
('TBTM', 'Khoá cửa thông minh tích hợp camera AB-24K', 'Khoá cửa thông minh tích hợp camera AB-24K, an ninh tối ưu.', '7 đặc điểm nổi trội: mật khẩu, thẻ từ, vân tay, khoá cơ, app mở khoá từ xa và camera, chuông cửa. Chuông cửa và camera góc rộng tích hợp ngay trên sản phẩm', 'SmartTech', 4160000, 4260000, '5 năm', 20, 'assets/img/TBTM-4.jpg', 1, 'Active', NOW()),
('TBTM', 'Cảm biến khói Panasonic', 'Cảm biến khói Panasonic, bảo vệ an toàn cho gia đình.', 'Chức năng: Cảm ứng báo cháy (phát hiện ra khói) Màu sắc:  Trắng Nguồn cấp: Pin dự phòng', 'Panasonic', 960000, 1060000, '2 năm', 50, 'assets/img/TBTM-5.jpg', 1, 'Active', NOW()),
('TBTM', 'Cảm biến chuyển động', 'Cảm biến chuyển động sử dụng trong hệ thống an ninh.', 'Sử dụng sóng RF-315Mhz Khoảng cách điều khiển 1000M( Thực tế khoảng 600-800M tuỳ vào môi trường có nhiều vật cản hay không)', 'SmartTech', 360000, 390000,'2 năm', 70, 'assets/img/TBTM-6.jpg', 1, 'Active', NOW()),
('TBTM', 'Rèm thông minh điều khiển từ xa', 'Rèm thông minh điều khiển từ xa thông qua ứng dụng điện thoại.', 'Có thể tích hợp được 16 remote tay điều khiển cùng một lúc Có nút nguồn bật tắt trực tiếp bằng tay trên mạch công tắc', 'SmartTech', 2140000, 2640000, '3 năm', 40, 'assets/img/TBTM-7.jpg', 1, 'Active', NOW()),
('TBTM', 'Cảm biến cửa SmartLock', 'Cảm biến cửa SmartLock, bảo mật và điều khiển từ xa.', 'Dùng để điều khiển đóng ngắt thiết bị điện từ xa như: đèn, quạt, máy bơm nước ….vvvv', 'SmartTech', 700000, 800000, '2 năm', 60, 'assets/img/TBTM-8.jpg', 1, 'Active', NOW()),
('CTD', 'Bộ 3 công tắc điện 1 chiều Size S', 'Bộ 3 công tắc điện 1 chiều Size S.', 'Với công suất tải tối đa 3000W hoặc có dòng khởi động tối đa 30a', 'ElectricCo', 175000, 195000, '1 năm', 500, 'assets/img/CTD-1.jpg', 1, 'Active', NOW()),
('CTD', 'Công tắc 2 nút và 1 ổ cắm đôi âm tường', 'Công tắc 2 nút và 1 ổ cắm đôi âm tường.',  'Công tắc 2 nút và 1 ổ cắm đôi âm tường.', 'ElectricCo', 180000, 200000, '2 năm', 200, 'assets/img/CTD-2.jpg', 1, 'Active', NOW()),
('CTD', 'Công tắc điện quả nhót', 'Công tắc điện dạng nhỏ gọn.', 'Công tắc điện dạng nhỏ gọn. Công tắc điện dạng nhỏ gọn. Công tắc điện dạng nhỏ gọn. Công tắc điện dạng nhỏ gọn.','ElectricCo', 9000, 11000,'5 năm', 500, 'assets/img/CTD-3.jpg', 1, 'Active', NOW()),
('CTD', 'Công tắc ON-OFF điện 3 pha', 'Công tắc ON-OFF điện 3 pha.', 'Công tắc ON-OFF điện 3 pha. Công tắc ON-OFF điện 3 pha. Công tắc ON-OFF điện 3 pha.', 'ElectricCo', 125000,  165000, '5 năm', 200, 'assets/img/CTD-4.jpg', 1, 'Active', NOW()),
('CTD', 'Công tắc điện điều khiển từ xa qua remote', 'Điều khiển từ xa qua remote tiện lợi.', 'Điều khiển từ xa qua remote tiện lợi. Điều khiển từ xa qua remote tiện lợi. Điều khiển từ xa qua remote tiện lợi.', 'ElectricCo', 550000, 590000, '5 năm', 100, 'assets/img/CTD-5.jpg', 1, 'Active', NOW()),
('CTD', 'Công tắc bập bênh 2 chân', 'Công tắc bập bênh tiêu chuẩn.', 'Công tắc bập bênh tiêu chuẩn. Công tắc bập bênh tiêu chuẩn. Công tắc bập bênh tiêu chuẩn. Công tắc bập bênh tiêu chuẩn.', 'ElectricCo', 8000, 12000, '5 năm', 300, 'assets/img/CTD-6.jpg', 1, 'Active', NOW()),
('SPM', 'Bộ 3 công tắc điện 1 chiều Size S', 'Bộ 3 công tắc điện 1 chiều Size S.', 'Với công suất tải tối đa 3000W hoặc có dòng khởi động tối đa 30a', 'ElectricCo', 175000, 195000, '1 năm', 500, 'assets/img/CTD-1.jpg', 1, 'Active', NOW()),
('SPM', 'Cảm biến cửa SmartLock', 'Cảm biến cửa SmartLock, bảo mật và điều khiển từ xa.', 'Dùng để điều khiển đóng ngắt thiết bị điện từ xa như: đèn, quạt, máy bơm nước ….vvvv', 'SmartTech', 700000, 800000, '2 năm', 60, 'assets/img/TBTM-8.jpg', 1, 'Active', NOW()),
('SPM', 'Quạt tích điện', 'Quạt sử dụng pin sạc tiện lợi.', 'Quạt tích điện Lumias Korea: Lựa chọn hoàn hảo cho mùa hè! Nhỏ gọn, pin trâu 12 giờ, đèn LED, xoay 60 độ. Thân thép sang trọng, sạc nhanh Type C. Mát mẻ, tiện lợi mọi lúc mọi nơi!', 'ElectroCorp', 195000, 450000, '1 năm', 100, 'assets/img/TBQ-1.jpg', 1, 'Active', NOW()),
('SPM', 'Quạt cây', 'Quạt cây 3 tốc độ, có điều khiển.', 'Thiết kế mới hiện đại, dễ di chuyển với bánh xe, làm mát hiệu quả cho không gian từ 20 – 30m2, điều khiển dễ dàng với bảng điều khiển cảm ứng, trang bị remote điều khiển từ xa kết hợp 2 đá khô tăng hiệu suất làm mát, tự ngắt khi bơm cạn nước giúp bạn an tâm khi sử dụng.', 'ElectroCorp', 159000, 359000 ,'1 năm', 50, 'assets/img/TBQ-6.jpg', 1, 'Active', NOW()),
('SPM', 'Quạt tích điện', 'Quạt sử dụng pin sạc tiện lợi.', 'Quạt tích điện Lumias Korea: Lựa chọn hoàn hảo cho mùa hè! Nhỏ gọn, pin trâu 12 giờ, đèn LED, xoay 60 độ. Thân thép sang trọng, sạc nhanh Type C. Mát mẻ, tiện lợi mọi lúc mọi nơi!', 'ElectroCorp', 195000, 450000, '1 năm', 100, 'assets/img/TBQ-1.jpg', 1, 'Active', NOW());

INSERT INTO MarketingPostsCategories (CategoryID, CategoryName) 
VALUES
('CT', 'Chương trình'),
('GTSP', 'Giới thiệu sản phẩm'),
('HĐCH', 'Hoạt động cửa hàng'),
('KM', 'Khuyến mãi'),
('KT', 'Kiến thức');

INSERT INTO MarketingPosts (Title, CategoryID, Content, Author, CreateDate, Status, ImageLink) 
VALUES
('Khóa cửa thông minh: Bước đột phá an ninh thời 4.0', 'GTSP', 'Khám phá công nghệ khóa cửa thông minh mới nhất.', 1, NOW(), 'Published', 'assets/img/BV-1.jpg'),
('Giới thiệu bộ đèn LED thanh hắt: Xu hướng mới', 'CT', 'Đèn LED thanh hắt phù hợp cho trang trí hiện đại.', 1, NOW(), 'Published', 'assets/img/BV-2.jpg'),
('Quạt hơi nước hay quạt điều hòa: Đâu là sự lựa chọn hoàn hảo?', 'KT', 'So sánh giữa quạt hơi nước và quạt điều hòa.', 1, NOW(), 'Published', 'assets/img/BV-3.jpg'),
('Top 10 ổ cắm điện cao cấp đáng mua nhất hiện nay', 'HĐCH', 'Danh sách các ổ cắm điện tốt nhất.', 1, NOW(), 'Published', 'assets/img/BV-4.jpg');

INSERT INTO Reviews (ReviewID, ProductID, CustomerID, Rating, Comment, ReviewDate, status) VALUES
(1, 1, 1, 5, 'Excellent product!', '2025-02-04 14:24:05', 'Active'),
(2, 2, 2, 4, 'Good quality but a bit pricey.', '2025-02-04 14:24:05', 'Active'),
(3, 3, 3, 5, 'Loved this book!', '2025-02-04 14:24:05', 'Active'),
(4, 4, 4, 3, 'Decent chair but not very comfortable.', '2025-02-04 14:24:05', 'Active'),
(5, 5, 5, 4, 'Nice collectible figure.', '2025-02-04 14:24:05', 'Active'),
(6, 6, 5, 4, 'Nice collectible figure.', '2025-02-06 08:23:51', 'Active');