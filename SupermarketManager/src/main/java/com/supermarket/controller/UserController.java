package com.supermarket.controller;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.supermarket.entity.Menu;
import com.supermarket.entity.User;
import com.supermarket.entity.UserRole;
import com.supermarket.service.MenuService;
import com.supermarket.service.UserRoleService;
import com.supermarket.service.UserService;
import com.supermarket.util.ResponseUtil;

@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;

    @Resource
    private MenuService menuService;

    @Resource
    private UserRoleService userRoleService;

    /**
     * �û���½
     */
    @ResponseBody
    @RequestMapping("/login")
    public Map<String, Object> login(String imageCode, HttpSession session, User user) {
        Map<String, Object> map = new HashMap<>(2);
        if (!session.getAttribute("checkcode").equals(imageCode)) {
            map.put("success", false);
            map.put("errorInfo", "��֤���������!");
            return map;
        }
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(), user.getPassword());
        try {
            subject.login(token);
            String userName = (String) SecurityUtils.getSubject().getPrincipal();
            User currentUser = userService.findByUserName(userName);
            List<Menu> menuList = menuService.allMenuList();
            session.setAttribute("menuList", menuList);
            session.setAttribute("currentUser", currentUser);
            map.put("success", true);
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("errorInfo", "�û��������������!");
            return map;
        }
    }

    /**
     * ��ѯ�����û� ����������
     */
    @ResponseBody
    @RequestMapping("/userList")
    public Map<String, Object> userList(User user, @RequestParam(value = "page", required = false) Integer page,
                                        @RequestParam(value = "limit", required = false) Integer limit) {
        Map<String, Object> result = ResponseUtil.resultFye(page, limit);
        if (user.getUserName() != null) {
            String userName = new String(user.getUserName().getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            result.put("userName", userName);
        }
        List<User> userList = userService.findAll(result);
        Long count = userService.count(result);
        return ResponseUtil.result(userList, count);
    }

    /**
     * ����û�
     */
    @ResponseBody
    @RequestMapping("/add")
    public Map<String, Object> add(User user) {
        Map<String, Object> result = new HashMap<>(2);
        try {
            User userName = userService.findByUserName(user.getUserName());
            if (userName == null) {
                userService.add(user);
                Integer s = user.getRoleId();
                UserRole userRole = new UserRole();
                userRole.setRoleId(s);
                userRole.setUserId(user.getId());
                userRoleService.add(userRole);
                result.put("success", true);
            } else {
                result.put("success", false);
                result.put("errorInfo", "�û����Ѵ��ڣ�");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("errorInfo", "ϵͳ�ڲ��쳣�����ʧ�ܣ�����ϵ����Ա��");
        }

        return result;
    }

    /**
     * ɾ���û� ���н�ɫ��Ӧ  ɾ����ɫ��Ӧ��ϵ
     */
    @ResponseBody
    @RequestMapping("/delete")
    public Map<String, Object> delete(@RequestParam(value = "id", required = false) Integer id) {
        Map<String, Object> result = new HashMap<>(2);
        userService.delete(id);
        userRoleService.delete(id);
        result.put("success", true);
        return result;
    }

    /**
     * �����û���Ϣ
     * ���½�ɫ ɾ��֮ǰ�Ķ�Ӧ��ϵ ����µĶ�Ӧ��ϵ
     */
    @ResponseBody
    @RequestMapping("/update")
    public Map<String, Object> update(User user) {
        Map<String, Object> result = new HashMap<>(2);
        UserRole userRole = userRoleService.findAll(user.getUserName());
        if (userRole.getRoleId().equals(user.getRoleId())) {
            userService.update(user);
        } else {
            userService.update(user);
            userRoleService.delete(user.getId());
            userRole.setRoleId(user.getRoleId());
            userRole.setUserId(user.getId());
            userRoleService.add(userRole);
        }
        result.put("success", true);
        return result;
    }

    /**
     * ��������
     */
    @ResponseBody
    @RequestMapping("/reset")
    public Map<String, Object> reset(@RequestParam(value = "id", required = false) Integer id) {
        Map<String, Object> result = new HashMap<>(2);
        userService.updateReset(id);
        result.put("success", true);
        return result;
    }

    @RequestMapping("/logout")
    public String logout() {
        SecurityUtils.getSubject().logout();
        return "redirect:/login.jsp";
    }

    @ResponseBody
    @RequestMapping("/updatepswd")
    public Map<String, Object> updatepswd(User user) {
        Map<String, Object> result = new HashMap<>(2);
        userService.update(user);
        result.put("success", true);
        return result;
    }

}
