package cn.gpf.service;

import java.util.List;

import cn.gpf.pojo.Book;
import cn.gpf.pojo.Record;
import cn.gpf.pojo.User;
import cn.gpf.utils.PageBean;

public interface RecordService {
	
	void save(Record re);

	void pageQueryBooks(PageBean pagebean);

	void deleteInBatch(String ids);

	List<Integer> findBookIdsbelongLoginUser(Integer user_id);

	List<Record> findRecordByUser(User uu);

	Record findRecordByBook(Book book);

	void update(Record rd);


}
