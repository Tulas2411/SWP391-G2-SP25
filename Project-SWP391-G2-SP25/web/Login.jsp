<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            .nav-link {
                transition: all 0.3s ease;
            }

            .nav-link:hover {
                transform: translateY(-5px);
                text-align: center;
            }
        </style>

    </head>

    <body class="bg-gray-100">
        


        <!-- Login Form -->
        <div class="flex items-center justify-center max-h-screen mt-10">
            <div class="w-full max-w-sm bg-white p-8 border border-gray-300 rounded-lg shadow-lg">
                <h2 class="text-center text-2xl font-bold text-gray-800">Login</h2>
                <form class="mt-8 space-y-6" method="POST" action="MainController">
                    <input type="hidden" name="action" value="Login">
                    <div>
                        <label for="identifier" class="block text-sm font-medium text-gray-700"> Email <span class="text-red-500">*</span></label>
                        <input id="identifier" name="identifier" type="text" value="${cookie.cuser.value}" autocomplete="identifier" required
                               class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-purple-500 focus:border-purple-500 sm:text-sm">
                    </div>
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700">Password <span class="text-red-500">*</span></label>
                        <input id="password" value="${cookie.cpass.value}" name="password" type="password" autocomplete="current-password" required
                               class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-purple-500 focus:border-purple-500 sm:text-sm">
                    </div>
                        <div class="flex items-center justify-between w-full">
                            <div class="flex items-center">
                                <input id="remember_me" name="remember_me" type="checkbox" ${(cookie.crem != null ? 'checked' : '')}
                                       class="h-4 w-4 text-purple-600 focus:ring-purple-500 border-gray-300 rounded">
                                <label for="remember_me" class="ml-2 block text-sm text-gray-900">Remember me</label>
                            </div>
                            <div>
                                <a href="FogotPassword.jsp" class="text-blue-600 hover:underline">Quên mật khẩu</a>
                            </div>
                        </div>
                    <div>
                        <button type="submit" id="loginButton"
                                class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-red-700 hover:bg-red-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500">Login</button>
                    </div>
                                       <div class="col-12 col-lg-5 d-flex align-items-center">
                                           <div class="d-flex gap-3 flex-column w-100 ">
                                               <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid

                                                  &redirect_uri=http://localhost:8080/Project-SWP391-G2-SP25/login

                                                  &response_type=code

                                                  &client_id=866774894508-v9kd2v9dr8gghgl8vghdg14dflmnoj9n.apps.googleusercontent.com

                                                  &approval_prompt=force" class="btn btn-lg btn-danger">
                                                   <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16">
                                                   <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                                                   </svg>
                                                   <span class="ms-2 fs-6">Sign in with Google</span>
                                               </a>
                                           </div>


          
                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <div class="text-red-500 text-sm mt-2 text-center">
                        <c:if test="${not empty ERROR}">
                            ${ERROR}
                        </c:if>
                    </div>
                </form>
                <p class="mt-4 text-center text-gray-600">Chưa có tài khoản? <a href="Register.jsp"
                                                                                class="text-blue-600 hover:underline">Đăng ký ngay</a></p>
            </div>
        </div>




    </body>

</html>