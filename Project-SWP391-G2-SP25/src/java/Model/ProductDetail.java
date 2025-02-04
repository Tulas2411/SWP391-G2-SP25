/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class ProductDetail {
    int ProductDetailID;
    int ProductID;
    String ProductDetailName;
    String Value;

    public ProductDetail() {
    }

    public ProductDetail(int ProductDetailID, int ProductID, String ProductDetailName, String Value) {
        this.ProductDetailID = ProductDetailID;
        this.ProductID = ProductID;
        this.ProductDetailName = ProductDetailName;
        this.Value = Value;
    }

    public int getProductDetailID() {
        return ProductDetailID;
    }

    public void setProductDetailID(int ProductDetailID) {
        this.ProductDetailID = ProductDetailID;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public String getProductDetailName() {
        return ProductDetailName;
    }

    public void setProductDetailName(String ProductDetailName) {
        this.ProductDetailName = ProductDetailName;
    }

    public String getValue() {
        return Value;
    }

    public void setValue(String Value) {
        this.Value = Value;
    }
    
}
