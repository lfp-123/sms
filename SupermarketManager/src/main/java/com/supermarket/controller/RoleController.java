package com.supermarket.controller;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.supermarket.entity.Role;
import com.supermarket.service.RoleService;
import com.supermarket.util.ResponseUtil;

/**
 * ��ɫ
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    @Resource
    private RoleService roleService;

    @ResponseBody
    @RequestMapping("/roleList")
    public Map<String, Object> userList(Role role,
                                        @RequestParam(value = "page", required = false) Integer page,
                                        @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        // ��֪��Ϊʲô ��������� ������roleInfo.jsp�Ǹ��Ƶ�ԭ���
        if (role.getRoleName() != null) {
            String roleName = new String(role.getRoleName().getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            result.put("roleName", roleName);
        }
        System.out.println(role.getRoleName());
        List<Role> roleList = roleService.findAll(result);
        Long count = roleService.count(result);
        return ResponseUtil.result(roleList, count);
    }

    @ResponseBody
    @RequestMapping("/add")
    public Map<String, Object> add(Role role) {
        Map<String, Object> result = new HashMap<>(2);
        Role roleName = roleService.findRepeat(role.getRoleName());
        if (roleName == null) {
            roleService.add(role);
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("errorInfo", "�û����Ѵ��ڣ�");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Map<String, Object> delete(@RequestParam(value = "id", required = false) Integer id) {
        Map<String, Object> result = new HashMap<>(2);
        roleService.delete(id);
        result.put("success", true);
        return result;
    }

    @ResponseBody
    @RequestMapping("/update")
    public Map<String, Object> update(Role role) {
        Map<String, Object> result = new HashMap<>(2);
        roleService.update(role);
        result.put("success", true);
        return result;
    }

    @ResponseBody
    @RequestMapping("/rolefind")
    public String rolefind(HttpServletResponse response) throws Exception {
        JsonArray jsonArray = new JsonArray();
        List<Role> typeList = roleService.findAll(null);
        for (Role role : typeList) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("id", role.getId());
            jsonObject.addProperty("name", role.getRoleName());
            jsonArray.add(jsonObject);
        }
        ResponseUtil.write(response, jsonArray);
        return null;
    }
}
