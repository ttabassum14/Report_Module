package com.primebank.model.reports;

import java.util.Date;

public class Report {

    // Private fields to encapsulate the data
    private int arn_number;
    private int cardNo;
    private String customer_name;
    private int client_code;
    private int account_number;
    private int trxn_amount;
    private Date trxn_date;
    private String trxn_code;
    private String trxn_description;
    private String phone_number;
    private String issuer_bank;
    private String acquirer_bank;
    private String card_type;
    private String card_name;
    private String home_address;
    private String home_city;
    private String home_country;
    private String email;
    private int tin;
    private int nid;

    // Default constructor
    public Report() {
    }

    // Parameterized constructor
    public Report(int arn_number, int cardNo, String customer_name, int client_code, int account_number,
                  int trxn_amount, Date trxn_date, String trxn_code, String trxn_description,
                  String phone_number, String issuer_bank, String acquirer_bank, String card_type,
                  String card_name, String home_address, String home_city, String home_country,
                  String email, int tin, int nid) {
        this.arn_number = arn_number;
        this.cardNo = cardNo;
        this.customer_name = customer_name;
        this.client_code = client_code;
        this.account_number = account_number;
        this.trxn_amount = trxn_amount;
        this.trxn_date = trxn_date;
        this.trxn_code = trxn_code;
        this.trxn_description = trxn_description;
        this.phone_number = phone_number;
        this.issuer_bank = issuer_bank;
        this.acquirer_bank = acquirer_bank;
        this.card_type = card_type;
        this.card_name = card_name;
        this.home_address = home_address;
        this.home_city = home_city;
        this.home_country = home_country;
        this.email = email;
        this.tin = tin;
        this.nid = nid;
    }

    // Getter and Setter methods

    public int getArn_number() {
        return arn_number;
    }

    public void setArn_number(int arn_number) {
        this.arn_number = arn_number;
    }

    public int getCardNo() {
        return cardNo;
    }

    public void setCardNo(int cardNo) {
        this.cardNo = cardNo;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public int getClient_code() {
        return client_code;
    }

    public void setClient_code(int client_code) {
        this.client_code = client_code;
    }

    public int getAccount_number() {
        return account_number;
    }

    public void setAccount_number(int account_number) {
        this.account_number = account_number;
    }

    public int getTrxn_amount() {
        return trxn_amount;
    }

    public void setTrxn_amount(int trxn_amount) {
        this.trxn_amount = trxn_amount;
    }

    public Date getTrxn_date() {
        return trxn_date;
    }

    public void setTrxn_date(Date trxn_date) {
        this.trxn_date = trxn_date;
    }

    public String getTrxn_code() {
        return trxn_code;
    }

    public void setTrxn_code(String trxn_code) {
        this.trxn_code = trxn_code;
    }

    public String getTrxn_description() {
        return trxn_description;
    }

    public void setTrxn_description(String trxn_description) {
        this.trxn_description = trxn_description;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getIssuer_bank() {
        return issuer_bank;
    }

    public void setIssuer_bank(String issuer_bank) {
        this.issuer_bank = issuer_bank;
    }

    public String getAcquirer_bank() {
        return acquirer_bank;
    }

    public void setAcquirer_bank(String acquirer_bank) {
        this.acquirer_bank = acquirer_bank;
    }

    public String getCard_type() {
        return card_type;
    }

    public void setCard_type(String card_type) {
        this.card_type = card_type;
    }

    public String getCard_name() {
        return card_name;
    }

    public void setCard_name(String card_name) {
        this.card_name = card_name;
    }

    public String getHome_address() {
        return home_address;
    }

    public void setHome_address(String home_address) {
        this.home_address = home_address;
    }

    public String getHome_city() {
        return home_city;
    }

    public void setHome_city(String home_city) {
        this.home_city = home_city;
    }

    public String getHome_country() {
        return home_country;
    }

    public void setHome_country(String home_country) {
        this.home_country = home_country;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getTin() {
        return tin;
    }

    public void setTin(int tin) {
        this.tin = tin;
    }

    public int getNid() {
        return nid;
    }

    public void setNid(int nid) {
        this.nid = nid;
    }
}
