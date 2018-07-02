package com.shaw.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shaw.Bean.Employee;
import com.shaw.Bean.EmployeeExample;
import com.shaw.Bean.EmployeeExample.Criteria;
import com.shaw.Dao.EmployeeMapper;

@Service
public class EmployeeService {

	// 注入员工持久层
	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工信息
	 * 
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 插入新数据
	 * 
	 * @param employee
	 */
	public void saveEmployee(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insert(employee);
	}

	/**
	 * 检查用户名是否重复
	 * 
	 * @param empName
	 * @return true：代表当前数据库不存在这条记录
	 */
	public boolean CheckUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 通过Id查找用户信息
	 * 
	 * @param empId
	 * @return
	 */
	public Employee GetEmployee(Integer empId) {

		Employee employee = employeeMapper.selectByPrimaryKey(empId);
		System.out.println("参数" + empId);
		return employee;
	}

	/**
	 * 更新员工信息
	 * 
	 * @param employee
	 */
	public void UpdateEmployee(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	/**
	 * 单个删除员工信息
	 * 
	 * @param empId
	 */
	public void delEmployee(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}

	/**
	 * 批量删除员工信息
	 * 
	 * @param list
	 */
	public void BatchDel(List<String> list) {
		EmployeeExample example = new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpNameIn(list);
		employeeMapper.deleteByExample(example);

	}

}
