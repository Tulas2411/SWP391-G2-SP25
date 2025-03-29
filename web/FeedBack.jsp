<%-- 
    Document   : FeedBack.jsp
    Created on : Mar 5, 2025, 4:27:48 PM
    Author     : daoducdanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Feedback Form</title>
  <link rel="stylesheet" href="style.css">
</head>
<style>
  /* Định dạng tổng thể */
  body {
    font-family: Arial, sans-serif;
    background: linear-gradient(45deg, #f3f4f6, #dfe9f3);
    padding: 20px;
  }

  /* Căn giữa form */
  .feedback-form-container {
    width: 50%;
    margin: 30px auto;
    padding: 25px;
    background: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  }

  /* Tiêu đề */
  .feedback-form-title {
    text-align: center;
    font-size: 26px;
    font-weight: bold;
    color: #333;
  }

  .feedback-form-description {
    text-align: center;
    font-size: 14px;
    color: #666;
    margin-bottom: 20px;
  }

  /* Nhóm nhập dữ liệu */
  .input-group {
    margin-bottom: 20px;
  }

  .input-group label {
    font-size: 16px;
    font-weight: bold;
    color: #555;
    display: block;
    margin-bottom: 5px;
  }

  .input-group input,
  .input-group textarea {
    width: 100%;
    padding: 10px;
    border: 2px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s ease-in-out;
  }

  /* Khi nhập vào input */
  .input-group input:focus,
  .input-group textarea:focus {
    border-color: #6c63ff;
    outline: none;
  }

  /* Ô nhập cạnh nhau */
  .input-row {
    display: flex;
    gap: 20px;
  }

  .input-row .input-group {
    flex: 1;
  }

  /* Chú thích nhỏ */
  .input-group small {
    font-size: 12px;
    color: #888;
  }

  /* Radio và Checkbox */
  .radio-group,
  .checkbox-group {
    margin-bottom: 20px;
    padding: 15px;
    background: #f9f9f9;
    border-left: 5px solid #6c63ff;
    border-radius: 6px;
  }

  .radio-group label,
  .checkbox-group label {
    display: block;
    font-size: 14px;
    color: #444;
    margin-bottom: 8px;
  }

  /* Định dạng bảng đánh giá */
  .rating-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
  }

  .rating-table th,
  .rating-table td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: center;
    font-size: 14px;
  }

  .rating-table th {
    background: #6c63ff;
    color: #fff;
  }

  /* Nút submit */
  .submit-button {
    width: 100%;
    padding: 12px;
    background: linear-gradient(45deg, #6c63ff, #3f3d56);
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s ease-in-out;
  }

  .submit-button:hover {
    background: linear-gradient(45deg, #3f3d56, #6c63ff);
  }
</style>

<body>
  <div class="feedback-form-container">
    <h2 class="feedback-form-title">Product Feedback Form</h2>
    <p class="feedback-form-description">We appreciate your feedback!</p>

    <form>
      <!-- Name -->
      <div class="input-row">
        <div class="input-group">
          <label>Name</label>
          <input type="text" placeholder="First Name">
        </div>
        <div class="input-group">
          <label>&nbsp;</label>
          <input type="text" placeholder="Last Name">
        </div>
      </div>

      <!-- Phone Number -->
      <div class="input-group">
        <label>Phone Number</label>
        <input type="text" placeholder="(000) 000-0000">
        <small>Please enter a valid phone number.</small>
      </div>

      <!-- Email -->
      <div class="input-group">
        <label>Email</label>
        <input type="email" placeholder="example@example.com">
      </div>

      <!-- Satisfaction -->
      <div class="radio-group">
        <label>How satisfied were you when you used our product for the first time?</label>
        <label><input type="radio" name="satisfaction"> Very Satisfied</label>
        <label><input type="radio" name="satisfaction"> Satisfied</label>
        <label><input type="radio" name="satisfaction"> Neutral</label>
        <label><input type="radio" name="satisfaction"> Dissatisfied</label>
        <label><input type="radio" name="satisfaction"> Very dissatisfied</label>
      </div>

      <!-- Usage Duration -->
      <div class="radio-group">
        <label>How long have you used our products?</label>
        <label><input type="radio" name="usage"> More than 6 months</label>
        <label><input type="radio" name="usage"> 1 to 6 months</label>
        <label><input type="radio" name="usage"> Less than 1 month</label>
        <label><input type="radio" name="usage"> First time using it</label>
        <label><input type="radio" name="usage"> Never used</label>
      </div>

      <!-- Buying Experience -->
      <div class="radio-group">
        <label>How would you rate the buying experience?</label>
        <div class="rating-scale">
          <label>1 <input type="radio" name="rating"></label>
          <label>2 <input type="radio" name="rating"></label>
          <label>3 <input type="radio" name="rating"></label>
          <label>4 <input type="radio" name="rating"></label>
          <label>5 <input type="radio" name="rating"></label>
        </div>
      </div>

      <!-- Purchase Issues -->
      <div class="checkbox-group">
        <label>What part of your purchasing experience did you have trouble with?</label>
        <label><input type="checkbox"> Market search</label>
        <label><input type="checkbox"> Sale</label>
        <label><input type="checkbox"> After sale</label>
        <label><input type="checkbox"> Using product/service</label>
        <label><input type="checkbox"> None</label>
        <label><input type="checkbox"> Other</label>
      </div>

      <!-- Life Change -->
      <div class="radio-group">
        <label>Has your life changed after using the product?</label>
        <label><input type="radio" name="life"> Yes</label>
        <label><input type="radio" name="life"> No</label>
      </div>

      <!-- Buy Again -->
      <div class="radio-group">
        <label>Will you purchase or use our products again?</label>
        <label><input type="radio" name="buy_again"> Yes</label>
        <label><input type="radio" name="buy_again"> No</label>
      </div>

      <!-- Rating Table -->
      <label>Please rate our products in the following areas.</label>
      <table class="rating-table">
        <tr>
          <th></th>
          <th>Not Satisfied</th>
          <th>Somewhat Satisfied</th>
          <th>Satisfied</th>
          <th>Very Satisfied</th>
        </tr>
        <tr>
          <td>Quality</td>
          <td><input type="radio" name="quality"></td>
          <td><input type="radio" name="quality"></td>
          <td><input type="radio" name="quality"></td>
          <td><input type="radio" name="quality"></td>
        </tr>
        <tr>
          <td>Price</td>
          <td><input type="radio" name="price"></td>
          <td><input type="radio" name="price"></td>
          <td><input type="radio" name="price"></td>
          <td><input type="radio" name="price"></td>
        </tr>
      </table>

      <!-- Comment -->
      <div class="input-group">
        <label>What is your greatest concern about product?</label>
        <textarea rows="4" placeholder="Type here..."></textarea>
      </div>

      <!-- Submit Button -->
      <button class="submit-button">Submit</button>
    </form>
  </div>
</body>

</html>