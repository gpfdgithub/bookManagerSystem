package cn.gpf.service.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.gpf.dao.BookDao;
import cn.gpf.pojo.Book;
import cn.gpf.service.BookService;
import cn.gpf.utils.PageBean;

@Service
@Transactional
public class BookServiceImpl implements BookService{
	
	@Autowired
	private BookDao bookDao;

	@Override
	public void pageQueryBooks(PageBean pagebean) {

		bookDao.queryPageBean(pagebean);;
	}

	public void save(Book book) {

		bookDao.save(book);
	}

	@Override
	public void deleteBatch(String ids) {

		String[] idss=ids.split(",");
		
		for(String id:idss)
		{
			int intid=Integer.parseInt(id);
			
			bookDao.deleteById(intid);
		}
		
		
	}

	@Override
	public void update(Book book) {

		bookDao.update(book);
	}

	@Override
	public Book findByName(String bookname) {
		
		
		return bookDao.findOneByName(bookname);
	}

	
	

}
