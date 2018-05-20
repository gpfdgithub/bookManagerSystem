package cn.gpf.dao;

import java.io.Serializable;
import java.util.List;

import cn.gpf.pojo.User;
import cn.gpf.utils.PageBean;

public interface UserDao extends BaseDao<User> {

	User getUserByPasswordAndUsername(String password, String username);


}
