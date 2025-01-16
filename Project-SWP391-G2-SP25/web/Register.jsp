<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Page</title>
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
        <jsp:include page="notification.jsp"></jsp:include>

            

            <!-- Register Form -->
            <div class="flex flex-col items-center justify-center max-h-screen mt-10">
                <h2 class="text-2xl font-bold mb-6 text-center">Register Account</h2>
                <div class="w-full max-w-lg p-6 bg-white rounded-lg shadow-lg border-2 border-zinc-500">
                    <form class="form-container" method="POST" action="MainController">
                        <input type="hidden" name="action" value="Create">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                            <div>
                                <label for="first-name" class="block text-sm font-medium text-zinc-700">First Name<span class="text-red-500">*</span></label>
                                <input type="text" id="first-name" name="firstName"
                                       class="mt-1 block w-full rounded-md shadow-sm p-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                            </div>
                            <div>
                                <label for="last-name" class="block text-sm font-medium text-zinc-700">Last Name <span class="text-red-500">*</span></label>
                                <input type="text" id="last-name" name="lastName"
                                       class="mt-1 block w-full rounded-md shadow-sm p-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                            </div>
                        </div> 
                        <div class="mb-4">
                            <label for="user-name" class="block text-sm font-medium text-zinc-700">User Name <span class="text-red-500">*</span></label>
                            <input type="text" id="user-name" name="userName"
                                   class="mt-1 block w-full rounded-md shadow-sm p-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                        </div>
                        <div class="mb-4">
                            <label for="email" class="block text-sm font-medium text-zinc-700">E Mail <span class="text-red-500">*</span></label>
                            <input type="email" id="email" name="email"
                                   class="mt-1 block w-full rounded-md shadow-sm p-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                        </div>
                        <div class="mb-4">
                            <label for="phone" class="block text-sm font-medium text-zinc-700">Phone Number <span class="text-red-500">*</span></label>
                            <input type="number" id="phone" name="phone"
                                   class="mt-1 block w-full rounded-md shadow-sm p-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                        </div>
                        <div class="mb-4">
                            <label for="address" class="block text-sm font-medium text-zinc-700">Address <span class="text-red-500">*</span></label>
                            <input type="text" id="address" name="address"
                                   class="mt-1 block w-full rounded-md shadow-sm p-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                        </div>
                        <div class="mb-4">
                            <label for="password" class="block text-sm font-medium text-zinc-700">Password <span class="text-red-500">*</span></label>
                            <input type="password" id="password" name="password"
                                   class="mt-1 block w-full rounded-md shadow-sm p-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                        </div>
                        <div class="mb-6">
                            <label for="confirm-password" class="block text-sm font-medium text-zinc-700">Confirm Password <span class="text-red-500">*</span></label>
                            <input type="password" id="confirm-password" name="confirmPassword"
                                   class="mt-1 block w-full rounded-md shadow-sm p-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                        </div>
                        <div>
                            <button type="submit"
                                    class="w-full bg-red-700 text-white py-2 rounded-md hover:bg-red-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-opacity-50">REGISTER</button>
                        </div>
                        <!-- Hiển thị thông báo lỗi nếu có -->
                        <div class="text-red-500 text-sm mt-2 text-center">
                        <c:if test="${not empty ERROR}">
                            ${ERROR}
                        </c:if>
                    </div>
                    <p class="mt-4 text-center text-gray-600">Đã có tài khoản? <a href="Login.jsp" class="text-blue-600 hover:underline">Đăng nhập ngay</a></p>
                </form>

            </div>
        </div>



    </body>
    

</html>