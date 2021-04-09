package com.supermarket.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GoodsType {
    private Integer id;
    private String icon;
    private String name;
    private Integer pId;
    private Integer state;
}
