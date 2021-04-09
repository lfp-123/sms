package com.supermarket.dao;

import java.util.List;

import com.supermarket.entity.RoleMenu;

public interface RoleMenuDao {
    List<RoleMenu> isRoleIdExistence(Integer id);

    Integer deleteRoleId(Integer id);

    Integer add(RoleMenu roleMenu);
}
