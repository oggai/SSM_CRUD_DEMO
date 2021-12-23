package com.oggai.crud.service;

import com.oggai.crud.bean.Employee;
import com.oggai.crud.bean.EmployeeExample;
import com.oggai.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @BelongsProject: ssm_crud_demo
 * @BelongsPackage: com.oggai.crud.service
 * @Author: oggai
 * @Date: 2021/12/17 9:32
 * @Description: TODO
 */
@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;


    public List<Employee> getAll() {
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        return employees;
    }

    /**
     * @author oggai
     * @date 2021/12/22 10:58
     * @description 若存在该用户名，返回 false
     * @param employeeName
     * @return boolean
     */
    public boolean checkEmployee(String employeeName) {

        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(employeeName);

        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    public void saveEmployee(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public Employee getEmployeeById(Integer id) {

        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmployee(Employee employee) {

        // updateByPrimaryKeySelective 已经在 sql 语句后面添加了条件：where emp_id = #{empId,jdbcType=INTEGER}
         employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmployee(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteEmployeeBatch(List<Integer> integerList) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(integerList);

        employeeMapper.deleteByExample(employeeExample);
    }
}
