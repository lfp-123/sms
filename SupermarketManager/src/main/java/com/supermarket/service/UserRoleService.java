package com.supermarket.service;

import com.supermarket.entity.UserRole;

public interface UserRoleService {
    Integer add(UserRole userRole);

    UserRole findAll(String userName);

    Integer delete(Integer id);
}
