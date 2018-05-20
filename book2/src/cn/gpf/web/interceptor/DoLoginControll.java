package cn.gpf.web.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class DoLoginControll extends MethodFilterInterceptor{

	@Override
	protected String doIntercept(ActionInvocation action) throws Exception {
		
		
		System.out.println("½øÈëÀ¹½ØÆ÷");
		
		action.invoke();
		
		
		return null;
	}
	

}
