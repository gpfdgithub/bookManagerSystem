package cn.gpf.junit;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.gpf.dao.BookDao;
import cn.gpf.dao.RecordDao;
import cn.gpf.dao.UserDao;
import cn.gpf.pojo.Book;
import cn.gpf.pojo.Record;
import cn.gpf.pojo.User;
import cn.gpf.service.BookService;
import cn.gpf.service.RecordService;
import cn.gpf.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class DemoTestBySSH {
	
	@Autowired
	private UserService userService;
	@Resource(name="bookDaoImpl")
	private BookDao bookDao;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private RecordService recordService;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private RecordDao recordDao;
	
	@Test
	public void demo1()
	{
		User user = userService.getUserBuPasswordAndUsername("1234","root");
		System.out.println(user);
	}
	
	@Test
	public void demo2()
	{
		
		for(int i=15;i>=0;i--)
		{
			Book book=new Book();
			
			book.setAuthor("jk");
			
			book.setDescription("全新魔法世界");
			
			book.setType("魔幻");
			
			book.setName("哈利波特");
			
			book.setPrice((double) 23);
			
			bookDao.save(book);
		}
		
		
	}
	
	@Test
	public void demo3()
	{
		
		for(int i=15;i>=0;i--)
		{
			
			User user=new User();
			
			user.setPassword("1212");
			
			user.setUsername("gpf");
			
			user.setTelphoneNumber("13474999904");
			
			userDao.save(user);
			
		}
		
		
	}
	@Test
	public void demo4()
	{
		
		for(int i=5;i>=0;i--)
		{
			Book book = bookDao.findById(15);
			
			User user = userDao.findById(1);
			
			Record re=new Record();
			
			re.setBorrowDate(new Date(100,5,15));
			
			re.setReturnDate(new Date(110,6,17));
			
			re.setBook(book);
			
			re.setUser(user);
			
			recordService.save(re);
			
			
		}
		
		
	}
	@Test
	public void demo5()
	{
	/*	List<Integer> ids=recordService.findBookIdsbelongLoginUser(1);
		List<Book> books=new ArrayList<Book>();
		
		if(ids!=null&&ids.size()>0)
		{
			for(Integer bid:ids)
			{
				Book book=bookService.findById(bid);
				books.add(book);
				
			}
		}*/
		User uu = userDao.findById(1);
		
		List<Record> records=recordService.findRecordByUser(uu);
		
		for(Record re:records)
		{
			System.out.println(re.getBook());
		}
		
		
		
	}
	
}
