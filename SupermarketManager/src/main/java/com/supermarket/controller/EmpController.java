package com.supermarket.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.supermarket.entity.Dept;
import com.supermarket.entity.Employees;
import com.supermarket.service.EmpService;
import com.supermarket.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/emp")
public class EmpController {
    @Resource
    private EmpService empService;

    @ResponseBody
    @RequestMapping("/empList")
    public Map<String, Object> userList(@RequestParam(value = "page", required = false) Integer page,
                                        @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        List<Employees> empList = empService.findAll(result);
        Map<String, Object> empMap;
        List<Map<String, Object>> resultList = new ArrayList<>();
        for (Employees employees : empList) {
            empMap = new HashMap<>(16);
            empMap.put("id", employees.getEmpId());
            empMap.put("empName", employees.getEmpName());
            empMap.put("empNativePlace", employees.getEmpNativePlace());
            empMap.put("empAddr", employees.getEmpAddr());
            empMap.put("empPhone", employees.getEmpPhone());
            empMap.put("empIdentity", employees.getEmpIdentity());
            if (employees.getEmpSex() == 0) {
                empMap.put("empSex", "女");
            } else if (employees.getEmpSex() == 1) {
                empMap.put("empSex", "男");
            } else {
                empMap.put("empSex", null);
            }
            empMap.put("empDept", empService.findDeptName(employees.getDeptId()));
            empMap.put("empDescribe", employees.getEmpDescribe());
            resultList.add(empMap);
        }
        Long count = empService.count(result);
        return ResponseUtil.result(resultList, count);
    }

    @ResponseBody
    @RequestMapping("/getDept")
    public String deptList() {
        List<Dept> deptList = empService.findAllDept();
        return JSON.toJSONString(deptList);
    }

    @ResponseBody
    @RequestMapping("/add")
    public Map<String, Object> add(Employees emp) {
        Map<String, Object> result = new HashMap<>(2);
        Employees empName = empService.findRepeat(emp.getEmpName());
        if (empName == null) {
            if (empService.add(emp) > 0) {
                result.put("success", true);
            } else {
                result.put("success", false);
            }
        } else {
            result.put("success", false);
            result.put("errorInfo", "用户名已存在！");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Map<String, Object> delete(@RequestParam(value = "id", required = false) Integer id) {
        Map<String, Object> result = new HashMap<>(2);
        if (empService.delete(id) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/update")
    public Map<String, Object> update(Employees emp) {
        Map<String, Object> result = new HashMap<>(2);
        if (empService.update(emp) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("errorInfo", "修改失败");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/empfind")
    public String empfind(HttpServletResponse response) throws Exception {
        JsonArray jsonArray = new JsonArray();
        List<Employees> typeList = empService.findAll(null);
        for (Employees employees : typeList) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("id", employees.getEmpId());
            jsonObject.addProperty("name", employees.getEmpName());
            jsonArray.add(jsonObject);
        }
        ResponseUtil.write(response, jsonArray);
        return null;
    }
}
