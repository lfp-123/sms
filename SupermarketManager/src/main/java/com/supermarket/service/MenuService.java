package com.supermarket.service;

import java.util.List;

import com.supermarket.entity.Menu;

public interface MenuService {
    List<Menu> menuList(Integer roleId);

    /**
     * 根据角色ID查询当前所拥有的菜单
     */
    List<Menu> findByRoleIdMenu(Integer roleId);

    /**
     * 根据p_id查询所有菜单
     */
    List<Menu> findByParentIdAndRoleId(Integer parentId);

    /**
     * 获取所有菜单
     *
     * @return 菜单列表
     */
    List<Menu> allMenuList();
}
