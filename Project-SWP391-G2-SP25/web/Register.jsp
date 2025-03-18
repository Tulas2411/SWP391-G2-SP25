<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Đăng Kí</title>

        <!-- Font Icon -->
        <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

        <!-- Main css -->
        <link rel="stylesheet" href="css/style.css">
    </head>
    <script>
        // Hàm kiểm tra email
        function validateEmail() {
            const emailInput = document.querySelector('input[name="email"]');
            const email = emailInput.value;
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            const emailMessageDiv = document.getElementById('error-email-message');

            if (!emailRegex.test(email)) {
                emailMessageDiv.textContent = 'Email không đúng định dạng!';
                emailMessageDiv.style.color = 'red';
            } else {
                emailMessageDiv.textContent = '';
            }
        }

        // Hàm kiểm tra mật khẩu
        function validatePassword() {
            const passwordInput = document.querySelector('input[name="password"]');
            const password = passwordInput.value;
            const passwordRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$/;
            const passwordMessageDiv = document.getElementById('error-password-message');

            if (!passwordRegex.test(password)) {
                passwordMessageDiv.textContent = 'Mật khẩu phải có ít nhất 8 ký tự, chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 chữ số.';
                passwordMessageDiv.style.color = 'red';
            } else {
                passwordMessageDiv.textContent = '';
            }
        }
        function validatePhone() {
            const phoneInput = document.querySelector('input[name="contact"]');
            const phone = phoneInput.value;
            const phoneMessageDiv = document.getElementById('error-phone-message');

            if (phone.length !== 10) {
                phoneMessageDiv.textContent = 'Sai định dạng số điện thoại!';
                phoneMessageDiv.style.color = 'red';
            } else {
                phoneMessageDiv.textContent = '';
            }
        }

        // Gán sự kiện cho các trường input khi người dùng nhập liệu
        window.onload = function () {
            const emailInput = document.querySelector('input[name="email"]');
            const passwordInput = document.querySelector('input[name="password"]');
            const phoneInput = document.querySelector('input[name="contact"]');

            // Gán sự kiện cho email và mật khẩu để kiểm tra khi người dùng nhập liệu
            emailInput.addEventListener('input', validateEmail);
            passwordInput.addEventListener('input', validatePassword);
            phoneInput.addEventListener('input', validatePhone);
        }
    </script>
    <body>

        <!-- Lấy giá trị của status từ Servlet -->
        <% String status = (String) request.getAttribute("status"); %>

        <!-- Hiển thị thông báo lỗi hoặc thành công -->
        <div id="alert" style="display: none; padding: 10px; margin-bottom: 10px; border-radius: 5px;">
            <p id="alert-message"></p>
        </div>

        <script type="text/javascript">
            var status = "<%= status != null ? status : "" %>";

            // Hiển thị lỗi nếu mật khẩu không khớp
            if (status === "password_mismatch") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#f8d7da"; // Màu nền đỏ cho lỗi
                document.getElementById("alert").style.color = "#721c24"; // Màu chữ đỏ cho lỗi
                document.getElementById("alert-message").textContent = "Error: Mật khẩu và nhắc lại mật khẩu không khớp.";
            }
            // Hiển thị lỗi nếu có trường bị bỏ trống
            else if (status === "empty_fields") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#f8d7da";
                document.getElementById("alert").style.color = "#721c24";
                document.getElementById("alert-message").textContent = "Error: Vui lòng điền chính xác tất cả các trường.";
            }
            // Hiển thị thông báo thành công khi tài khoản được tạo
            else if (status === "success") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#d4edda"; // Màu nền xanh cho thành công
                document.getElementById("alert").style.color = "#155724"; // Màu chữ xanh cho thành công
                document.getElementById("alert-message").textContent = "Xin chúc mừng: Tài khoản đã được tạo thành công!";
            }
            // Hiển thị thông báo lỗi khi không thể tạo tài khoản
            else if (status === "failed") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#f8d7da";
                document.getElementById("alert").style.color = "#721c24";
                document.getElementById("alert-message").textContent = "Lỗi: Không tạo được tài khoản. Vui lòng thử lại.";
            } else if (status === "email_exists") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#f8d7da";
                document.getElementById("alert").style.color = "#721c24";
                document.getElementById("alert-message").textContent = "Lỗi: Email đã tồn tại.";
            } else if (status === "username_exists") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#f8d7da";
                document.getElementById("alert").style.color = "#721c24";
                document.getElementById("alert-message").textContent = "Lỗi: Tên người dùng đã tồn tại.";
            } else if (status === "phone_exists") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#f8d7da";
                document.getElementById("alert").style.color = "#721c24";
                document.getElementById("alert-message").textContent = "Lỗi: Số điện thoại đã tồn tại.";
            }
        </script>

        <div class="main">
            <section class="signup">
                <div class="container">
                    <div class="signup-content">
                        <div class="signup-form">
                            <h2 class="form-title">Đăng Kí</h2>
                            <form method="post" action="RegisterServlet" class="register-form" id="register-form">
                                <div class="form-group">
                                    <label for="firstname"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="text" name="firstname" id="firstname" placeholder="Họ" required="" />
                                </div>
                                <div class="form-group">
                                    <label for="lastname"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="text" name="lastname" id="lastname" placeholder="Tên" required=""/>
                                </div>
                                <div class="form-group">
                                    <label for="username"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="text" name="username" id="username" placeholder="Tên người dùng" required=""/>
                                </div>
                                <div class="form-group">
                                    <label for="gender"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <select name="gender" id="gender" required>
                                        <option value="">Giới tính</option>
                                        <option value="Male">Nam</option>
                                        <option value="Female">Nữ</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="DateOfBirth"><i class="zmdi zmdi-calendar-alt"></i></label>
                                    <input type="date" name="DateOfBirth" id="DateOfBirth" placeholder="Ngày sinh" required=""/>
                                    <br>
                                    <%
                                    if (request.getAttribute("message") != null) {
                                    out.print("<p style='color: red;'>" + request.getAttribute("message") + "</p>");
                                    }
                                    %>
                                </div>
                                <div class="form-group">
                                    <label for="email"><i class="zmdi zmdi-email"></i></label>
                                    <input type="email" name="email" id="email" placeholder="Email của bạn" required=""/>
                                </div>
                                <div id="error-email-message" style="font-size: 10px; color: red;"></div>
                                <div class="form-group">
                                    <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                    <input type="password" name="password" id="password" placeholder="Mật khẩu" required=""/>
                                </div>
                                <div id="error-password-message" style="font-size: 10px; color: red;"></div>
                                <div class="form-group">
                                    <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                    <input type="password" name="re_pass" id="re_pass" placeholder="Nhắc lại mật khẩu" required=""/>
                                </div>
                                <div class="form-group">
                                    <label for="contact"><i class="zmdi zmdi-phone"></i></label>
                                    <input type="tel" name="contact" id="contact" placeholder="Số điện thoại" pattern="0[0-9]{9}" title="The phone number must have 10 digits and start with 0" required/>
                                </div>
                                <div id="error-phone-message" style="font-size: 10px; color: red;"></div>
                                <div class="form-group">
                                    <label for="address"><i class="zmdi zmdi-pin"></i></label>
                                    <input type="text" name="address" id="address" placeholder="Địa chỉ" required=""/>
                                </div>
                                <div class="form-group form-button">
                                    <input type="submit" name="signup" id="signup" class="form-submit" value="Đăng kí" />
                                </div>
                            </form>
                        </div>
                        <div class="signup-image">
                            <figure>
                                <a href="/Project-SWP391-G2-SP25/home"><img src="assets/img/S4EWhite.png" class="header__shop-logo-img" alt="Logo linh ki?n ?i?n t?"/></a>
                            </figure>
                            <a href="Login.jsp" class="signup-image-link">Tôi đã có tài khoản!</a>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <style>
            .form-group select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 13px;
                padding-left: 30px
            }
        </style>

        <!-- JS -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>
