package cn.gpf.dao;

import java.util.List;

import cn.gpf.pojo.Book;
import cn.gpf.pojo.Record;
import cn.gpf.pojo.User;

public interface RecordDao extends BaseDao<Record>{

	List<Integer> findBookIdsByUserId(Integer user_id);

	List<Record> findBooksByUser(User uu);

	Record findRecordBybook(Book book);

}
