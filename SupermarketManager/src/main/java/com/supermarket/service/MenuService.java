package com.supermarket.service;

import java.util.List;

import com.supermarket.entity.Menu;

public interface MenuService {
    List<Menu> menuList(Integer roleId);

    /**
     * ���ݽ�ɫID��ѯ��ǰ��ӵ�еĲ˵�
     */
    List<Menu> findByRoleIdMenu(Integer roleId);

    /**
     * ����p_id��ѯ���в˵�
     */
    List<Menu> findByParentIdAndRoleId(Integer parentId);

    /**
     * ��ȡ���в˵�
     *
     * @return �˵��б�
     */
    List<Menu> allMenuList();
}
