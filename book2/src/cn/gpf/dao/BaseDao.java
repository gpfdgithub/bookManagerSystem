package cn.gpf.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import cn.gpf.utils.PageBean;

public interface BaseDao<T>{

	public void save(T title);
	public void delete(T title);
	public void update(T title);
	public T findById(Serializable id);
	public void deleteById(Serializable id);
	public List<T> findAll();
	public T findOneByName(String name);
	public void queryPageBean(PageBean pagebean);
}
