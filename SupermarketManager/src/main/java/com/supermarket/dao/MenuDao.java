package com.supermarket.dao;

import java.util.List;

import com.supermarket.entity.Menu;

public interface MenuDao {
    List<Menu> menuList(Integer roleId);

    List<Menu> findByRoleIdMenu(Integer roleId);

    List<Menu> findByParentIdAndRoleId(Integer parentId);
}
