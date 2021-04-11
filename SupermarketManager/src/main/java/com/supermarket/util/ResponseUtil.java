package com.supermarket.util;

import com.supermarket.entity.Employees;
import com.supermarket.service.EmpService;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public class ResponseUtil {
	
	public static void write(HttpServletResponse response, Object o) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(o.toString());
		out.flush();
		out.close();
	}

	public static Map<String, Object> resultFye(Integer page, Integer limit) {
		Map<String, Object> map = new HashMap<>(2);
		if(page == null){
			map.put("page",0);
		}else {
			map.put("page", page * 10 - 10);
		}
		map.put("limit", limit);
		return map;
	}
	
	public static Map<String, Object> result(Object data,Object count) {
		Map<String, Object> result = new HashMap<>(4);
		result.put("code", 0);
		result.put("msg", "");
		result.put("data", data);
		result.put("count", count);
		return result;
	}


	public static List<Map<String, Object>> getEmpResultList(List<Employees> empList, EmpService empService) {
		List<Map<String, Object>> resultList = new ArrayList<>();
		Map<String, Object> empMap;
		for (Employees employees : empList) {
			empMap = new HashMap<>(16);
			empMap.put("id", employees.getEmpId());
			empMap.put("empName", employees.getEmpName());
			empMap.put("empNativePlace", employees.getEmpNativePlace());
			empMap.put("empAddr", employees.getEmpAddr());
			empMap.put("empPhone", employees.getEmpPhone());
			empMap.put("empIdentity", employees.getEmpIdentity());
			if (employees.getEmpSex() == 0) {
				empMap.put("empSex", "Å®");
			} else if (employees.getEmpSex() == 1) {
				empMap.put("empSex", "ÄÐ");
			} else {
				empMap.put("empSex", null);
			}
			empMap.put("deptId", employees.getDeptId());
			empMap.put("empDept", empService.findDeptName(employees.getDeptId()));
			empMap.put("empDescribe", employees.getEmpDescribe());
			resultList.add(empMap);
		}
		return resultList;
	}
}
