package cn.gpf.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.gpf.dao.RecordDao;
import cn.gpf.pojo.Record;
import cn.gpf.service.RecordService;
import cn.gpf.utils.PageBean;

@Service
@Transactional
public class RecordServiceImpl implements RecordService {

	@Autowired
	private RecordDao recordDao;

	
	public void save(Record re)
	{
		recordDao.save(re);
	}
	
	
	
	
	public RecordDao getRecordDao() {
		return recordDao;
	}

	public void setRecordDao(RecordDao recordDao) {
		this.recordDao = recordDao;
	}







	@Override
	public void pageQueryBooks(PageBean pagebean) {

		recordDao.queryPageBean(pagebean);
	}



















	@Override
	public void deleteInBatch(String ids) {
			
		String[] idd=ids.split(",");
		
		for(String id:idd)
		{
			recordDao.deleteById(Integer.parseInt(id));
		}
		
	}
	
}
