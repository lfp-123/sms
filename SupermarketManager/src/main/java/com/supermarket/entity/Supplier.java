package com.supermarket.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Supplier {
	private Integer id;
	private String address;
	private String contact;
	private String name;
	private String number;
	private String remarks;
}
