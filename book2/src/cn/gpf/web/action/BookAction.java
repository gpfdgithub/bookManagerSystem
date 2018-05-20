package cn.gpf.web.action;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.gpf.pojo.Book;
import cn.gpf.service.BookService;
import cn.gpf.utils.PageBean;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
public class BookAction extends ActionSupport implements ModelDriven<Book>{
	
	private Integer page;
	
	private Integer rows;
	
	private String ids;
	
	private Book book=new Book();
	
	//查找条件
	
	@Autowired
	private BookService bookService;

	public String pageQuery() throws IOException
	{
		
		PageBean pagebean=new PageBean();
		
		pagebean.setPageSize(rows);
		
		pagebean.setCurrentPage(page);
		
		DetachedCriteria dc=DetachedCriteria.forClass(Book.class);
		
		if(StringUtils.isNotBlank(book.getName()))
		{
			dc.add(Restrictions.like("name","%"+book.getName()+"%"));
		}
		if(StringUtils.isNotBlank(book.getAuthor()))
		{
			dc.add(Restrictions.like("author","%"+book.getAuthor()+"%"));
		}
		if(StringUtils.isNotBlank(book.getType()))
		{
			dc.add(Restrictions.like("type","%"+book.getType()+"%"));
		}
		
		pagebean.setDetachedCriteria(dc);
		
		bookService.pageQueryBooks(pagebean);
		
		//pagebean对象封装完 解析为json格式
		JsonConfig jsonConfig = new JsonConfig();
		
		jsonConfig.setExcludes(new String[]{"currentPage","detachedCriteria","pageSize","bookRecords","bookUser"});
		
		String json = JSONObject.fromObject(pagebean,jsonConfig).toString();
		
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		
		ServletActionContext.getResponse().getWriter().print(json);
		
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		
		
		return NONE;
	}
	
	public String add() throws IOException
	{
		bookService.save(book);
		
		String str="1";
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		response.getWriter().print(str);
		
		return NONE;
	}
	
	public String deleteBatch()
	{
		bookService.deleteBatch(ids);
		
		return "Bookpage";
	}
	
	public String edit() throws IOException
	{
		
		bookService.update(book);
		
		String str="1";
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		response.getWriter().print(str);
		
		return NONE;
	}
	

	
	
	
	
	
	
	
	
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

	@Override
	public Book getModel() {
		return book;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}
	

}
