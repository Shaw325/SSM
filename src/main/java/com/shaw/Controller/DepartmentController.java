package com.shaw.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shaw.Bean.Department;
import com.shaw.Service.DepartmentService;
import com.shaw.Utils.Msg;

/**
 * 处理部门相关的请求
 * 
 * @author Cami
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;

	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> list = departmentService.getAllDepts();
		return Msg.Success().add("list", list);

	}
}
