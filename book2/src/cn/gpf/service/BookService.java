package cn.gpf.service;

import cn.gpf.pojo.Book;
import cn.gpf.utils.PageBean;

public interface BookService {
	
	
	void pageQueryBooks(PageBean pagebean);

	void save(Book book);

	void deleteBatch(String ids);

	void update(Book book);

	Book findByName(String bookname);

	Book findById(Integer bid);

		

}
