package cn.gpf.web.action;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.gpf.pojo.Book;
import cn.gpf.pojo.Record;
import cn.gpf.pojo.User;
import cn.gpf.service.BookService;
import cn.gpf.service.RecordService;
import cn.gpf.utils.PageBean;
import cn.gpf.utils.RecordPageBean;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
@Controller
@Scope("prototype")
public class RecordAction extends ActionSupport implements ModelDriven<Record>{
	
	
	private String bookname;
	
	private String username;
	
	private Integer book_id;
	
	@Autowired
	private BookService bookservice;
	


	public void setBookservice(BookService bookservice) {
		this.bookservice = bookservice;
	}


	public void setBook_id(Integer book_id) {
		this.book_id = book_id;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	private Integer page;
	
	public String getBookname() {
		return bookname;
	}


	public void setBookname(String bookname) {
		this.bookname = bookname;
	}


	private Integer rows;
	
	private String ids;
	
	
	public Integer getPage() {
		return page;
	}


	public void setPage(Integer page) {
		this.page = page;
	}


	public Integer getRows() {
		return rows;
	}


	public void setRows(Integer rows) {
		this.rows = rows;
	}


	public String getIds() {
		return ids;
	}


	public void setIds(String ids) {
		this.ids = ids;
	}


	@Autowired
	private RecordService recordService;

	private Record record=new Record();
	
	
	public String pageQuery() throws IOException
	{
		PageBean pagebean=new PageBean();
		
		pagebean.setPageSize(rows);
		
		pagebean.setCurrentPage(page);
		
		DetachedCriteria dc=DetachedCriteria.forClass(Record.class);
		
		if(StringUtils.isNotBlank(bookname))
		{
				dc.createAlias("book","b");
				dc.add(Restrictions.like("b.name","%"+bookname+"%"));
		}
		if(StringUtils.isNotBlank(username))
		{
				dc.createAlias("user","u");
				dc.add(Restrictions.like("u.username","%"+username+"%"));
		}
		
		pagebean.setDetachedCriteria(dc);
		
		recordService.pageQueryBooks(pagebean);
	
		JsonConfig jsonConfig = new JsonConfig();
		
		jsonConfig.setExcludes(new String[]{"currentPage","detachedCriteria","pageSize","bookUser","bookRecords","books","records"});
		
		String json = JSONObject.fromObject(pagebean,jsonConfig).toString();
		
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		
		ServletActionContext.getResponse().getWriter().print(json);
		
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		
		return NONE;
	}
	public String deleteBatch()
	{
		recordService.deleteInBatch(ids);
		
		return "showRecord";
	}
	
	public String borrow() throws IOException
	{
		String str="1";
		
		record.setBorrowDate(new Date());
		
		Book book = bookservice.findById(book_id);
		
		book.setIsBorrow(true);
		
		bookservice.update(book);
		
		record.setBook(book);
		
		User uu = (User) ServletActionContext.getRequest().getSession().getAttribute("loginUser");
		
		if(uu!=null)
		{
			record.setUser(uu);
			
			recordService.save(record);
		}
		else
		{
			str="2";
		}
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		response.getWriter().print(str);
		return NONE;
	}
	
	public String editRecord() throws IOException
	{
		//»¹ÊéµÄ
		Book book = bookservice.findById(book_id);
		
		book.setIsBorrow(false);
		
		bookservice.update(book);
		
		Record rd=recordService.findRecordByBook(book);
		
		rd.setReturnDate(new Date());
		
		recordService.update(rd);
		
		String str="1";
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		response.getWriter().print(str);
		
		return NONE;
	}

	@Override
	public Record getModel() {
		// TODO Auto-generated method stub
		return record;
	}

}
