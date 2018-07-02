package com.shaw.Controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shaw.Bean.Employee;
import com.shaw.Service.EmployeeService;
import com.shaw.Utils.Msg;

@Controller
public class EmployeeController {

	// 注入员工服务器
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping("/goList")
	public String goList() {
		return "ListWithJson";
	}

	// @ResponseBody可以将数据转换为json数据
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 引入分页插件PageHelper分页
		// 调用分页插件，传入页码以及每页数量
		PageHelper.startPage(pn, 10);
		// 插件后面的查询就是分页查询
		List<Employee> list = employeeService.getAll();
		// 使用PageInfo包装查询，只要将PageInfo交给页面
		// 封装了详细的分页信息，包括有我们查询的数据，传入连续显示的页码数
		@SuppressWarnings({ "unchecked", "rawtypes" })
		PageInfo page = new PageInfo(list, 5);
		return Msg.Success().add("page", page);
	}

	/**
	 * @param empName
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/checkName", method = RequestMethod.GET)
	@ResponseBody
	public Msg CheckName(@RequestParam("empName") String empName) throws UnsupportedEncodingException {
		// GET请求需要前端2次转码，后端解码
		String decode = URLDecoder.decode(empName, "UTF-8");

		// 后端验证，使用正则表达式匹配
		String regName = "(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if (!decode.matches(regName)) {
			return Msg.Failure().add("msg", "用户名必须是6到16位数字字母或者2到5位汉字");
		}
		boolean flag = employeeService.CheckUser(decode);
		if (flag) {
			return Msg.Success();
		} else {
			// 用户名查询不为0时，即存在
			return Msg.Failure().add("msg", "用户名已经存在");
		}

	}

	/**
	 * POST方法增加员工
	 * 
	 * @param employee
	 *            得到form表单从请求发送的实体数据并开启验证@Valid
	 * @param bindingResult
	 *            绑定验证消息，封装验证结果发送给页面
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg insertEmp(@Valid Employee employee, BindingResult bindingResult) {
		// 判断是否有绑定结果的错误消息
		if (bindingResult.hasErrors()) {
			// 得到所有的错误消息
			List<FieldError> fieldErrors = bindingResult.getFieldErrors();
			// 构建存储错误的容器
			HashMap<String, Object> map = new HashMap<String, Object>();
			// 遍历
			for (FieldError fieldError : fieldErrors) {

				// 错误信息名
				String ErrorName = fieldError.getField();
				// 错误信息值
				String ErrorMsg = fieldError.getDefaultMessage();

				// 将错误字段存入容器
				map.put(ErrorName, ErrorMsg);
			}
			// 存在错误返回失败消息
			return Msg.Failure().add("Error", map);
		} else {
			employeeService.saveEmployee(employee);
			return Msg.Success();
		}
	}

	/**
	 * GET方法 查询员工
	 * 
	 * @param empId
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.GET)
	@ResponseBody
	public Msg selectEmp(@PathVariable("empId") Integer empId) {
		// 从业务层获取员工对象
		Employee employee = employeeService.GetEmployee(empId);
		return Msg.Success().add("Emp", employee);
	}

	/**
	 * PUT方法Id修改员工信息
	 * 
	 * 
	 * 问题： 使用PUT请求
	 * 
	 * 1.Employee [empId=1036, empName=null, gender=null,
	 * email=null,dId=null,department=null]
	 * 
	 * 2.参数全部为空，使得SQL动态拼接为 update tbl_emp where emp_id = ? 于是报错
	 * 
	 * 原因： tomcat
	 * 
	 * 1.将请求体中的数据封装成一个Map，
	 * 
	 * 2.request.getParameter("empName")就会从这个Map中获取
	 * 
	 * 3.SpringMVC封装对象的时候，会把对象中每一个值request.getParameter
	 * 
	 * 4.PUT请求被Tomcat接收不会封装执行request.getParameter语句
	 * 
	 * 解决方式： 1.我们需要在web.xml配置上一个过滤PUT请求的过滤器，HttpPutFormContentFilter
	 * 
	 * 作用：
	 * 
	 * 1.将请求体中的数据请求解析包装一个成Map，request被重新包装，request.getParameter被重写，就会从自己封装的Map中获得数据
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
		System.out.println(employee);
		employeeService.UpdateEmployee(employee);
		return Msg.Success();
	}

	/**
	 * DELETE请求根据ID删除员工
	 * 
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.DELETE)
	@ResponseBody
	// 将地址变量包装成形参
	public Msg deleteEmp(@PathVariable("empId") Integer empId) {
		employeeService.delEmployee(empId);
		return Msg.Success();

	}

	/**
	 * DELETE请求根据姓名批量删除员工
	 * 
	 * @return
	 */
	@RequestMapping(value = "/bemp/{empName}", method = RequestMethod.DELETE)
	@ResponseBody
	// 将地址变量包装成形参
	public Msg deleteEmp(@PathVariable("empName") String empName) {
		List<String> list = new ArrayList<String>();
		String[] split = empName.split(",");
		for (String string : split) {
			list.add(string);
		}

		employeeService.BatchDel(list);
		return Msg.Success();

	}

	/**
	 * 查询员工列表，使用分页查询
	 * 
	 * @param pn
	 * @return
	 */
	// @RequestMapping("/emps")
	// public String toEmployeeList(@RequestParam(value = "pn", defaultValue = "1")
	// Integer pn, Model model) {
	// // 引入分页插件PageHelper分页
	// // 调用分页插件，传入页码以及每页数量
	// PageHelper.startPage(pn, 5);
	// // 插件后面的查询就是分页查询
	// List<Employee> list = employeeService.getAll();
	// // 使用PageInfo包装查询，只要将PageInfo交给页面
	// // 封装了详细的分页信息，包括有我们查询的数据，传入连续显示的页码数
	// PageInfo page = new PageInfo(list, 5);
	// model.addAttribute("page", page);
	// return "EmployeeList";
	// }
}
