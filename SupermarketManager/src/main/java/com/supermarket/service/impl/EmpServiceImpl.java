package com.supermarket.service.impl;

import com.supermarket.dao.EmployeesDao;
import com.supermarket.entity.Dept;
import com.supermarket.entity.Employees;
import com.supermarket.service.EmpService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("empService")
public class EmpServiceImpl implements EmpService {
    @Resource
    private EmployeesDao empDao;

    @Override
    public Employees findByRoleName(Integer id) {
        return empDao.findByEmpId(id);
    }

    @Override
    public List<Employees> findAll(Map<String, Object> map) {
        return empDao.findAll(map);
    }

    @Override
    public Long count(Map<String, Object> map) {
        return empDao.count(map);
    }

    @Override
    public Employees findRepeat(String empName) {
        return empDao.findRepeat(empName);
    }

    @Override
    public Integer add(Employees emp) {
        return empDao.add(emp);
    }

    @Override
    public Integer delete(Integer id) {
        return empDao.delete(id);
    }

    @Override
    public Integer update(Employees emp) {
        return empDao.update(emp);
    }

    @Override
    public List<Dept> findAllDept() {
        return empDao.findAllDept();
    }

    @Override
    public String findDeptName(Integer deptId) {
        return empDao.findDeptName(deptId);
    }
}
