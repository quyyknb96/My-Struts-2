package interceptors;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.apache.struts2.StrutsStatics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends AbstractInterceptor implements StrutsStatics {

    public void init(){

    }

    public void destroy(){

    }

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        final ActionContext context = actionInvocation.getInvocationContext();
        HttpServletRequest request = (HttpServletRequest) context.get(HTTP_REQUEST);
        HttpSession session = request.getSession(true);

        Object user = session.getAttribute("user");
        if(user == null){
            return "login";
        }else {
            return actionInvocation.invoke();
        }
    }
}
