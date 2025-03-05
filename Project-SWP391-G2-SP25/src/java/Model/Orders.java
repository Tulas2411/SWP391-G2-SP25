/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Tùng Dương
 */
public class Orders {
    private int orderID;
    private int customerID;
    private String orderDate;
    private String deliveryAddress;
    private String status;
    private double totalAmount;
    private String billOfLading;

    public Orders() {
    }

    public Orders(int orderID, int customerID, String orderDate, String deliveryAddress, String status, double totalAmount, String billOfLading) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.status = status;
        this.totalAmount = totalAmount;
        this.billOfLading = billOfLading;
    }

    public Orders(String orderDate, String deliveryAddress, String status, double totalAmount, String billOfLading) {
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.status = status;
        this.totalAmount = totalAmount;
        this.billOfLading = billOfLading;
    }

    public Orders(int customerID, String orderDate, String deliveryAddress, String status, double totalAmount, String billOfLading) {
        this.customerID = customerID;
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.status = status;
        this.totalAmount = totalAmount;
        this.billOfLading = billOfLading;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getBillOfLading() {
        return billOfLading;
    }

    public void setBillOfLading(String billOfLading) {
        this.billOfLading = billOfLading;
    }
    
}
