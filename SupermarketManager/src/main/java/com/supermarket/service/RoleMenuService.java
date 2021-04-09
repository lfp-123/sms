package com.supermarket.service;

import java.util.List;

import com.supermarket.entity.RoleMenu;

public interface RoleMenuService {
    List<RoleMenu> isRoleIdExistence(Integer id);

    Integer deleteRoleId(Integer id);

    Integer add(RoleMenu roleMenu);
}
