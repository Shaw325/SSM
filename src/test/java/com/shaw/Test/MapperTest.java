package com.shaw.Test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.shaw.Dao.DepartmentMapper;
import com.shaw.Dao.EmployeeMapper;

/**
 * 测试dao层工作
 * 
 * @author Cami
 *
 *         使用spring的单元测试组件，自动注入容器
 *         1.使用spring注解 @ContextConfiguration指定spring配置文件的位置
 */
@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	/*
	 * 测试DepartmentMapper
	 */
	@Test
	public void test() {
		System.out.println(departmentMapper);

		// 1.插入两个部门
		// departmentMapper.insertSelective(new Department(null, "开发部"));
		// departmentMapper.insertSelective(new Department(null, "测试部"));

		// 2.插入员工
		// employeeMapper.insertSelective(new Employee(null, "Jerry", "M",
		// "Jerry@sina.com", 1));
		// employeeMapper.insertSelective(new Employee(null, "Shery", "F",
		// "Shery@sina.com", 2));

		// 批量插入一千条数据
		// EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		// String name;
		// Random random = new Random();
		// for (int i = 0; i < 1000; i++) {
		// int sex = random.nextInt(2);
		// int dept = random.nextInt(2);
		// name = UUID.randomUUID().toString().substring(0, 5) + i;
		// mapper.insertSelective(
		// new Employee(null, name, sex == 0 ? "M" : "F", name + "@sina.com", dept == 0
		// ? 1 : 2));
		// }
		// System.out.println("执行完成");
	}
}
