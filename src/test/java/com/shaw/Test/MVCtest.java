package com.shaw.Test;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.shaw.Dao.EmployeeMapper;

/**
 * 使用Spring测试模块提供的请求功能，测试curd请求的正确性
 * 
 * @author Cami
 *
 */
@RunWith(value = SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml", "classpath:springmvc.xml" })
public class MVCtest {
	// 传入springmvc的ioc容器
	@Autowired
	WebApplicationContext context;
	// 虚拟mvc请求，获取处理结果
	MockMvc mockMvc;

	@Autowired
	EmployeeMapper employeeMapper;

	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void test() throws Exception {
		// 模拟请求拿到返回值
		// MvcResult result =
		// mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn",
		// "5")).andReturn();
		// // 请求成功后，请求域中会有PageInfo，我们可以取出PageInfo进行验证
		// MockHttpServletRequest request = result.getRequest();
		// PageInfo page = (PageInfo) request.getAttribute("page");
		// System.out.println("当前页码：" + page.getPageNum());
		// System.out.println("总页码：" + page.getPages());
		// System.out.println("总记录数：" + page.getTotal());
		// System.out.println("在页面需要连续显示的页码");
		// int[] nums = page.getNavigatepageNums();
		// for (int i : nums) {
		// System.out.print(" " + i);
		// }
		// List<Employee> list = page.getList();
		// for (Employee employee : list) {
		// System.out.println("员工姓名：" + employee.getEmpName());
		// }
	}
}
