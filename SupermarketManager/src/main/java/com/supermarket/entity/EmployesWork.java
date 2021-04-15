package com.supermarket.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class EmployesWork {
    private Integer id;
    private int outWorkDays;
    private int workDays;
    private int leaveDays;
    private Integer empId;
}
