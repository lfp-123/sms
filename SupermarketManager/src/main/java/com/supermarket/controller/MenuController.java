package com.supermarket.controller;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.supermarket.entity.Menu;
import com.supermarket.entity.RoleMenu;
import com.supermarket.service.MenuService;
import com.supermarket.service.RoleMenuService;

@Controller
@RequestMapping("/menu")
public class MenuController {
    @Resource
    public MenuService menuService;

    @Resource
    public RoleMenuService roleMenuService;

    /**
     * ����Ȩ�޲˵�
     */
    @ResponseBody
    @RequestMapping("/loadMenuInfo")
    public String loadMenuInfo(Integer dId, Integer roleId) {
        List<Menu> menuList = menuService.findByRoleIdMenu(roleId);
        List<Integer> menuIdList = new LinkedList<>();
        //menuIdList ��menuList ���ݽ�ɫID��ѯ�����в˵�
        for (Menu menu : menuList) {
            menuIdList.add(menu.getId());
        }
        // 1 �� ��ǰ��ɫ�˵�ID
        return getAllMenuByParentId(dId, menuIdList).toString();
    }

    /**
     * ��ȡ���в˵���Ϣ
     */
    public JsonArray getAllMenuByParentId(Integer dId, List<Integer> menuIdList) {
        //1 �͵�ǰ��ɫ�˵�ID
        JsonArray jsonArray = this.getMenuByParentId(dId, menuIdList);
        for (int i = 0; i < jsonArray.size(); i++) {
            JsonObject jsonObject = (JsonObject) jsonArray.get(i);
            if (!"open".equals(jsonObject.get("menuId").getAsString())) {
                jsonObject.add("children", getAllMenuByParentId(jsonObject.get("p_id").getAsInt(), menuIdList));
            }
        }
        return jsonArray;
    }

    /**
     * ���ݸ��ڵ���û���ɫId��ѯ�˵�
     */
    public JsonArray getMenuByParentId(Integer dId, List<Integer> menuIdList) {
        //��һ�δ���1
        List<Menu> menuList = menuService.findByParentIdAndRoleId(dId);
        JsonArray jsonArray = new JsonArray();
        for (Menu menu : menuList) {
            JsonObject jsonObject = new JsonObject();
            // �ڵ�Id
            jsonObject.addProperty("id", menu.getId());
            // �ڵ�����
            jsonObject.addProperty("name", menu.getName());
            // �ڵ�����
            jsonObject.addProperty("p_id", menu.getPId());
            if (menu.getMenuId() == 0) {
                // ���ڵ�
                jsonObject.addProperty("menuId", "closed");
            } else {
                // Ҷ�ӽڵ�
                jsonObject.addProperty("menuId", "open");
            }
            if (menuIdList.contains(menu.getId())) {
                jsonObject.addProperty("checked", true);
            }
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    @ResponseBody
    @RequestMapping("/save")
    public Map<String, Object> save(Integer roleId, String[] nodes) throws Exception {
        Map<String, Object> result = new HashMap<>(2);
        if (nodes != null) {
            if (roleMenuService.isRoleIdExistence(roleId).size() > 0) {
                roleMenuService.deleteRoleId(roleId);
            }
            for (String node : nodes) {
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setMenuId(Integer.parseInt(node));
                roleMenu.setRoleId(roleId);
                roleMenuService.add(roleMenu);
            }
        } else {
            result.put("success", true);
        }
        result.put("success", true);
        return result;
    }
}
