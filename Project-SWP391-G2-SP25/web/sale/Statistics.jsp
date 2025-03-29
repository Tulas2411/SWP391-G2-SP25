<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thống kê</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="assets/css/base.css" />
    </head>
    <body class="bg-light">
        <jsp:include page="header.jsp"/>

        <main class="container mt-4 p-4 bg-white rounded shadow">
            <h3 class="mb-4">Thống kê doanh thu</h3>

            <!-- Thanh lọc -->
            <div class="row mb-3">
                <div class="col-md-3">
                    <label for="yearSelect" class="form-label">Chọn năm:</label>
                    <select id="yearSelect" class="form-select">
                        <c:forEach var="i" begin="2023" end="2025">
                            <option value="${i}" ${i == selectedYear ? 'selected' : ''}>${i}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="daySelect" class="form-label">Chọn tháng:</label>
                    <select id="daySelect" class="form-select">
                        <c:forEach var="i" begin="1" end="12">
                            <option value="${i}" ${i == selectedMonth ? 'selected' : ''}>${i}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button id="filterBtn" class="btn btn-primary w-100">Tìm kiếm</button>
                </div>
            </div>

            <canvas id="salesChart" width="400" height="200"></canvas>
        </main>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const yearSelect = document.getElementById("yearSelect");
                const daySelect = document.getElementById("daySelect");
                const filterBtn = document.getElementById("filterBtn");
                const ctx = document.getElementById('salesChart').getContext('2d');

                yearSelect.addEventListener("change", function () {
                    daySelect.value = "1";
                });

                filterBtn.addEventListener("click", function () {
                    const selectedYear = yearSelect.value;
                    const selectedDay = daySelect.value;
                    window.location.href = "statistics?year=" + selectedYear + "&month=" + selectedDay;
                    // TODO: Gửi request AJAX hoặc cập nhật dữ liệu biểu đồ
                });
                
                const dayArr = ${dayArr};
                const totalArr = ${totalArr};
               

                let salesChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: dayArr,
                        datasets: [{
                                label: 'Doanh thu (VNĐ)',
                                data: totalArr,
                                borderColor: 'rgba(75, 192, 192, 1)',
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderWidth: 2,
                                fill: true,
                                tension: 0.3
                            }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {display: true}
                        },
                        scales: {
                            x: {title: {display: true, text: 'Ngày'}},
                            y: {title: {display: true, text: 'Doanh thu (VNĐ)'}}
                        }
                    }
                });
            });
        </script>
    </script>
</body>
</html>