package cn.gpf.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.transaction.annotation.Transactional;

import cn.gpf.dao.BaseDao;
import cn.gpf.pojo.Book;
import cn.gpf.utils.PageBean;
@Transactional(readOnly=false)
public class BaseDaoimpl<T> extends HibernateDaoSupport implements BaseDao<T>{

	private Class entityClass;
	
	@Resource(name="sessionFactory")
	public void setMySessionFac(SessionFactory sf)
	{
		super.setSessionFactory(sf);
		
	}
	public BaseDaoimpl()
	{
		ParameterizedType superclass = (ParameterizedType) this.getClass().getGenericSuperclass();
		Type[] arguments = superclass.getActualTypeArguments();
		entityClass=(Class) arguments[0];
	}

	@Override
	public void save(T title) {
		
		getHibernateTemplate().save(title);
	}

	@Override
	public void delete(T title) {
		
		getHibernateTemplate().delete(title);
		
	}

	@Override
	public void update(T title) {
		
		getHibernateTemplate().update(title);
		
	}

	@Override
	public T findById(Serializable id) {
		
		return (T) getHibernateTemplate().get(entityClass, id);
	}


	@Override
	public List<T> findAll() {

		DetachedCriteria dc=DetachedCriteria.forClass(entityClass);
		return (List<T>) getHibernateTemplate().findByCriteria(dc);
	}
	@Override
	public void queryPageBean(PageBean pagebean) {

		Integer currentPage = pagebean.getCurrentPage();
		
		DetachedCriteria dc = pagebean.getDetachedCriteria();
		
		Integer size = pagebean.getPageSize();
		
		dc.setProjection(Projections.rowCount());
		
		List<Long> list = (List<Long>) getHibernateTemplate().findByCriteria(dc);
		
		Long total=list.get(0);
		
		pagebean.setTotal(total.intValue());
		
		dc.setProjection(null);
		
		dc.setResultTransformer(DetachedCriteria.ROOT_ENTITY);
		
		int firstResult=(currentPage-1)*size;
		
		int maxResults=size;
		
		List list2 = getHibernateTemplate().findByCriteria(dc, firstResult, maxResults);
		
		pagebean.setRows(list2);
		
	}
	@Override
	public void deleteById(Serializable id) {
		
		T t = findById(id);
		
		delete(t);

	}
	@Override
	public T findOneByName(String name) {
		
		DetachedCriteria dc=DetachedCriteria.forClass(entityClass);
		
		dc.add(Restrictions.like("name","%"+name+"%"));
		
		List<T> list = (List<T>) getHibernateTemplate().findByCriteria(dc);
		
		if(list!=null&&list.size()>0)
		{
			return list.get(0);
		}
		
		return null;
		
	}

	





	

	



}
