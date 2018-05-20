package cn.gpf.web.action;

import java.io.IOException;

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
import cn.gpf.pojo.User;
import cn.gpf.service.UserService;
import cn.gpf.utils.PageBean;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
@Controller
@Scope("prototype")
public class UserAction extends ActionSupport implements ModelDriven<User>{

	private User user=new User();
	
	private String checkcode;
	
	private Integer page;
	
	private Integer rows;
	
	private String ids;
	
	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	@Autowired
	private UserService userService;

	@Override
	public User getModel() {
		return user;
	}
	
	public String Login() throws IOException
	{
		//登陆成功向session里添加数据
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		
		String val = (String) session.getAttribute("key");
		
		if(StringUtils.isNotBlank(checkcode)&&val.equals(checkcode))
		{
			User uu=userService.getUserBuPasswordAndUsername(user.getPassword(),user.getUsername());
			
			if(uu==null)
			{
				this.addActionError("用户名或密码不正确！");
				return "failureLogin";
			}
			else
			{
				ServletActionContext.getRequest().getSession().setAttribute("loginUser",uu);
				ServletActionContext.getResponse().getWriter().write("成功登陆");
				return "successLogin";
			}
			
			
		}
		else
		{
			this.addActionError("验证码输入错误！");
			return "failureLogin";
		}
			
		
	}
	
	public String loginOut()
	{
		ServletActionContext.getRequest().getSession().invalidate();
		
		return "loginout";
	}
	
	
	public String pageQuery() throws IOException
	{
		PageBean pagebean=new PageBean();
		
		pagebean.setPageSize(rows);
		
		pagebean.setCurrentPage(page);
		
		DetachedCriteria dc=DetachedCriteria.forClass(User.class);
		
		if(StringUtils.isNoneBlank(user.getUsername()))
		{
			dc.add(Restrictions.ilike("username","%"+user.getUsername()+"%"));
			
		}
	
		pagebean.setDetachedCriteria(dc);
		
		userService.pageQueryUsers(pagebean);
		
		//pagebean对象封装完 解析为json格式
		JsonConfig jsonConfig = new JsonConfig();
		
		jsonConfig.setExcludes(new String[]{"currentPage","detachedCriteria","pageSize","books","records"});
		
		String json = JSONObject.fromObject(pagebean,jsonConfig).toString();
		
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		
		ServletActionContext.getResponse().getWriter().print(json);
		
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		
		
		
		return NONE;
	}
	public String editPassword()
	{
		User uu = (User) ServletActionContext.getRequest().getSession().getAttribute("loginUser");
		
		try {
			
			ServletActionContext.getResponse().getWriter().write("1");
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
		
		uu.setPassword(user.getPassword());
		
		userService.update(uu);
		//发送的是ajax请求不需要刷新页面 也就不需要跳转
		return NONE;
	}
	
	public String add() throws IOException
	{
		userService.save(user);
		String str="1";
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		response.getWriter().print(str);
		
		return NONE;
	}
	
	public String deleteBatch()
	{
		userService.deleteBatch(ids);
		
		return "showUsersBypage";
		
	}
	
	public String edit() throws IOException
	{
		userService.update(user);
		String str="1";
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		response.getWriter().print(str);
		return NONE;
	}
	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
	}
	
	
}














