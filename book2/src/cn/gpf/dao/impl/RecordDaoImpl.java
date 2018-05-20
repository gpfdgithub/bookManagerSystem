package cn.gpf.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate5.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.gpf.dao.RecordDao;
import cn.gpf.pojo.Book;
import cn.gpf.pojo.Record;
import cn.gpf.pojo.User;
import cn.gpf.utils.PageBean;

@Repository
public class RecordDaoImpl extends BaseDaoimpl<Record> implements RecordDao {

	@Override
	public List<Integer> findBookIdsByUserId(final Integer user_id) {
		
		final String sql="select book_b_record_fk form t_record where user_record_fk=?";
		
		List<?> list=(List<?>) getHibernateTemplate().execute(new HibernateCallback<Object>() {

			@Override
			public Object doInHibernate(Session session) throws HibernateException {
				
				SQLQuery query = session.createSQLQuery(sql);
				
				query.setInteger(0,user_id);
				
				List<?> list = query.list();
				
				return list;
			}
		});
		
		return (List<Integer>) list;
		
	}

	@Override
	public List<Record> findBooksByUser(User uu) {
		
		DetachedCriteria dc=DetachedCriteria.forClass(Record.class);
		
		dc.add(Restrictions.eq("user",uu));
		
		
		List<?> list = getHibernateTemplate().findByCriteria(dc);
		
		return (List<Record>) list;
	}

	@Override
	public Record findRecordBybook(Book book) {
		DetachedCriteria dc=DetachedCriteria.forClass(Record.class);
		
		dc.add(Restrictions.eq("book",book));
		
		List<?> list = getHibernateTemplate().findByCriteria(dc);
		
		if(list!=null&&list.size()>0)
		{
			return (Record) list.get(0);
		}
		
		return null;
	}


}
