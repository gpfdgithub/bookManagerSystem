package cn.gpf.service;

import cn.gpf.pojo.Record;
import cn.gpf.utils.PageBean;

public interface RecordService {
	
	void save(Record re);

	void pageQueryBooks(PageBean pagebean);

	void deleteInBatch(String ids);

}
