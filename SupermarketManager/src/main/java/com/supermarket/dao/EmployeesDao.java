package com.supermarket.dao;

import com.supermarket.entity.Employees;

import java.util.List;
import java.util.Map;

public interface EmployeesDao {
    Employees findByRoleName(Integer id);

    List<Employees> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Employees findRepeat(String empName);

    Integer add(Employees emp);

    Integer delete(Integer id);

    Integer update(Employees emp);
}