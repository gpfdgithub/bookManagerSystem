package cn.gpf.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.gpf.dao.UserDao;
import cn.gpf.pojo.User;
import cn.gpf.utils.PageBean;


public interface UserService {

	User getUserBuPasswordAndUsername(String password, String username);

	void  update(User user);

	void pageQueryUsers(PageBean pagebean);

	void save(User user);

	void deleteBatch(String ids);

	
}
