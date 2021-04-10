package com.supermarket.service;

import com.supermarket.entity.Dept;
import com.supermarket.entity.Employees;

import java.util.List;
import java.util.Map;

public interface EmpService {
    Employees findByRoleName(Integer id);

    List<Employees> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Employees findRepeat(String roleName);

    Integer add(Employees role);

    Integer delete(Integer id);

    Integer update(Employees role);

    List<Dept> findAllDept();

    String findDeptName(Integer deptId);
}
