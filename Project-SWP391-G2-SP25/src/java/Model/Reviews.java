package Model;

import java.util.Date;


public class Reviews {

    private int reviewID;
    private int productID;
    private int customerID;
    private int rating;
    private String comment;
    private Date reviewDate;
    private String status;
    private String userName; // Thêm userName
    private String productName; // Thêm productName

    public Reviews() {
    }

    public Reviews(int reviewID, int productID, int customerID, int rating, String comment, Date reviewDate, String status, String userName, String productName) {
        this.reviewID = reviewID;
        this.productID = productID;
        this.customerID = customerID;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.status = status;
        this.userName = userName;
        this.productName = productName;
    }



    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    // Getter và Setter cho các thuộc tính mới
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    

}
