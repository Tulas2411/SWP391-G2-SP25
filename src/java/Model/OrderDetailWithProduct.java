/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author daoducdanh
 */
public class OrderDetailWithProduct {
    private OrderDetails orderDetails;
    private Products products;
    
    public OrderDetailWithProduct(){
        
    }

    public OrderDetailWithProduct(OrderDetails orderDetails, Products products) {
        this.orderDetails = orderDetails;
        this.products = products;
    }

    public OrderDetails getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(OrderDetails orderDetails) {
        this.orderDetails = orderDetails;
    }

    public Products getProducts() {
        return products;
    }

    public void setProducts(Products products) {
        this.products = products;
    }
    
    
    
}
