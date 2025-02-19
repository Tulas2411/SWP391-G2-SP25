<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Register</title>

        <!-- Font Icon -->
        <link rel="stylesheet"
              href="fonts/material-icon/css/material-design-iconic-font.min.css">

        <!-- Main css -->
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        
        <input type="hidden" id="status" value="<%= request.getAttribute("status")%>">

        <div class="main">

            <!-- Sign up form -->
            <section class="signup">
                <div class="container">
                    <div class="signup-content">
                        <div class="signup-form">
                            <h2 class="form-title">Sign up</h2>

                            <form method="post" action="RegisterServlet" class="register-form"
                                  id="register-form">
                                <div class="form-group">
                                    <label for="firstname"><i
                                            class="zmdi zmdi-account material-icons-name"></i></label> <input
                                        type="text" name="firstname" id="firstname" placeholder="First Name" />
                                </div>
                                <div class="form-group">
                                    <label for="lastname"><i class="zmdi zmdi-account material-icons-name"></i></label> <input
                                        type="text" name="lastname" id="lastname" placeholder="Last Name" />
                                </div>
                                <div class="form-group">

                                    <label for="username"><i class="zmdi zmdi-account material-icons-name"></i></label> <input
                                        type="text" name="username" id="username" placeholder="User Name" />
                                </div>
                                <div class="form-group">
                                    <label for="gender"><i class="zmdi zmdi-account material-icons-name"></i></label> 
                                    <input type="text" name="gender" id="gender" placeholder="Gender (Male or Female)"
                                           pattern="Male|Female" title="Please enter either 'Male' or 'Female'" required />
                                </div>

                                <div class="form-group">
                     <label for="DateOfBirth"><i class="zmdi zmdi-calendar-alt"></i></label> <input
                                        type="date" name="DateOfBirth" id="DateOfBirth" placeholder="Date Of Birth" />
                                </div>
                                
                                <div class="form-group">
                                    <label for="email"><i class="zmdi zmdi-email"></i></label> <input
                                        type="email" name="email" id="email" placeholder="Your Email" />
                                </div>
                                <div class="form-group">
                                    <label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
                                        type="password" name="password" id="password" placeholder="Password" />
                                </div>
                                <div class="form-group">
                                    <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                    <input type="password" name="re_pass" id="re_pass"
                                           placeholder="Repeat your password" />
                                </div>
                                <div class="form-group">
                                    <label for="contact"><i class="zmdi zmdi-phone"></i></label>
                                    <input type="text" name="contact" id="contact"
                                           placeholder="Phone Number" />
                                </div>
                                <div class="form-group">
                                    <label for="address"><i class="zmdi zmdi-pin"></i></label>
                                    <input type="text" name="address" id="address"
                                           placeholder="Address" />
                                </div>
                                <div class="form-group">
                                    <input type="checkbox" name="agree-term" id="agree-term"
                                           class="agree-term" /> <label for="agree-term"
                                           class="label-agree-term"><span><span></span></span>I
                                        agree all statements in <a href="#" class="term-service">Terms
                                            of service</a></label>
                                </div>
                                <div class="form-group form-button">
                                    <input type="submit" name="signup" id="signup"
                                           class="form-submit" value="Register" />
                                </div>
                            </form>
                        </div>
                        <div class="signup-image">
                            <figure>
                                <img src="images/ImageLogin.jpg" alt="sing up image">
                            </figure>
                            <a href="Login.jsp" class="signup-image-link">I am already
                                member</a>
                        </div>
                    </div>
                </div>
            </section>


        </div>
        <!-- JS -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="js/main.js"></script>
        <script src ="http://inpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel ="stylesheet" href="alert/dist/sweetalert.css">
        
        <script type="text/javascript">
            var status = document.getElementById("status").value;
            if(status == "success"){
                swal("Congrats", "Account Created Successfully","success");
            }
            
        </script>



    </body>
    <!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>