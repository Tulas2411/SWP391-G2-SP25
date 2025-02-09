/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author Tùng Dương
 */
public class Products {
    private int productID;
    private String categoryID;
    private String productName;
    private String description;
    private String provider;
    private float price;
    private float oldprice;
    private String warrantyPeriod;
    private int amount;
    private String imageLink;
    private Boolean isPromoted;
    private Date createAt;

    public Products() {
    }

    public Products(int productID, String categoryID, String productName, String description, String provider, float price, float oldprice, String warrantyPeriod, int amount, String imageLink, Boolean isPromoted, Date createAt) {
        this.productID = productID;
        this.categoryID = categoryID;
        this.productName = productName;
        this.description = description;
        this.provider = provider;
        this.price = price;
        this.oldprice = oldprice;
        this.warrantyPeriod = warrantyPeriod;
        this.amount = amount;
        this.imageLink = imageLink;
        this.isPromoted = isPromoted;
        this.createAt = createAt;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    public String getPrice() {
        NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
        String formattedPrice = currencyFormat.format(price) + "đ";
        return formattedPrice;
    }
    
    public float getPriceFloat() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getOldPrice() {
        NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
        String formattedPrice = currencyFormat.format(oldprice) + "đ";
        return formattedPrice;
    }
    
    public float getOldPriceFloat() {
        return oldprice;
    }

    public void setOldprice(float oldprice) {
        this.oldprice = oldprice;
    }

    public String getWarrantyPeriod() {
        return warrantyPeriod;
    }

    public void setWarrantyPeriod(String warrantyPeriod) {
        this.warrantyPeriod = warrantyPeriod;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    public Boolean getIsPromoted() {
        return isPromoted;
    }

    public void setIsPromoted(Boolean isPromoted) {
        this.isPromoted = isPromoted;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }
    
    
}
