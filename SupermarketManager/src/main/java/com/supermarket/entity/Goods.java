package com.supermarket.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Goods {private Integer id;
	private Integer inventoryQuantity;
	private float lastPurchasingPrice;
	private Integer minNum;
	private String model;
	private String name;
	private String producer;
	private float purchasingPrice;
	private String remarks;
	private float sellingPrice;
	private Integer state;
	private String unit;
	private Integer typeId;
	private String typeName;
	private Integer number;
	private Integer saleNumber;
	private Integer returnNumber;
	private Integer numbers;
}
