package com.supermarket.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.RoleMenuDao;
import com.supermarket.entity.RoleMenu;
import com.supermarket.service.RoleMenuService;
@Service("roleMenuService")
public class RoleMenuServiceImpl implements RoleMenuService {
	@Resource
	private RoleMenuDao roleMenuDao;

	@Override
	public List<RoleMenu> isRoleIdExistence(Integer id) {
		return roleMenuDao.isRoleIdExistence(id);
	}

	@Override
	public Integer deleteRoleId(Integer id) {
		return roleMenuDao.deleteRoleId(id);
	}

	@Override
	public Integer add(RoleMenu roleMenu) {
		return roleMenuDao.add(roleMenu);
	}
}
