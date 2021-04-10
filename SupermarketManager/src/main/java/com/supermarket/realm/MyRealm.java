package com.supermarket.realm;

import javax.annotation.Resource;

import org.apache.commons.lang.ObjectUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.supermarket.entity.User;
import com.supermarket.service.UserService;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class MyRealm extends AuthorizingRealm {

    @Resource
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //�˺���ͨ����֤
        String username = (String) principals.getPrimaryPrincipal();
        //ͨ��service��ȡ��ɫ��Ȩ��
        //List<Map<String, Object>> permissionsList = userService.selectPermissionsByUsername(username);
        //Set<String> permissions = new HashSet<>();
        //for (Map<String, Object> map : permissionsList) {
        //permissions.add(ObjectUtils.toString(map.get("permissionCode")));
        //        }

        Set<String> roles = userService.selectRolesByUsername(username);

        //��Ȩ����
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        //��ͨ��service��ȡ���Ľ�ɫ��Ȩ�޷Ž�ȥ
        //info.setStringPermissions(permissions);
        info.setRoles(roles);
        return info;
    }

    /**
     * ��¼Ȩ��
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String userName = (String) token.getPrincipal();
        User user = userService.findByUserName(userName);
        if (user != null) {
            return new SimpleAuthenticationInfo(user.getUserName(),
                    user.getPassword(), "x");
        } else {
            return null;
        }
    }

}
