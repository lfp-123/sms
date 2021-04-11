package com.supermarket.service;

import com.supermarket.entity.Dept;
import com.supermarket.entity.Employees;
import com.supermarket.entity.EmployesWork;

import java.util.List;
import java.util.Map;

public interface EmpService {
    List<Employees> findByEmpName(String empName);

    List<Employees> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Employees findRepeat(String roleName);

    Integer add(Employees role);

    Integer delete(Integer id);

    Integer update(Employees role);

    Integer updatew(EmployesWork role);

    List<EmployesWork> findAllw(int page, int limit) ;

    Long counts(Map<String, Object> map);

    List<Dept> findAllDept();

    String findDeptName(Integer deptId);

    Integer deleteew(Integer id);
}
