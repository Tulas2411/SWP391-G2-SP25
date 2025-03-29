/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author daoducdanh
 */
public class ProductRatingStats {
    private String productName;
    private double avgRating;

    public ProductRatingStats(String productName, double avgRating) {
        this.productName = productName;
        this.avgRating = avgRating;
    }

    public String getProductName() { return productName; }
    public double getAvgRating() { return avgRating; }
}
