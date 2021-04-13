package com.supermarket.controller;

import com.alibaba.fastjson.JSON;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.supermarket.entity.Dept;
import com.supermarket.entity.Employees;
import com.supermarket.entity.EmployesWork;
import com.supermarket.service.EmpService;
import com.supermarket.util.ResponseUtil;
import com.supermarket.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
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
    public Map<String, Object> userList(
            String empName,
            @RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        try {
            Long count = empService.count(result);
            if (StringUtil.isNotEmpty(empName)) {
                return ResponseUtil.result(
                        ResponseUtil.getEmpResultList(empService.findByEmpName(empName.trim()), empService),
                        count);
            } else {
                return ResponseUtil.result(
                        ResponseUtil.getEmpResultList(empService.findAll(result), empService), count);
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("errorInfo", "系统内部异常，查询失败，请联系管理员");
            return result;
        }
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
        try {
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
        } catch (Exception e) {
            result.put("success", false);
            result.put("errorInfo", "系统内部异常，增加失败，请联系管理员");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Map<String, Object> delete(@RequestParam(value = "id", required = false) Integer id) {
        Map<String, Object> result = new HashMap<>(2);
        try {
            empService.delete(id);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("errorInfo", "系统内部异常，删除失败，请联系管理员");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/update")
    public Map<String, Object> update(Employees emp) {
        Map<String, Object> result = new HashMap<>(2);
        try {
            empService.update(emp);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("errorInfo", "系统内部异常，修改失败，请联系管理员");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/updatew")
    public Map<String, Object> updatew(EmployesWork emp) {
        Map<String, Object> result = new HashMap<>(2);
        try {
            if (empService.updatew(emp) > 0) {
                result.put("success", true);
            } else {
                result.put("success", false);
                result.put("errorInfo", "系统内部异常，修改失败，请联系管理员");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("errorInfo", "系统内部异常，修改失败，请联系管理员");
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

    @ResponseBody
    @RequestMapping("/empWorkList")
    public Map<String, Object> goodsList(
            String empName,
            @RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        try {
            Long count = empService.count(result);
            if (StringUtil.isNotEmpty(empName)) {
                return ResponseUtil.result(empService.findw(empName), count);
            } else {
                return ResponseUtil.result(empService.findAllw(page, limit), count);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("errorInfo", "系统内部异常，查询失败，请联系管理员");
            return result;
        }
    }
}
