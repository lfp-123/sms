package com.supermarket.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @author ${林锋鹏}
 * @Title: EmployesWork
 * @ProjectName SupermarketManager
 * @Description: TODO
 * @date 2021/4/10 20:55
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class EmployesWork {
    private int employId;
    private int outWorkDays;
    private int workDays;
    private int leaveDays;
    private int dept;
    private String name;


}
