/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author daoducdanh
 */
public class CustomerSpendingStats {
    private String customerName;
    private double totalSpent;

    public CustomerSpendingStats(String customerName, double totalSpent) {
        this.customerName = customerName;
        this.totalSpent = totalSpent;
    }

    public String getCustomerName() { return customerName; }
    public double getTotalSpent() { return totalSpent; }
}
