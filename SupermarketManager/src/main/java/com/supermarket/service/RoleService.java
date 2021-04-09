package com.supermarket.service;

import java.util.List;
import java.util.Map;

import com.supermarket.entity.Role;

public interface RoleService {
    Role findByRoleName(Integer id);

    List<Role> findAll(Map<String, Object> map);

    Long count(Map<String, Object> map);

    Role findRepeat(String roleName);

    Integer add(Role role);

    Integer delete(Integer id);

    Integer update(Role role);
}
