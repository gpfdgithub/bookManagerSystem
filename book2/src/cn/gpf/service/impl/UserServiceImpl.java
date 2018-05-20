package cn.gpf.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.gpf.dao.UserDao;
import cn.gpf.pojo.User;
import cn.gpf.service.UserService;
import cn.gpf.utils.PageBean;
@Service
@Transactional
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;

	@Override
	public User getUserBuPasswordAndUsername(String password, String username) {

		
		return userDao.getUserByPasswordAndUsername(password,username);
	}

	@Override
	public void update(User user) {

		userDao.update(user);
	}

	@Override
	public void pageQueryUsers(PageBean pagebean) {

		userDao.queryPageBean(pagebean);
	}

	@Override
	public void save(User user) {

		userDao.save(user);
	}

	@Override
	public void deleteBatch(String ids) {

		String[] idss=ids.split(",");
		
		for(String id:idss)
		{
			int intid=Integer.parseInt(id);
			
			userDao.deleteById(intid);
		}
	}


}
