package com.supermarket.service.impl;

import com.supermarket.dao.EmployeesDao;
import com.supermarket.entity.Dept;
import com.supermarket.entity.Employees;
import com.supermarket.entity.EmployesWork;
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
    public List<Employees> findByEmpName(String empName) {
        return empDao.findByEmpName(empName);
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

    @Override
    public List<Map<String, Object>> findw(String empName) {
        return empDao.findw(empName);
    }

    @Override
    public List<Map<String, Object>> findAllw(int page, int limit) {
        if (page == 1) {
            page = 0;
        }
        return empDao.findAllw(page, limit);
    }

    @Override
    public Integer updatew(EmployesWork role) {
        return empDao.updatew(role);
    }

    public Integer deletew(Integer id) {
        return null;
    }
}
