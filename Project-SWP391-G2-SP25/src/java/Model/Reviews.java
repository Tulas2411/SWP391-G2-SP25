/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author admin
 */
public class Reviews {
    int ReviewID;
    int ProductID;
    int CustomerID;
    int Rating;
    String Comment;
    Date ReviewDate;

    public Reviews() {
    }

    public Reviews(int ReviewID, int ProductID, int CustomerID, int Rating, String Comment, Date ReviewDate) {
        this.ReviewID = ReviewID;
        this.ProductID = ProductID;
        this.CustomerID = CustomerID;
        this.Rating = Rating;
        this.Comment = Comment;
        this.ReviewDate = ReviewDate;
    }

    public int getReviewID() {
        return ReviewID;
    }

    public void setReviewID(int ReviewID) {
        this.ReviewID = ReviewID;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public int getRating() {
        return Rating;
    }

    public void setRating(int Rating) {
        this.Rating = Rating;
    }

    public String getComment() {
        return Comment;
    }

    public void setComment(String Comment) {
        this.Comment = Comment;
    }

    public Date getReviewDate() {
        return ReviewDate;
    }

    public void setReviewDate(Date ReviewDate) {
        this.ReviewDate = ReviewDate;
    }
    
}
