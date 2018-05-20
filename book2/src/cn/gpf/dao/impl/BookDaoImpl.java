package cn.gpf.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import cn.gpf.dao.BookDao;
import cn.gpf.pojo.Book;

@Repository
@Transactional(readOnly=false)
public class BookDaoImpl extends BaseDaoimpl<Book> implements BookDao{

	


}
