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
     * 加载权限菜单
     */
    @ResponseBody
    @RequestMapping("/loadMenuInfo")
    public String loadMenuInfo(Integer dId, Integer roleId) {
        List<Menu> menuList = menuService.findByRoleIdMenu(roleId);
        List<Integer> menuIdList = new LinkedList<>();
        //menuIdList 是menuList 根据角色ID查询的所有菜单
        for (Menu menu : menuList) {
            menuIdList.add(menu.getId());
        }
        // 1 和 当前角色菜单ID
        return getAllMenuByParentId(dId, menuIdList).toString();
    }

    /**
     * 获取所有菜单信息
     */
    public JsonArray getAllMenuByParentId(Integer dId, List<Integer> menuIdList) {
        //1 和当前角色菜单ID
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
     * 根据父节点和用户角色Id查询菜单
     */
    public JsonArray getMenuByParentId(Integer dId, List<Integer> menuIdList) {
        //第一次传入1
        List<Menu> menuList = menuService.findByParentIdAndRoleId(dId);
        JsonArray jsonArray = new JsonArray();
        for (Menu menu : menuList) {
            JsonObject jsonObject = new JsonObject();
            // 节点Id
            jsonObject.addProperty("id", menu.getId());
            // 节点名称
            jsonObject.addProperty("name", menu.getName());
            // 节点名称
            jsonObject.addProperty("p_id", menu.getPId());
            if (menu.getMenuId() == 0) {
                // 根节点
                jsonObject.addProperty("menuId", "closed");
            } else {
                // 叶子节点
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
