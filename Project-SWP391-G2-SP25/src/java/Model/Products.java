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
 * @author admin
 */
public class Products {
    int ProductID;
    String CategoryID;
    String ProductName;
    String Description;
    String Provider;
    float price;
    String WarrantyPeriod;
    int Amount;
    String ImageLink;
    boolean IsPromoted;
    Date CreatAt;

    public Products() {
    }

    public Products(int ProductID, String CategoryID, String ProductName, String Description, String Provider, float price, String WarrantyPeriod, int Amount, String ImageLink, boolean IsPromoted, Date CreatAt) {
        this.ProductID = ProductID;
        this.CategoryID = CategoryID;
        this.ProductName = ProductName;
        this.Description = Description;
        this.Provider = Provider;
        this.price = price;
        this.WarrantyPeriod = WarrantyPeriod;
        this.Amount = Amount;
        this.ImageLink = ImageLink;
        this.IsPromoted = IsPromoted;
        this.CreatAt = CreatAt;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public String getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(String CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getProvider() {
        return Provider;
    }

    public void setProvider(String Provider) {
        this.Provider = Provider;
    }

    public String getPrice() {
        NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
        String formattedPrice = currencyFormat.format(price) + "đ";
        return formattedPrice;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getWarrantyPeriod() {
        return WarrantyPeriod;
    }

    public void setWarrantyPeriod(String WarrantyPeriod) {
        this.WarrantyPeriod = WarrantyPeriod;
    }

    public int getAmount() {
        return Amount;
    }

    public void setAmount(int Amount) {
        this.Amount = Amount;
    }

    public String getImageLink() {
        return ImageLink;
    }

    public void setImageLink(String ImageLink) {
        this.ImageLink = ImageLink;
    }

    public boolean isIsPromoted() {
        return IsPromoted;
    }

    public void setIsPromoted(boolean IsPromoted) {
        this.IsPromoted = IsPromoted;
    }

    public Date getCreatAt() {
        return CreatAt;
    }

    public void setCreatAt(Date CreatAt) {
        this.CreatAt = CreatAt;
    }
    public String getOldPrice() {
        NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
        String formattedPrice = currencyFormat.format(price + 1000) + "đ";
        return formattedPrice;
    }
}
