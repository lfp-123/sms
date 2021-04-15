package com.supermarket.dao;

import com.supermarket.entity.Dept;
import com.supermarket.entity.Employees;
import com.supermarket.entity.EmployesWork;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface EmployeesDao {
    List<Employees> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Employees findRepeat(String empName);

    Integer add(Employees emp);

    Integer delete(Integer id);

    Integer update(Employees emp);

    Employees findByEmpId(Integer id);

    String findDeptName(Integer deptId);

    List<Dept> findAllDept();

    Integer updatew(EmployesWork emp);

    List<Map<String, Object>> findAllw(@Param("page") int page, @Param("limit") int limit);

    List<Map<String, Object>> findw(@Param("empName") String empName);

    Long counts(Map<String, Object> map);

    List<Employees> findByEmpName(String empName);

    Integer addw(Integer empId);
}