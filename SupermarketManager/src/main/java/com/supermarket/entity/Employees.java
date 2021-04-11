package com.supermarket.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Employees implements Serializable {
    /**
     * 员工编号
     */
    private Integer empId;

    /**
     * 员工姓名
     */
    private String empName;

    /**
     * 员工籍贯
     */
    private String empNativePlace;

    /**
     * 员工地址
     */
    private String empAddr;

    /**
     * 员工电话
     */
    private String empPhone;

    /**
     * 员工身份证号
     */
    private String empIdentity;

    /**
     * 员工性别：0女1男
     */
    private Integer empSex;

    /**
     * 部门编号
     */
    private Integer deptId;

    /**
     * 员工描述
     */
    private String empDescribe;
}