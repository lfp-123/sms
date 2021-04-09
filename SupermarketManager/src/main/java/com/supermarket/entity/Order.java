package com.supermarket.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {
	private Integer id;
	private String code;
	private String remark;
	private Integer supplierId;
	private Integer state;
	private Date createdate;
	private Date paydate;
	private float paymoney;
	private String name;
	private String contact;
	private String number;
	private String releaseStr;
	private String releaseStrPay;
}
