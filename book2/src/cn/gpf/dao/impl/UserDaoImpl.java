package cn.gpf.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Repository;

import cn.gpf.dao.UserDao;
import cn.gpf.pojo.User;
import cn.gpf.utils.PageBean;

@Repository
public class UserDaoImpl extends BaseDaoimpl<User> implements UserDao {

	@Override
	public User getUserByPasswordAndUsername(String password, String username) {

		String hql="from User where password=? and username=?";
		
		List<User> list = (List<User>) getHibernateTemplate().find(hql, password,username);
		
		
		if(list != null && list.size() > 0){
			return list.get(0);
		}
		
		return null;
	}

	

}
