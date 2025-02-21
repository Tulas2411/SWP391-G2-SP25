<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Register</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="css/style.css">
</head>
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
                document.getElementById("alert-message").textContent = "Error: Password and repeat password do not match.";
            }
            // Hiển thị lỗi nếu có trường bị bỏ trống
            else if (status === "empty_fields") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#f8d7da";
                document.getElementById("alert").style.color = "#721c24";
                document.getElementById("alert-message").textContent = "Error: Please fill in all the fields correctly.";
            }
            // Hiển thị thông báo thành công khi tài khoản được tạo
            else if (status === "success") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#d4edda"; // Màu nền xanh cho thành công
                document.getElementById("alert").style.color = "#155724"; // Màu chữ xanh cho thành công
                document.getElementById("alert-message").textContent = "Congrats: Account Created Successfully!";
            }
            // Hiển thị thông báo lỗi khi không thể tạo tài khoản
            else if (status === "failed") {
                document.getElementById("alert").style.display = "block";
                document.getElementById("alert").style.backgroundColor = "#f8d7da";
                document.getElementById("alert").style.color = "#721c24";
                document.getElementById("alert-message").textContent = "Error: Failed to create account. Please try again.";
            }
        </script>

<div class="main">
    <!-- Sign up form -->
    <section class="signup">
        <div class="container">
            <div class="signup-content">
                <div class="signup-form">
                    <h2 class="form-title">Sign up</h2>
                    <form method="post" action="RegisterServlet" class="register-form" id="register-form">
                        <div class="form-group">
                            <label for="firstname"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="firstname" id="firstname" placeholder="First Name" required="" />
                        </div>
                        <div class="form-group">
                            <label for="lastname"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="lastname" id="lastname" placeholder="Last Name" required=""/>
                        </div>
                        <div class="form-group">
                            <label for="username"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="username" id="username" placeholder="User Name" required=""/>
                        </div>
                        <div class="form-group">
                            <label for="gender"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="gender" id="gender" placeholder="Gender (Male or Female)"
                                   pattern="Male|Female" title="Please enter either 'Male' or 'Female'" required />
                        </div>

                        <div class="form-group">
                            <label for="DateOfBirth"><i class="zmdi zmdi-calendar-alt"></i></label>
                            <input type="date" name="DateOfBirth" id="DateOfBirth" placeholder="Date Of Birth" required=""/>
                        </div>

                        <div class="form-group">
                            <label for="email"><i class="zmdi zmdi-email"></i></label>
                            <input type="email" name="email" id="email" placeholder="Your Email" required=""/>
                        </div>
                        <div class="form-group">
                            <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                            <input type="password" name="password" id="password" placeholder="Password" required=""/>
                        </div>
                        <div class="form-group">
                            <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                            <input type="password" name="re_pass" id="re_pass" placeholder="Repeat your password" required=""/>
                        </div>
                        <div class="form-group">
                            <label for="contact"><i class="zmdi zmdi-phone"></i></label>
                            <input type="tel" name="contact" id="contact" placeholder="Phone Number" pattern="0[0-9]{9}" title="The phone number must have 10 digits and start with 0" required/>
                        </div>
                        <div class="form-group">
                            <label for="address"><i class="zmdi zmdi-pin"></i></label>
                            <input type="text" name="address" id="address" placeholder="Address" required=""/>
                        </div>
                        <div class="form-group">
                            <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" />
                            <label for="agree-term" class="label-agree-term">
                                <span><span></span></span>I agree all statements in 
                                <a href="#" class="term-service">Terms of service</a>
                            </label>
                        </div>
                        <div class="form-group form-button">
                            <input type="submit" name="signup" id="signup" class="form-submit" value="Register" />
                        </div>
                    </form>
                </div>
                <div class="signup-image">
                    <figure>
                        <img src="images/ImageLogin.jpg" alt="sing up image">
                    </figure>
                    <a href="Login.jsp" class="signup-image-link">I am already member</a>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- JS -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>
