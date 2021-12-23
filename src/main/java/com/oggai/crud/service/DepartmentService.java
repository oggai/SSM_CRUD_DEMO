package com.oggai.crud.service;

import com.oggai.crud.bean.Department;
import com.oggai.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @BelongsProject: ssm_crud_demo
 * @BelongsPackage: com.oggai.crud.service
 * @Author: oggai
 * @Date: 2021/12/18 16:13
 * @Description: TODO
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;


    public List<Department> getDepartments() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
