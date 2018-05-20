package cn.gpf.web.action;

import java.io.IOException;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

import cn.gpf.pojo.Book;
import cn.gpf.pojo.Record;
import cn.gpf.service.BookService;
import cn.gpf.service.RecordService;
import cn.gpf.utils.PageBean;
import cn.gpf.utils.RecordPageBean;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
@Controller
@Scope("prototype")
public class RecordAction extends ActionSupport{
	
	
	private String bookname;
	
	private String username;
	
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
	
	@Autowired
	private BookService bookService;
	
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

}
