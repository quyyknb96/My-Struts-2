package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.UserDAO;
import entity.User;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.interceptor.validation.SkipValidation;

import java.util.Map;

public class LoginAction extends ActionSupport implements SessionAware {
    private String username;
    private String password;
    private Map<String,Object> session;

    public void validate(){
        if(this.username.length() == 0){
            addFieldError("username","Username is required");
        }
        if(this.password.length() == 0) {
            addFieldError("password","Password is required");
        }
    }

    public String execute(){
        UserDAO userDAO = new UserDAO();
        User user = userDAO.checkLogin(this.username,this.password);
        if (user != null){
            getSession().put("user",user);
            return "success";
        }else {
            addActionError("Login fail");
            return "error";
        }
    }

    @SkipValidation
    public String logout(){
        session.remove("user");
        return "logout";
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public void setSession(Map<String, Object> map) {
        this.session = map;
    }

    public Map<String, Object> getSession() {
        return session;
    }
}
