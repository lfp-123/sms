package com.supermarket.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.supermarket.entity.Employees;
import com.supermarket.entity.EmployesWork;
import com.supermarket.service.EmpService;
import com.supermarket.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@Controller
@RequestMapping("/emp")
public class EmpController {
    @Resource
    private EmpService empService;

    @ResponseBody
    @RequestMapping("/empList")
    public Map<String, Object> userList(Employees emp,
                                        @RequestParam(value = "page", required = false) Integer page,
                                        @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        // 不知道为什么 这个有乱码 估计是roleInfo.jsp是复制的原因吧
        if (emp.getEmpName() != null) {
            String empName = new String(emp.getEmpName().getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            result.put("empName", empName);
        }
        System.out.println(emp.getEmpName());
        List<Employees> roleList = empService.findAll(result);
        Long count = empService.count(result);
        return ResponseUtil.result(roleList, count);
    }

    @ResponseBody
    @RequestMapping("/add")
    public Map<String, Object> add(Employees emp) {
        Map<String, Object> result = new HashMap<>(2);
        Employees empName = empService.findRepeat(emp.getEmpName());
        if (empName == null) {
            empService.add(emp);
            result.put("success", true);
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
        empService.delete(id);
        result.put("success", true);
        return result;
    }

    @ResponseBody
    @RequestMapping("/deletew")
    public Map<String, Object> deletew(@RequestParam(value = "id", required = false) Integer id) {
        Map<String, Object> result = new HashMap<>(2);
        empService.delete(id);
        System.out.println("Id+"+id);
        result.put("success", true);
        return result;
    }

    @ResponseBody
    @RequestMapping("/update")
    public Map<String, Object> update(Employees emp) {
        Map<String, Object> result = new HashMap<>(2);
        empService.update(emp);
        result.put("success", true);
        return result;
    }
    @ResponseBody
    @RequestMapping("/updatew")
    public Map<String, Object> updatew(EmployesWork emp) {
        Map<String, Object> result = new HashMap<>(2);
        empService.updatew(emp);
        result.put("success", true);
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
    public Map<String, Object> goodsList(@RequestParam(value = "page", required = false) Integer page,
                                         @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        System.out.println("page:"+page+"limit: "+limit);
        result.put("state", 2);
        List<EmployesWork> all = empService.findAllw(page, limit);
        Long count = empService.counts(result);
        return ResponseUtil.result(all, count);
    }
}
