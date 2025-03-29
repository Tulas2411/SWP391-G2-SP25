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
    private String customerFirstName;
    private String customerLastName;
    private String customerEmail;
    private int ShipperID;
    private int SaleID;
    private Integer assignedSaleId;

    public Orders() {
    }

    public String getCustomerFirstName() {
        return customerFirstName;
    }

    public int getSaleID() {
        return SaleID;
    }

    public void setSaleID(int SaleID) {
        this.SaleID = SaleID;
    }
    

    public void setCustomerFirstName(String customerFirstName) {
        this.customerFirstName = customerFirstName;
    }

    public String getCustomerLastName() {
        return customerLastName;
    }

    public void setCustomerLastName(String customerLastName) {
        this.customerLastName = customerLastName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    
    public Orders(int orderID, int customerID, String orderDate, String deliveryAddress, String status, double totalAmount, String billOfLading, String customerFirstName, String customerLastName, String customerEmail) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.status = status;
        this.totalAmount = totalAmount;
        this.billOfLading = billOfLading;
        this.customerFirstName = customerFirstName;
        this.customerLastName = customerLastName;
        this.customerEmail = customerEmail;
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

    public int getShipperID() {
        return ShipperID;
    }

    public void setShipperID(int ShipperID) {
        this.ShipperID = ShipperID;
    }

    public Integer getAssignedSaleId() {
        return assignedSaleId;
    }

    public void setAssignedSaleId(Integer assignedSaleId) {
        this.assignedSaleId = assignedSaleId;
    }
    
    

    public Orders(String orderDate, String deliveryAddress, String status, double totalAmount, String billOfLading, int ShipperID) {
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.status = status;
        this.totalAmount = totalAmount;
        this.billOfLading = billOfLading;
        this.ShipperID = ShipperID;
    }

    @Override
    public String toString() {
        return "Orders{" + "orderID=" + orderID + ", customerID=" + customerID + ", orderDate=" + orderDate + ", deliveryAddress=" + deliveryAddress + ", status=" + status + ", totalAmount=" + totalAmount + ", billOfLading=" + billOfLading + ", customerFirstName=" + customerFirstName + ", customerLastName=" + customerLastName + ", customerEmail=" + customerEmail + ", ShipperID=" + ShipperID + ", SaleID=" + SaleID + ", assignedSaleId=" + assignedSaleId + '}';
    }
    
    public String getStatusOrder(){
        if("Delivered".equals(status)){
            return "Đã giao";
        }
        else if("Submit".equals(status)){
            return "Đặt hàng";
        }
        return "Không xác định"; 
    }
    
}
